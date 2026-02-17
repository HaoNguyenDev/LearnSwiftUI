//
//  DownloadViewModel.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/9/25.
//

import Foundation

// MARK: - DownloadViewModel

/// ViewModel for managing download logic and providing data to the View.
public class DownloadViewModel: NSObject, ObservableObject, DownloadManagerDelegate {
    
    private let downloadManager = DownloadManager.shared
    
    /// Binds to downloadTasks from DownloadManager.
    public var downloadTasks: [DownloadTask] {
        downloadManager.downloadTasks
    }
    
    override public init() {
        super.init()
        downloadManager.delegate = self
    }
    
    // MARK: - Task Management
    
    /// Starts a new download task.
    public func startDownload(urlString: String) {
        downloadManager.startDownload(urlString: urlString)
    }
    
    /// Pauses a download task.
    public func pauseDownload(for task: DownloadTask) {
        downloadManager.pauseDownload(for: task.url)
    }
    
    /// Resumes a paused download task.
    public func resumeDownload(for task: DownloadTask) {
        downloadManager.resumeDownload(for: task.url, withResumeData: task.resumeData)
    }
    
    /// Cancels a download task.
    public func cancelDownload(for task: DownloadTask) {
        downloadManager.cancelDownload(for: task.url)
    }
    
    /// Deletes a downloaded file.
    public func deleteDownload(for task: DownloadTask) {
        downloadManager.deleteDownload(for: task)
    }
    
    // MARK: - DownloadManagerDelegate
    
    /// Updates the download progress for a task.
    public func downloadManager(_ manager: DownloadManager, didUpdateProgress progress: Float, forTaskWithURL url: URL) {
        // No handling needed as UI binds directly to downloadTasks.
    }
    
    /// Handles when a download task fails.
    public func downloadManager(_ manager: DownloadManager, didFailTaskWithURL url: URL, withError error: Error) {
        // No handling needed as state is updated in DownloadManager.
    }
    
    /// Handles when a download task completes.
    public func downloadManager(_ manager: DownloadManager, didCompleteTaskWithURL url: URL, atLocation location: URL) {
        // No handling needed as state is updated in DownloadManager.
    }
    
    /// Handles when a download task starts.
    public func downloadManager(_ manager: DownloadManager, didStartTaskWithURL url: URL) {
        // No handling needed as state is updated in DownloadManager.
    }
    
    /// Handles when the state of a task changes.
    public func downloadManager(_ manager: DownloadManager, didChangeState state: DownloadState, forTaskWithURL url: URL) {
        // No handling needed as state is updated in DownloadManager.
    }
    
    /// Handles when the resume data of a task is updated.
    public func downloadManager(_ manager: DownloadManager, didUpdateResumeDataForTaskWithURL url: URL, resumeData: Data?) {
        // No handling needed as resumeData is updated in DownloadManager.
    }
}
