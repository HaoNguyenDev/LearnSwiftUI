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
    
    private let downloadManager = DownloadManager.shared
    
    // Bind với downloadTasks từ DownloadManager
    public var downloadTasks: [DownloadTask] {
        downloadManager.downloadTasks
    }
    
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
        
        let fileName = url.lastPathComponent
        guard let destinationURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fileName) else {
            print("Failed to create destination URL")
            return
        }
        
        downloadManager.startDownload(url: url, destinationURL: destinationURL)
    }
    
    /// Tạm dừng một tác vụ tải xuống.
    public func pauseDownload(for task: DownloadTask) {
        downloadManager.pauseDownload(for: task.url)
    }
    
    /// Tiếp tục một tác vụ tải xuống đã tạm dừng.
    public func resumeDownload(for task: DownloadTask) {
        downloadManager.resumeDownload(for: task.url, withResumeData: task.resumeData)
    }
    
    /// Hủy một tác vụ tải xuống.
    public func cancelDownload(for task: DownloadTask) {
        downloadManager.cancelDownload(for: task.url)
    }
    
    /// Xóa một tệp đã tải xuống.
    public func deleteDownload(for task: DownloadTask) {
        downloadManager.deleteDownload(for: task.url)
    }
    
    // MARK: - DownloadManagerDelegate
    
    public func downloadManager(_ manager: DownloadManager, didUpdateProgress progress: Float, forTaskWithURL url: URL) {
        // Không cần xử lý vì UI bind trực tiếp với downloadTasks
    }
    
    public func downloadManager(_ manager: DownloadManager, didFailTaskWithURL url: URL, withError error: Error) {
        // Không cần xử lý vì state được cập nhật trong DownloadManager
    }
    
    public func downloadManager(_ manager: DownloadManager, didCompleteTaskWithURL url: URL, atLocation location: URL) {
        // Không cần xử lý vì state được cập nhật trong DownloadManager
    }
    
    public func downloadManager(_ manager: DownloadManager, didStartTaskWithURL url: URL) {
        // Không cần xử lý vì state được cập nhật trong DownloadManager
    }
    
    public func downloadManager(_ manager: DownloadManager, didChangeState state: DownloadState, forTaskWithURL url: URL) {
        // Không cần xử lý vì state được cập nhật trong DownloadManager
    }
    
    public func downloadManager(_ manager: DownloadManager, didUpdateResumeDataForTaskWithURL url: URL, resumeData: Data?) {
        // Không cần xử lý vì resumeData được cập nhật trong DownloadManager
    }
}
