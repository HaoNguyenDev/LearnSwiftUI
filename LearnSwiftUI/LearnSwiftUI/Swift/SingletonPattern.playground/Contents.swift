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
    nonisolated(unsafe) static let shared = SingletonPattern()
    private init() {}
    
    let serialQueue = DispatchQueue(label: "com.yourapp.singletonpattern.queue")
    
    private var counter: Int = 0
    
    func increaseCounter() {
        serialQueue.sync {
            counter += 1
        }
    }
    
    func decreaseCounter() {
        serialQueue.sync {
            counter -= 1
        }
    }
    
    func getCounter() -> Int {
        return serialQueue.sync {
            return counter
        }
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
//            singleton.increaseCounter()
//            print("Thread number \(i): Incrememt counter -> Current value: \(singleton.getCounter())")
//            
//            singleton.decreaseCounter()
//            print("Thread number \(i): Decrememt counter -> Current value: \(singleton.getCounter())")
//            group.leave()
//        }
//    }
    
    // Wait for all threads to complete and then print the final value
    group.wait()
    print("Final counter value: \(singleton.getCounter())")
}

// Test multi threads
simulateMultiThreads()
