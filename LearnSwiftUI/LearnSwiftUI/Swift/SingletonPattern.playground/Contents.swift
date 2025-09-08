import Foundation

// Sinleton pattern
/*
 Advantages:
 Easy to access, centralized resource management and data consistency.
 
 Disadvantages:
 Memory consuming (not freed), difficult to test (due to global state),
 difficult to scale and potential race condition risk when accessing from multiple threads.
 */

final class SingletonPattern {
    // Shared instance, thread-safe access
    nonisolated(unsafe) static let shared = SingletonPattern()
    
    // Private initializer to prevent external instantiation
    private init() {}
    
    // Private serial queue for synchronized access to _counter
    private let queue = DispatchQueue(label: "com.yourapp.singletonpattern.queue")
    private let concurrentQueue = DispatchQueue(label: "com.yourapp.singletonpattern.queue", attributes: .concurrent)
    
    // The shared resource protected by the queue
    private var _counter: Int = 0
    
//    // Method to safely increment the counter
//    func increment() {
//        queue.async {
//            Thread.sleep(forTimeInterval: 0.001) // Simulate a long-running task
//            self._counter += 1
//        }
//    }
//    
//    // Method to safely decrement the counter
//    func decrement() {
//        queue.async {
//            Thread.sleep(forTimeInterval: 0.001) // Simulate a long-running task
//            self._counter -= 1
//        }
//    }
    
    // Method to safely get the current counter value
    func getCounter() -> Int {
        var result = 0
        queue.sync {
            result = self._counter
        }
        return result
    }
}

// Multithreaded emulator function
func simulateMultiThreads() {
    let singleton = SingletonPattern.shared
    let concurrentQueue = DispatchQueue(label: "com.example.testqueue", attributes: .concurrent)
    let group = DispatchGroup()  // To wait for all threads to complete
    
    print("Initial counter value: \(singleton.getCounter())")
    
    // Create multiple threads
//    for i in 1...1000 {
//        group.enter()
//        concurrentQueue.async {
//            singleton.increment()
////            print("Thread number \(i): Incrememt counter -> Current value: \(singleton.getCounter())")
//            
//            singleton.decrement()
////            print("Thread number \(i): Decrememt counter -> Current value: \(singleton.getCounter())")
//            group.leave()
//        }
//    }
    
    // Wait for all threads to complete and then print the final value
    group.wait()
    print("Final counter value: \(singleton.getCounter())")
}

// Test multi threads
simulateMultiThreads()
