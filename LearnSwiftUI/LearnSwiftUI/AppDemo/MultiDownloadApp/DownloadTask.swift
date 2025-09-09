//
//  DownloadTask.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/9/25.
//

import Foundation

// MARK: - DownloadState

/// Enum đại diện cho các trạng thái tải xuống.
public enum DownloadState: String, Codable {
    case pending = "Đang chờ"
    case downloading = "Đang tải"
    case paused = "Tạm dừng"
    case completed = "Đã hoàn thành"
    case failed = "Thất bại"
    case cancelled = "Đã hủy"
}

// MARK: - DownloadTask

/// Lớp đại diện cho một tác vụ tải xuống.
public class DownloadTask: NSObject, ObservableObject, Codable, Identifiable {
    
    public let id = UUID()
    public let url: URL
    public let destinationURL: URL
    
    @Published public var state: DownloadState = .pending
    @Published public var progress: Float = 0.0
    @Published public var downloadedBytes: Int64 = 0
    @Published public var totalBytes: Int64 = 0
    @Published public var startTime: Date?
    @Published public var resumeData: Data? // Thêm để persist resume data
    
    enum CodingKeys: String, CodingKey {
        case url, destinationURL, state, progress, downloadedBytes, totalBytes, startTime, resumeData
    }
    
    public init(url: URL, destinationURL: URL) {
        self.url = url
        self.destinationURL = destinationURL
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(URL.self, forKey: .url)
        destinationURL = try container.decode(URL.self, forKey: .destinationURL)
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
        try container.encode(destinationURL, forKey: .destinationURL)
        try container.encode(state, forKey: .state)
        try container.encode(progress, forKey: .progress)
        try container.encode(downloadedBytes, forKey: .downloadedBytes)
        try container.encode(totalBytes, forKey: .totalBytes)
        try container.encode(startTime, forKey: .startTime)
        try container.encodeIfPresent(resumeData, forKey: .resumeData)
    }
    
    // MARK: - Thuộc tính Tính toán
    
    /// Định dạng bytes đã tải và tổng bytes thành một chuỗi dễ đọc.
    public var downloadedProgressFormatted: String {
        let downloaded = ByteCountFormatter.string(fromByteCount: downloadedBytes, countStyle: .file)
        if totalBytes > 0 {
            let total = ByteCountFormatter.string(fromByteCount: totalBytes, countStyle: .file)
            return "\(downloaded) / \(total)"
        } else {
            return downloaded // Nếu total unknown (totalBytes = -1 hoặc 0)
        }
    }
    
    /// Định dạng tổng bytes thành một chuỗi dễ đọc (dùng totalBytes nếu completed).
    public var fileSizeFormatted: String {
        let bytes = (state == .completed && totalBytes > 0) ? totalBytes : downloadedBytes
        return ByteCountFormatter.string(fromByteCount: bytes, countStyle: .file)
    }
}
