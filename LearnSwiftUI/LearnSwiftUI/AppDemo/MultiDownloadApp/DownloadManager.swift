//
//  DownloadManager.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/9/25.
//

import Foundation

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
public class DownloadManager: NSObject {
    
    public static let shared = DownloadManager()
    
    public weak var delegate: DownloadManagerDelegate?
    
    /// Hàng đợi cho các tác vụ tải xuống.
    private lazy var downloadQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "com.myapp.downloadQueue"
        queue.maxConcurrentOperationCount = 5 // Mặc định 5, người dùng có thể thay đổi
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
    
    private override init() {}
    
    /// Bắt đầu một tác vụ tải xuống mới.
    public func startDownload(url: URL, destinationURL: URL) {
        guard activeDownloads[url] == nil else {
            print("Download for \(url) is already active or queued.")
            return
        }
        
        let download = Download(url: url, destinationURL: destinationURL)
        download.task = session.downloadTask(with: url)
        download.task?.resume()
        activeDownloads[url] = download
        delegate?.downloadManager(self, didStartTaskWithURL: url)
    }
    
    /// Tạm dừng một tác vụ tải xuống.
    public func pauseDownload(for url: URL) {
        guard let download = activeDownloads[url] else { return }
        download.task?.cancel(byProducingResumeData: { data in
            download.resumeData = data
            self.delegate?.downloadManager(self, didUpdateResumeDataForTaskWithURL: url, resumeData: data)
            self.delegate?.downloadManager(self, didChangeState: .paused, forTaskWithURL: url)
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
    }
    
    /// Hủy một tác vụ tải xuống.
    public func cancelDownload(for url: URL) {
        guard let download = activeDownloads[url] else { return }
        download.task?.cancel()
        download.resumeData = nil
        activeDownloads.removeValue(forKey: url)
        delegate?.downloadManager(self, didChangeState: .cancelled, forTaskWithURL: url)
        delegate?.downloadManager(self, didUpdateResumeDataForTaskWithURL: url, resumeData: nil)
    }
    
    /// Hủy tất cả các tác vụ tải xuống.
    public func cancelAllDownloads() {
        for download in activeDownloads.values {
            download.task?.cancel()
            download.resumeData = nil
            delegate?.downloadManager(self, didUpdateResumeDataForTaskWithURL: download.url, resumeData: nil)
        }
        activeDownloads.removeAll()
    }
    
    /// Lấy danh sách các tác vụ đang hoạt động.
    public func getActiveDownloads() -> [Download] {
        return Array(activeDownloads.values)
    }
    
    /// Lấy một tác vụ tải xuống cụ thể.
    public func getDownload(for url: URL) -> Download? {
        return activeDownloads[url]
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
            
            // Thông báo hoàn thành
            delegate?.downloadManager(self, didCompleteTaskWithURL: sourceURL, atLocation: download.destinationURL)
            activeDownloads.removeValue(forKey: sourceURL)
            
        } catch {
            // Thông báo lỗi
            delegate?.downloadManager(self, didFailTaskWithURL: sourceURL, withError: error)
        }
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard let sourceURL = downloadTask.originalRequest?.url, let download = activeDownloads[sourceURL] else { return }
        
        download.downloadedBytes = totalBytesWritten
        download.totalBytes = totalBytesExpectedToWrite > 0 ? totalBytesExpectedToWrite : 0 // Xử lý unknown = -1
        
        let progress: Float
        if totalBytesExpectedToWrite > 0 {
            progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        } else {
            progress = 0.0 // Unknown size
        }
        
        // Thông báo cập nhật tiến độ
        delegate?.downloadManager(self, didUpdateProgress: progress, forTaskWithURL: sourceURL)
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let sourceURL = task.originalRequest?.url, let download = activeDownloads[sourceURL] else { return }
        
        // Xử lý lỗi
        if let error = error {
            // Kiểm tra xem có phải lỗi hủy tác vụ không
            if (error as NSError).code == NSURLErrorCancelled {
                // Tác vụ đã bị tạm dừng, lưu dữ liệu để tiếp tục
                download.resumeData = (error as NSError).userInfo[NSURLSessionDownloadTaskResumeData] as? Data
                delegate?.downloadManager(self, didUpdateResumeDataForTaskWithURL: sourceURL, resumeData: download.resumeData)
            } else {
                // Thông báo lỗi khác
                delegate?.downloadManager(self, didFailTaskWithURL: sourceURL, withError: error)
                activeDownloads.removeValue(forKey: sourceURL)
            }
        }
    }
}
