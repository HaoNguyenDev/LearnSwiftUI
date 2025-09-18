import Foundation
import UIKit

/*
 1. How Async/Await works
 Async/Await converts an asynchronous program into a stream of execution that looks like a regular synchronous program, using a mechanism called Structured Concurrency.
 Async Function: A function marked with the async keyword indicates that it can be paused in its execution to wait for another asynchronous task to complete. When an async function is called, it does not run immediately, but only creates a task.
 
 Await Keyword: When you call an async function, you must use the await keyword. await pauses the execution of the current function until the called async function completes and returns a result.
 
 Processing System:
 When an await task is called, Swift saves the current state of the execution thread.
 The main thread (or current thread) is released to handle other tasks.
 When the asynchronous task completes, Swift automatically resumes execution from the point where it was paused, using the saved state.
 This mechanism is managed by the Swift Runtime and a pool of threads. Instead of keeping a thread busy while waiting, Async/Await allows that thread to handle other tasks, optimizing resource usage.
 
 2. Structured Concurrency
 Async/Await works based on the Structured Concurrency principle provided by Swift. This principle ensures that tasks are organized in a hierarchical structure, with the following advantages:
 
 Cancellation: When a parent task is canceled, all of its child tasks are automatically canceled, preventing resource leaks.
 
 Error Propagation: Errors from a child task are automatically propagated to the parent task, making error handling easier.
 
 Completion: A parent task will never complete until all of its child tasks are completed.
 
 For example, when you initiate a Task (an asynchronous unit of work), it creates an environment for running async functions. When you call await inside this Task, it pauses until the task completes, but does not block the main thread, allowing the application to remain responsive.
 */

class SwiftConcurrencyTests {
    // A function marked with the async keyword indicates that it can be paused in execution while waiting for another asynchronous task to complete. When an async function is called, it does not run immediately but only creates a task.
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

// Call async function in a Task, Task are asynchronous environment
Task {
    do { // await pauses the execution of the current function until the called downloadImage async function completes and returns a result.
        let downloadedImage = try await SwiftConcurrencyTests.downloadImage(url: URL(string: "https://example.com/image.jpg")!)
        await MainActor.run {
            // Update UI with main queue
            // self.image = downloadedImage
        }
    } catch {
        print(error.localizedDescription)
    }
}

// MARK: Error Propagation
// Error Propagation: Errors from a child task are automatically propagated to the parent task, making error handling easier.
/*
 
 func fetchUserDataAndPhotos() async throws {
    // fetchUser and fetchPhotos are async throws function also
    let user = try await fetchUser()
    let photos = try await fetchPhotos(for: user)
    // ...
 }
 
 // Call fetchUserDataAndPhotos function
 Task {
    do {
        try await fetchUserDataAndPhotos()
    } catch {
        // Handle all error from fetchUser() and fetchPhotos() right here.
    }
 }
 
 */

// MARK: Completion
/* In this example, the downloadAndProcessData() function will not complete until both data1 and data2 have been downloaded and processed.
 This ensures that all data is ready before you continue. */
/*
 func downloadAndProcessData() async throws {
    // Both of these tasks will run in parallel.
    async let data1 = fetchData(from: url1)
    async let data2 = fetchData(from: url2)
 
    let processedData1 = try await process(data: data1)
    let processedData2 = try await process(data: data2)
 }
 */

// MARK: TaskGroup
/*
 A Task Group is a way to execute multiple asynchronous tasks concurrently and manage them in a structured group. It is useful when you want to run multiple tasks in parallel and wait for all of them to complete before continuing.
 */

import UIKit

let imageUrls = [
    URL(string: "https://example.com/image1.jpg")!,
    URL(string: "https://example.com/image2.jpg")!,
    URL(string: "https://example.com/image3.jpg")!,
    // ... add more URLs
]

func downloadImages(urls: [URL]) async throws -> [UIImage] {
    var images = [UIImage]()
    
    if Task.isCancelled {
        return []
    }
    
    // Task.checkCancellation() will return CancellationError
    try Task.checkCancellation()
    
    
    // Create a Task Group to run download tasks in parallel
    try await withThrowingTaskGroup(of: UIImage?.self) { group in
        for url in urls {
            // Add each subtask to the group
            group.addTask {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let image = UIImage(data: data) else {
                    throw NSError(domain: "Invalid Image Data", code: 0, userInfo: nil)
                    // If any error is received, the group task will respond to the error immediately, and cancel all remaining tasks.
                }
                return image
                
//                do {
//                    let (data, _) = try await URLSession.shared.data(from: url)
//                    return UIImage(data: data)!
//                } catch {
//                    return nil // Return nil on error if we don't want TaskGroup to skip on any error
//                }
            
            }
        }
        
        // Use a `for await` loop to get results from child tasks as they complete.
        // This loop will pause until a child task completes and returns a result.
        for try await image in group {
            if let image = image {
                images.append(image)
            }
        }
    }
    
    try Task.checkCancellation()
    
    return images
}

// Call the function and process the result
Task {
    do {
        let downloadedImages = try await downloadImages(urls: imageUrls)
        print("Successfully downloaded \(downloadedImages.count) images.")
    } catch {
        print("An error occurred during download: \(error.localizedDescription)")
    }
}
