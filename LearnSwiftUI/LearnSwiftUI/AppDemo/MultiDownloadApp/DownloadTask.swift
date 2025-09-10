//
//  DownloadTask.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/9/25.
//

import Foundation

// MARK: - DownloadState

/// Enum representing download states.
public enum DownloadState: String, Codable {
    case pending = "Pending"
    case downloading = "Downloading"
    case paused = "Paused"
    case completed = "Completed"
    case failed = "Failed"
    case cancelled = "Cancelled"
}

// MARK: - DownloadTask

/// Class representing a download task.
public class DownloadTask: NSObject, ObservableObject, Codable, Identifiable {
    
    public let id = UUID()
    public let url: URL
    public let fileName: String // Replaced destinationURL with fileName to avoid storing absolute path
    
    @Published public var state: DownloadState = .pending
    @Published public var progress: Float = 0.0
    @Published public var downloadedBytes: Int64 = 0
    @Published public var totalBytes: Int64 = 0
    @Published public var startTime: Date?
    @Published public var resumeData: Data?
    
    enum CodingKeys: String, CodingKey {
        case url, fileName, state, progress, downloadedBytes, totalBytes, startTime, resumeData
    }
    
    public init(url: URL, fileName: String) {
        self.url = url
        self.fileName = fileName
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(URL.self, forKey: .url)
        fileName = try container.decode(String.self, forKey: .fileName)
        state = try container.decode(DownloadState.self, forKey: .state)
        progress = try container.decode(Float.self, forKey: .progress)
        downloadedBytes = try container.decode(Int64.self, forKey: .downloadedBytes)
        totalBytes = try container.decode(Int64.self, forKey: .totalBytes)
        startTime = try container.decode(Date?.self, forKey: .startTime)
        resumeData = try container.decodeIfPresent(Data.self, forKey: .resumeData)
        super.init()
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(url, forKey: .url)
        try container.encode(fileName, forKey: .fileName)
        try container.encode(state, forKey: .state)
        try container.encode(progress, forKey: .progress)
        try container.encode(downloadedBytes, forKey: .downloadedBytes)
        try container.encode(totalBytes, forKey: .totalBytes)
        try container.encode(startTime, forKey: .startTime)
        try container.encodeIfPresent(resumeData, forKey: .resumeData)
    }
    
    // Computed property to dynamically recreate destinationURL
    public var destinationURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent(fileName)
    }
    
    // MARK: - Computed Properties
    
    /// Formats downloaded bytes and total bytes into a human-readable string.
    public var downloadedProgressFormatted: String {
        let downloaded = ByteCountFormatter.string(fromByteCount: downloadedBytes, countStyle: .file)
        if totalBytes > 0 {
            let total = ByteCountFormatter.string(fromByteCount: totalBytes, countStyle: .file)
            return "\(downloaded) / \(total)"
        } else {
            return downloaded // If total is unknown
        }
    }
    
    /// Formats total bytes into a human-readable string.
    public var fileSizeFormatted: String {
        let bytes = (state == .completed && totalBytes > 0) ? totalBytes : downloadedBytes
        return ByteCountFormatter.string(fromByteCount: bytes, countStyle: .file)
    }
}
