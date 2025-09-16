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
