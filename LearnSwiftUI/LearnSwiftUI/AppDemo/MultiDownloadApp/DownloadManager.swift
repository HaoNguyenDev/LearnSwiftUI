//
//  DownloadManager.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/9/25.
//

import Foundation
import Combine

/// Delegate để thông báo về trạng thái của các tác vụ tải xuống.
public protocol DownloadManagerDelegate: AnyObject {
    func downloadManager(_ manager: DownloadManager, didUpdateProgress progress: Float, forTaskWithURL url: URL)
    func downloadManager(_ manager: DownloadManager, didCompleteTaskWithURL url: URL, atLocation location: URL)
    func downloadManager(_ manager: DownloadManager, didFailTaskWithURL url: URL, withError error: Error)
    func downloadManager(_ manager: DownloadManager, didStartTaskWithURL url: URL)
    func downloadManager(_ manager: DownloadManager, didChangeState state: DownloadState, forTaskWithURL url: URL)
    func downloadManager(_ manager: DownloadManager, didUpdateResumeDataForTaskWithURL url: URL, resumeData: Data?)
}

// MARK: - Download

/// Lớp đại diện cho một tác vụ tải xuống.
public class Download: NSObject {
    public let url: URL
    public let destinationURL: URL
    public var task: URLSessionDownloadTask?
    public var resumeData: Data?
    public var downloadedBytes: Int64 = 0
    public var totalBytes: Int64 = 0
    
    public init(url: URL, destinationURL: URL) {
        self.url = url
        self.destinationURL = destinationURL
    }
}

// MARK: - DownloadManager

/// Một lớp quản lý các tác vụ tải xuống có thể tái sử dụng.
public class DownloadManager: NSObject, ObservableObject {
    
    public static let shared = DownloadManager()
    
    public weak var delegate: DownloadManagerDelegate?
    
    @Published public var downloadTasks: [DownloadTask] = [] // Lưu trữ danh sách tasks
    
    private let tasksSaveURL: URL = {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent("downloadTasks.json")
    }()
    
