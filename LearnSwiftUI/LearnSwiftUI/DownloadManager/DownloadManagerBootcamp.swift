//
//  DownloadManagerBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 12/8/25.
//

import Foundation
import UIKit

// MARK: - Operation download image
private class ImageDownloadOperation: Operation, @unchecked Sendable {
    private let url: URL
    private let session: URLSession
    private let cache: NSCache<NSURL, UIImage>
    private let completion: (UIImage?) -> Void
    
    init(url: URL,
         session: URLSession,
         cache: NSCache<NSURL, UIImage>,
         completion: @escaping (UIImage?) -> Void) {
        self.url = url
        self.session = session
        self.cache = cache
        self.completion = completion
    }
    
    override func main() {
        if isCancelled { return }
        
        // 1. Check image in cache first
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return
        }
        
        // 2. Download image with URLSession (synchonous with semaphore)
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = session.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, !self.isCancelled else {
                semaphore.signal()
                return
            }
            if let data = data, let image = UIImage(data: data) {
                self.cache.setObject(image, forKey: self.url as NSURL)
                self.completion(image)
            } else {
                print("❌ Error downloading \(self.url):", error ?? "Unknown")
                self.completion(nil)
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait() // Wait for task finish and end Operation
    }
}

// MARK: - DownloadManager
final class DownloadManager {
    static let shared = DownloadManager()
    
    private let queue: OperationQueue
    private let cache = NSCache<NSURL, UIImage>()
    private let session: URLSession
    
    private init(maxConcurrent: Int = 10) {
        queue = OperationQueue()
        queue.maxConcurrentOperationCount = maxConcurrent
        
        let config = URLSessionConfiguration.default
        config.httpMaximumConnectionsPerHost = maxConcurrent
        session = URLSession(configuration: config)
    }
    
    func download(urls: [URL], completion: @escaping ([UIImage?]) -> Void) {
        var results = Array<UIImage?>(repeating: nil, count: urls.count)
        let lock = NSLock()
        
        for (index, url) in urls.enumerated() {
            let op = ImageDownloadOperation(url: url,
                                            session: session,
                                            cache: cache) { image in
                lock.lock()
                results[index] = image
                lock.unlock()
            }
            queue.addOperation(op)
        }
        
        queue.addBarrierBlock {
            DispatchQueue.main.async {
                completion(results)
            }
        }
    }
    
    func cancelAll() {
        queue.cancelAllOperations()
    }
    
    func getImageFromCache(for url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}


// MARK: Usage
let imageURLs: [URL] = (0..<1000).compactMap {
    URL(string: "https://example.com/image\($0).jpg")
}

//DownloadManager.shared.download(urls: imageURLs) { images in
//    let successCount = images.compactMap { $0 }.count
//    print("✅ Download complete \(successCount)/\(images.count) images")
//}
