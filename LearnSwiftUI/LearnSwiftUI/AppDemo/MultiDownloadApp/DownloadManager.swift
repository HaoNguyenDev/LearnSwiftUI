//
//  DownloadManager.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/9/25.
//

import Foundation
import Combine

/// Delegate to notify about download task states.
public protocol DownloadManagerDelegate: AnyObject {
    func downloadManager(_ manager: DownloadManager, didUpdateProgress progress: Float, forTaskWithURL url: URL)
    func downloadManager(_ manager: DownloadManager, didCompleteTaskWithURL url: URL, atLocation location: URL)
    func downloadManager(_ manager: DownloadManager, didFailTaskWithURL url: URL, withError error: Error)
    func downloadManager(_ manager: DownloadManager, didStartTaskWithURL url: URL)
    func downloadManager(_ manager: DownloadManager, didChangeState state: DownloadState, forTaskWithURL url: URL)
    func downloadManager(_ manager: DownloadManager, didUpdateResumeDataForTaskWithURL url: URL, resumeData: Data?)
}

// MARK: - Download

/// Class representing a download task.
public class Download: NSObject {
    public let url: URL
    public let fileName: String // Replaced destinationURL with fileName for consistency
    public var task: URLSessionDownloadTask?
    public var resumeData: Data?
    public var downloadedBytes: Int64 = 0
    public var totalBytes: Int64 = 0
    
    public init(url: URL, fileName: String) {
        self.url = url
        self.fileName = fileName
        super.init()
    }
    
    // Computed property to dynamically recreate destinationURL
    public var destinationURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent(fileName)
    }
}

// MARK: - DownloadManager

/// A reusable class for managing download tasks.
public class DownloadManager: NSObject, ObservableObject {
    
    public static let shared = DownloadManager()
    
    public weak var delegate: DownloadManagerDelegate?
    
    @Published public var downloadTasks: [DownloadTask] = [] // Stores the list of tasks
    
    private let tasksSaveURL: URL = {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent("downloadTasks.json")
    }()
    