    /// Hàng đợi cho các tác vụ tải xuống.
    private lazy var downloadQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "com.myapp.downloadQueue"
        queue.maxConcurrentOperationCount = 5 // Mặc định 5
        return queue
    }()
    
    /// Hàng đợi để quản lý các tác vụ tải xuống.
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
        loadTasks() // Tải tasks khi init
    }
    
    // MARK: - Quản lý Tác vụ
    
    /// Bắt đầu một tác vụ tải xuống mới.
    public func startDownload(url: URL, destinationURL: URL) {
        guard activeDownloads[url] == nil else {
            print("Download for \(url) is already active or queued.")
            return
        }
        
        // Kiểm tra nếu task đã tồn tại
        if let existingTask = downloadTasks.first(where: { $0.url == url }) {
            guard existingTask.state != .completed else {
                print("Download for \(url) is already completed.")
                return
            }
            if existingTask.state == .paused && existingTask.resumeData != nil {
                resumeDownload(for: url, withResumeData: existingTask.resumeData)
                return
            }
            // Reset task nếu không completed hoặc không resume được
            existingTask.state = .pending
            existingTask.progress = 0.0
            existingTask.downloadedBytes = 0
            existingTask.totalBytes = 0
            existingTask.resumeData = nil
            existingTask.startTime = Date()
        } else {
            // Kiểm tra file tồn tại
            if FileManager.default.fileExists(atPath: destinationURL.path) {
                print("File already exists at destination. Skipping.")
                return
            }
            let newTask = DownloadTask(url: url, destinationURL: destinationURL)
            newTask.state = .pending
            newTask.startTime = Date()
            downloadTasks.append(newTask)
        }
        
        let download = Download(url: url, destinationURL: destinationURL)
        download.task = session.downloadTask(with: url)
        download.task?.resume()
        activeDownloads[url] = download
        delegate?.downloadManager(self, didStartTaskWithURL: url)
        saveTasks()
    }
    
    /// Tạm dừng một tác vụ tải xuống.
    public func pauseDownload(for url: URL) {
        guard let download = activeDownloads[url] else { return }
        download.task?.cancel(byProducingResumeData: { data in
            download.resumeData = data
            self.delegate?.downloadManager(self, didUpdateResumeDataForTaskWithURL: url, resumeData: data)
            self.delegate?.downloadManager(self, didChangeState: .paused, forTaskWithURL: url)
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                if let task = self.downloadTasks.first(where: { $0.url == url }) {
                    task.state = .paused
                    task.resumeData = data
                }
            }
            self.saveTasks()
        })
    }
    
    /// Tiếp tục một tác vụ tải xuống.
    public func resumeDownload(for url: URL, withResumeData externalResumeData: Data? = nil) {
        guard let download = activeDownloads[url] else {
            print("No active download for \(url).")
            return
        }
        
        let resumeData = externalResumeData ?? download.resumeData
        guard let resumeData = resumeData else {
            // Không có resumeData, start new
            startDownload(url: url, destinationURL: download.destinationURL)
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
    
    /// Hủy một tác vụ tải xuống.
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
    
    /// Xóa một tác vụ và file tải xuống.
    public func deleteDownload(for url: URL) {
        // Hủy task nếu đang active
        cancelDownload(for: url)
        
        // Xóa file tại destinationURL nếu tồn tại
        if let task = downloadTasks.first(where: { $0.url == url }) {
            if FileManager.default.fileExists(atPath: task.destinationURL.path) {
                do {
                    try FileManager.default.removeItem(at: task.destinationURL)
                    print("File deleted at: \(task.destinationURL.path)")
                } catch {
                    print("Error deleting file: \(error.localizedDescription)")
                }
            }
            // Xóa task khỏi danh sách
            if let index = downloadTasks.firstIndex(where: { $0.url == url }) {
                downloadTasks.remove(at: index)
            }
        }
        saveTasks()
    }
    
    /// Hủy tất cả các tác vụ tải xuống.
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
    
    /// Lấy danh sách các tác vụ đang hoạt động.
    public func getActiveDownloads() -> [Download] {
        return Array(activeDownloads.values)
    }
    
    /// Lấy một tác vụ tải xuống cụ thể.
    public func getDownload(for url: URL) -> Download? {
        return activeDownloads[url]
    }
    
    // MARK: - Lưu và Tải Dữ liệu
    
    /// Lưu danh sách các tác vụ tải xuống vào tệp JSON.
    private func saveTasks() {
        do {
            let data = try JSONEncoder().encode(downloadTasks)
            try data.write(to: tasksSaveURL)
        } catch {
            print("Failed to save tasks: \(error.localizedDescription)")
        }
    }
    
    /// Tải danh sách các tác vụ đã lưu từ tệp JSON.
    private func loadTasks() {
        guard FileManager.default.fileExists(atPath: tasksSaveURL.path) else { return }
        
        do {
            let data = try Data(contentsOf: tasksSaveURL)
            let decoder = JSONDecoder()
            downloadTasks = try decoder.decode([DownloadTask].self, from: data)
            
            // Cập nhật trạng thái của các tác vụ nếu cần
            for task in downloadTasks {
                if task.state == .downloading {
                    // Nếu app crash khi downloading, set paused nếu có resumeData, else cancelled
                    if task.resumeData != nil {
                        task.state = .paused
                    } else {
                        task.state = .cancelled
                    }
                } else if task.state == .pending {
                    task.state = .cancelled // Pending không persist tốt
                }
                // Sync với activeDownloads
                if task.state == .paused && task.resumeData != nil {
                    let download = Download(url: task.url, destinationURL: task.destinationURL)
                    download.resumeData = task.resumeData
                    download.downloadedBytes = task.downloadedBytes
                    download.totalBytes = task.totalBytes
                    activeDownloads[task.url] = download
                }
            }
            saveTasks()
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
            // Di chuyển tệp đã tải xuống đến đích
            if FileManager.default.fileExists(atPath: download.destinationURL.path) {
                try FileManager.default.removeItem(at: download.destinationURL)
            }
#if DEBUG
            print("Moving file to: \(download.destinationURL.path)")
#endif
            try FileManager.default.moveItem(at: location, to: download.destinationURL)
            
            // Cập nhật task state
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if let task = self.downloadTasks.first(where: { $0.url == sourceURL }) {
                    task.state = .completed
                    task.resumeData = nil
                }
            }
            delegate?.downloadManager(self, didCompleteTaskWithURL: sourceURL, atLocation: download.destinationURL)
            activeDownloads.removeValue(forKey: sourceURL)
            saveTasks()
            
        } catch {
            // Thông báo lỗi
            delegate?.downloadManager(self, didFailTaskWithURL: sourceURL, withError: error)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if let task = self.downloadTasks.first(where: { $0.url == sourceURL }) {
                    task.state = .failed
                    task.resumeData = download.resumeData
                }
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
        
        // Cập nhật task
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
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
                // Tác vụ đã bị tạm dừng
                download.resumeData = (error as NSError).userInfo[NSURLSessionDownloadTaskResumeData] as? Data
                delegate?.downloadManager(self, didUpdateResumeDataForTaskWithURL: sourceURL, resumeData: download.resumeData)
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    if let task = self.downloadTasks.first(where: { $0.url == sourceURL }) {
                        task.state = .paused
                        task.resumeData = download.resumeData
                    }
                }
            } else {
                // Lỗi khác
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
