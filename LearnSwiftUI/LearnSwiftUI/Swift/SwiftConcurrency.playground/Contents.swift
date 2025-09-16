import Foundation
import UIKit

class SwiftConcurrencyTests {
    func callAPI() async throws {
        do {
            try await Task.sleep(for: .seconds(1))
        } catch {
            throw error
        }
    }
    
    static func downloadImage(url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        return image
    }

    
}


// Call async function in a Task environment
Task {
    do {
        let downloadedImage = try await SwiftConcurrencyTests.downloadImage(url: URL(string: "https://example.com/image.jpg")!)
        await MainActor.run {
            // Update UI with main queue
            // self.image = downloadedImage
        }
    } catch {
        print(error.localizedDescription)
    }
}