    /// Queue for managing download tasks.
    private lazy var downloadQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "com.myapp.downloadQueue"
        queue.maxConcurrentOperationCount = 5 // Default is 5
        return queue
    }()
    
    /// Dictionary to manage active download tasks.
    public var activeDownloads = [URL: Download]()
    
    public var maxConcurrentDownloads: Int {
        get {
            return downloadQueue.maxConcurrentOperationCount
        }
        set {
            downloadQueue.maxConcurrentOperationCount = newValue
        }
    }
    
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: "com.myapp.backgroundsession")
        config.isDiscretionary = false
        config.sessionSendsLaunchEvents = true
        return URLSession(configuration: config, delegate: self, delegateQueue: downloadQueue)
    }()
    
    private override init() {
        super.init()
        loadTasks() // Load tasks on initialization
    }
    
    // MARK: - Task Management
    
    /// Starts a new download task.
    public func startDownload(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }
        
        // Create fileName and destinationURL
        let fileName = url.lastPathComponent
        let destinationURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(fileName)
        
        // Check if task already exists
        if let existingTask = downloadTasks.first(where: { $0.url == url }) {
            guard existingTask.state != .completed else {
                print("Download for \(url) is already completed.")
                return
            }
            if existingTask.state == .paused && existingTask.resumeData != nil {
                resumeDownload(for: url, withResumeData: existingTask.resumeData)
                return
            }
            // Reset task if not completed or resumable
            existingTask.state = .pending
            existingTask.progress = 0.0
            existingTask.downloadedBytes = 0
            existingTask.totalBytes = 0
            existingTask.resumeData = nil
            existingTask.startTime = Date()
        } else {
            // Check if file exists
            if FileManager.default.fileExists(atPath: destinationURL.path) {
                print("File already exists at destination: \(destinationURL.path). Skipping.")
                return
            }
            let newTask = DownloadTask(url: url, fileName: fileName)
            newTask.state = .pending
            newTask.startTime = Date()
            downloadTasks.append(newTask)
        }
        
        guard activeDownloads[url] == nil else {
            print("Download for \(url) is already active or queued.")
            return
        }
        
        let download = Download(url: url, fileName: fileName)
        download.task = session.downloadTask(with: url)
        download.task?.resume()
        activeDownloads[url] = download
        delegate?.downloadManager(self, didStartTaskWithURL: url)
        saveTasks()
    }
    
    /// Pauses a download task.
    public func pauseDownload(for url: URL) {
        guard let download = activeDownloads[url] else { return }
        download.task?.cancel(byProducingResumeData: { data in
            download.resumeData = data
            self.delegate?.downloadManager(self, didUpdateResumeDataForTaskWithURL: url, resumeData: data)
            self.delegate?.downloadManager(self, didChangeState: .paused, forTaskWithURL: url)
            if let task = self.downloadTasks.first(where: { $0.url == url }) {
                task.state = .paused
                task.resumeData = data
            }
            self.saveTasks()
        })
    }
    
    /// Resumes a download task.
    public func resumeDownload(for url: URL, withResumeData externalResumeData: Data? = nil) {
        guard let download = activeDownloads[url] else {
            print("No active download for \(url).")
            return
        }
        
        let resumeData = externalResumeData ?? download.resumeData
        guard let resumeData = resumeData else {
            // No resumeData, start new
            startDownload(urlString: url.absoluteString)
            return
        }
        
        download.task = session.downloadTask(withResumeData: resumeData)
        download.task?.resume()
        download.resumeData = nil
        delegate?.downloadManager(self, didUpdateResumeDataForTaskWithURL: url, resumeData: nil)
        delegate?.downloadManager(self, didChangeState: .downloading, forTaskWithURL: url)
        if let task = downloadTasks.first(where: { $0.url == url }) {
            task.state = .downloading
            task.resumeData = nil
        }
        saveTasks()
    }
    
    /// Cancels a download task.
    public func cancelDownload(for url: URL) {
        guard let download = activeDownloads[url] else { return }
        download.task?.cancel()
        download.resumeData = nil
        activeDownloads.removeValue(forKey: url)
        if let task = downloadTasks.first(where: { $0.url == url }) {
            task.state = .cancelled
            task.resumeData = nil
        }
        delegate?.downloadManager(self, didChangeState: .cancelled, forTaskWithURL: url)
        delegate?.downloadManager(self, didUpdateResumeDataForTaskWithURL: url, resumeData: nil)
        saveTasks()
    }
    
    /// Deletes a download task and its associated file.
    public func deleteDownload(for url: URL) {
        // Cancel task if active
        cancelDownload(for: url)
        
        // Delete file at destinationURL if it exists
        if let task = downloadTasks.first(where: { $0.url == url }) {
            let filePath = task.destinationURL.path
            if FileManager.default.fileExists(atPath: filePath) {
                do {
                    try FileManager.default.removeItem(at: task.destinationURL)
                    print("File deleted successfully at: \(filePath)")
                } catch {
                    print("Error deleting file at \(filePath): \(error.localizedDescription)")
                }
            } else {
                print("File does not exist at: \(filePath)")
            }
            // Always remove task from list, even if file doesn't exist
            if let index = downloadTasks.firstIndex(where: { $0.url == url }) {
                downloadTasks.remove(at: index)
            }
        } else {
            print("No task found for URL: \(url)")
        }
        saveTasks()
    }
    
    /// Cancels all download tasks.
    public func cancelAllDownloads() {
        for download in activeDownloads.values {
            download.task?.cancel()
            download.resumeData = nil
            delegate?.downloadManager(self, didUpdateResumeDataForTaskWithURL: download.url, resumeData: nil)
            if let task = downloadTasks.first(where: { $0.url == download.url }) {
                task.state = .cancelled
                task.resumeData = nil
            }
        }
        activeDownloads.removeAll()
        saveTasks()
    }
    
    /// Retrieves the list of active downloads.
    public func getActiveDownloads() -> [Download] {
        return Array(activeDownloads.values)
    }
    
    /// Retrieves a specific download task.
    public func getDownload(for url: URL) -> Download? {
        return activeDownloads[url]
    }
    
    // MARK: - Save and Load Data
    
    /// Saves the list of download tasks to a JSON file.
    private func saveTasks() {
        do {
            let data = try JSONEncoder().encode(downloadTasks)
            try data.write(to: tasksSaveURL)
            #if DEBUG
            print("Tasks saved to: \(tasksSaveURL.path)")
            #endif
        } catch {
            print("Failed to save tasks: \(error.localizedDescription)")
        }
    }
    
    /// Loads the list of saved tasks from a JSON file.
    private func loadTasks() {
        guard FileManager.default.fileExists(atPath: tasksSaveURL.path) else {
            print("No tasks file found at: \(tasksSaveURL.path)")
            return
        }
        
        do {
            let data = try Data(contentsOf: tasksSaveURL)
            let decoder = JSONDecoder()
            downloadTasks = try decoder.decode([DownloadTask].self, from: data)
            
            // Update task states if needed
            var tasksToRemove: [DownloadTask] = []
            for task in downloadTasks {
                if task.state == .downloading {
                    if task.resumeData != nil {
                        task.state = .paused
                    } else {
                        task.state = .cancelled
                    }
                } else if task.state == .pending {
                    task.state = .cancelled
                } else if task.state == .completed {
                    // Check if file exists at recreated destinationURL
                    if !FileManager.default.fileExists(atPath: task.destinationURL.path) {
                        print("File missing for completed task: \(task.fileName). Marking as failed.")
                        task.state = .failed
                        tasksToRemove.append(task)
                    }
                }
                // Sync with activeDownloads
                if task.state == .paused && task.resumeData != nil {
                    let download = Download(url: task.url, fileName: task.fileName)
                    download.resumeData = task.resumeData
                    download.downloadedBytes = task.downloadedBytes
                    download.totalBytes = task.totalBytes
                    activeDownloads[task.url] = download
                }
            }
            
            // Remove invalid tasks
            downloadTasks.removeAll { tasksToRemove.contains($0) }
            
            saveTasks()
            #if DEBUG
            print("Loaded \(downloadTasks.count) tasks from: \(tasksSaveURL.path)")
            #endif
        } catch {
            print("Failed to load tasks: \(error.localizedDescription)")
        }
    }
}

