//
//  DownloadViewModel.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/9/25.
//

import Foundation
import Combine

// MARK: - DownloadViewModel

/// ViewModel để quản lý logic tải xuống và cung cấp dữ liệu cho View.
public class DownloadViewModel: NSObject, ObservableObject, DownloadManagerDelegate {
    
    // Sử dụng @Published để thông báo cho View về bất kỳ thay đổi nào trong dữ liệu.
    @Published public var downloadTasks = [DownloadTask]()
    
    private let downloadManager = DownloadManager.shared
    
    private let tasksSaveURL: URL = {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent("downloadTasks.json")
    }()
    
    override public init() {
        super.init()
        downloadManager.delegate = self
    }
    
    // MARK: - Quản lý Tác vụ
    
    /// Thêm một tác vụ tải xuống mới.
    public func startDownload(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Kiểm tra xem tác vụ đã tồn tại trong danh sách chưa
        if let existingTask = downloadTasks.first(where: { $0.url == url }) {
            // Nếu đã hoàn thành, không làm gì cả
            guard existingTask.state != .completed else {
                print("Download for \(url) is already completed.")
                return
            }
            
            // Nếu paused và có resumeData, resume
            if existingTask.state == .paused && existingTask.resumeData != nil {
                print("Resuming paused download...")
                resumeDownload(for: existingTask)
            } else {
                // Khác, start new
                print("Restarting download...")
                existingTask.state = .pending
                existingTask.progress = 0.0
                existingTask.downloadedBytes = 0
                existingTask.totalBytes = 0
                existingTask.resumeData = nil
                downloadManager.startDownload(url: url, destinationURL: existingTask.destinationURL)
            }
            saveTasks()
            return
        }
        
        // Tạo new task
        let fileName = url.lastPathComponent
        guard let destinationURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fileName) else {
            print("Failed to create destination URL")
            return
        }
        
        // Kiểm tra nếu file đã tồn tại (tránh duplicate)
        if FileManager.default.fileExists(atPath: destinationURL.path) {
            print("File already exists at destination. Skipping.")
            return
        }
        
        let newTask = DownloadTask(url: url, destinationURL: destinationURL)
        newTask.state = .pending // Bắt đầu từ pending, sẽ update khi start
        newTask.startTime = Date()
        downloadTasks.append(newTask)
        downloadManager.startDownload(url: url, destinationURL: destinationURL)
        saveTasks()
    }
    
    /// Tạm dừng một tác vụ tải xuống.
    public func pauseDownload(for task: DownloadTask) {
        downloadManager.pauseDownload(for: task.url)
        task.state = .paused
        // resumeData sẽ được update trong delegate
        saveTasks()
    }
    
    /// Tiếp tục một tác vụ tải xuống đã tạm dừng.
    public func resumeDownload(for task: DownloadTask) {
        task.state = .pending
        downloadManager.resumeDownload(for: task.url, withResumeData: task.resumeData)
        saveTasks()
    }
    
    /// Hủy một tác vụ tải xuống.
    public func cancelDownload(for task: DownloadTask) {
        downloadManager.cancelDownload(for: task.url)
        task.state = .cancelled
        task.resumeData = nil
        if let index = downloadTasks.firstIndex(where: { $0.id == task.id }) {
            downloadTasks.remove(at: index)
        }
        saveTasks()
    }
    
    /// Xóa một tệp đã tải xuống.
    public func deleteDownload(for task: DownloadTask) {
        // Hủy task trong DownloadManager nếu nó đang active
        downloadManager.cancelDownload(for: task.url) // Đảm bảo task không còn active
        
        // Xóa file tại destinationURL nếu tồn tại
        if FileManager.default.fileExists(atPath: task.destinationURL.path) {
            do {
                try FileManager.default.removeItem(at: task.destinationURL)
                print("File deleted at: \(task.destinationURL.path)")
            } catch {
                print("Error deleting file: \(error.localizedDescription)")
            }
        }
        
        // Xóa task khỏi danh sách
        if let index = downloadTasks.firstIndex(where: { $0.id == task.id }) {
            downloadTasks.remove(at: index)
        }
        saveTasks()
    }
    
    // MARK: - Lưu và Tải Dữ liệu
    
    /// Lưu danh sách các tác vụ tải xuống vào tệp JSON.
    public func saveTasks() {
        do {
            let data = try JSONEncoder().encode(downloadTasks)
            try data.write(to: tasksSaveURL)
        } catch {
            print("Failed to save tasks: \(error.localizedDescription)")
        }
    }
    
    /// Tải danh sách các tác vụ đã lưu từ tệp JSON.
    public func loadTasks() {
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
                // Sync với DownloadManager: Nếu paused và resumeData, add vào activeDownloads
                if task.state == .paused && task.resumeData != nil {
                    let download = Download(url: task.url, destinationURL: task.destinationURL)
                    download.resumeData = task.resumeData
                    download.downloadedBytes = task.downloadedBytes
                    download.totalBytes = task.totalBytes
                    downloadManager.activeDownloads[task.url] = download
                }
            }
        } catch {
            print("Failed to load tasks: \(error.localizedDescription)")
        }
    }
    
    // MARK: - DownloadManagerDelegate
    
    public func downloadManager(_ manager: DownloadManager, didUpdateProgress progress: Float, forTaskWithURL url: URL) {
        DispatchQueue.main.async {
            if let task = self.downloadTasks.first(where: { $0.url == url }) {
                task.progress = progress
                if let managerTask = manager.getDownload(for: url) {
                    task.downloadedBytes = managerTask.downloadedBytes
                    task.totalBytes = managerTask.totalBytes
                    task.state = .downloading // Đảm bảo state downloading khi progress update
                }
                self.saveTasks()
            }
        }
    }
    
    public func downloadManager(_ manager: DownloadManager, didFailTaskWithURL url: URL, withError error: Error) {
        DispatchQueue.main.async {
            if let task = self.downloadTasks.first(where: { $0.url == url }) {
                task.state = .failed
                task.resumeData = manager.getDownload(for: url)?.resumeData // Lưu resumeData nếu có
            }
            self.saveTasks()
        }
    }
    
    public func downloadManager(_ manager: DownloadManager, didCompleteTaskWithURL url: URL, atLocation location: URL) {
        DispatchQueue.main.async {
            if let task = self.downloadTasks.first(where: { $0.url == url }) {
                task.state = .completed
                task.resumeData = nil
            }
            self.saveTasks()
        }
    }
    
    public func downloadManager(_ manager: DownloadManager, didStartTaskWithURL url: URL) {
        DispatchQueue.main.async {
            if let task = self.downloadTasks.first(where: { $0.url == url }) {
                task.state = .downloading
            }
            self.saveTasks()
        }
    }
    
    public func downloadManager(_ manager: DownloadManager, didChangeState state: DownloadState, forTaskWithURL url: URL) {
        DispatchQueue.main.async {
            if let task = self.downloadTasks.first(where: { $0.url == url }) {
                task.state = state
            }
            self.saveTasks()
        }
    }
    
    public func downloadManager(_ manager: DownloadManager, didUpdateResumeDataForTaskWithURL url: URL, resumeData: Data?) {
        DispatchQueue.main.async {
            if let task = self.downloadTasks.first(where: { $0.url == url }) {
                task.resumeData = resumeData
            }
            self.saveTasks()
        }
    }
}