// MARK: - URLSessionDownloadDelegate
extension DownloadManager: URLSessionDownloadDelegate {
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let sourceURL = downloadTask.originalRequest?.url, let download = activeDownloads[sourceURL] else { return }
        
        do {
            // Move downloaded file to destination
            if FileManager.default.fileExists(atPath: download.destinationURL.path) {
                try FileManager.default.removeItem(at: download.destinationURL)
            }
            #if DEBUG
            print("Moving file to: \(download.destinationURL.path)")
            #endif
            try FileManager.default.moveItem(at: location, to: download.destinationURL)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                // Update task state
                if let task = downloadTasks.first(where: { $0.url == sourceURL }) {
                    task.state = .completed
                    task.resumeData = nil
                }
                
                delegate?.downloadManager(self, didCompleteTaskWithURL: sourceURL, atLocation: download.destinationURL)
                activeDownloads.removeValue(forKey: sourceURL)
                saveTasks()
            }
            
        } catch {
            // Notify error
            delegate?.downloadManager(self, didFailTaskWithURL: sourceURL, withError: error)
            if let task = downloadTasks.first(where: { $0.url == sourceURL }) {
                task.state = .failed
                task.resumeData = download.resumeData
            }
            saveTasks()
        }
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard let sourceURL = downloadTask.originalRequest?.url, let download = activeDownloads[sourceURL] else { return }
        
        download.downloadedBytes = totalBytesWritten
        download.totalBytes = totalBytesExpectedToWrite > 0 ? totalBytesExpectedToWrite : 0
        
        let progress: Float
        if totalBytesExpectedToWrite > 0 {
            progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        } else {
            progress = 0.0 // Unknown size
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Update task
            if let task = self.downloadTasks.first(where: { $0.url == sourceURL }) {
                task.progress = progress
                task.downloadedBytes = totalBytesWritten
                task.totalBytes = totalBytesExpectedToWrite > 0 ? totalBytesExpectedToWrite : 0
                task.state = .downloading
            }
        }
        
        delegate?.downloadManager(self, didUpdateProgress: progress, forTaskWithURL: sourceURL)
        saveTasks()
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let sourceURL = task.originalRequest?.url, let download = activeDownloads[sourceURL] else { return }
        
        if let error = error {
            if (error as NSError).code == NSURLErrorCancelled {
                // Task was paused
                download.resumeData = (error as NSError).userInfo[NSURLSessionDownloadTaskResumeData] as? Data
                delegate?.downloadManager(self, didUpdateResumeDataForTaskWithURL: sourceURL, resumeData: download.resumeData)
                if let task = downloadTasks.first(where: { $0.url == sourceURL }) {
                    task.state = .paused
                    task.resumeData = download.resumeData
                }
            } else {
                // Other error
                delegate?.downloadManager(self, didFailTaskWithURL: sourceURL, withError: error)
                if let task = downloadTasks.first(where: { $0.url == sourceURL }) {
                    task.state = .failed
                    task.resumeData = download.resumeData
                }
                activeDownloads.removeValue(forKey: sourceURL)
            }
            saveTasks()
        }
    }
}
