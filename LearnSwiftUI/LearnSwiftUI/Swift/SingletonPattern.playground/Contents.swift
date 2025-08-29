import Foundation

// Sinleton pattern
/*
 Advantages:
 Single instance control: Ensures there is only one instance, useful for shared resources such as networking, configuration, or caching.
 Global access point: Easy access from anywhere in the application without passing the instance through multiple classes.
 Thread-safe in Swift: Static variables are safely initialized in Swift, eliminating the need for additional manual locking mechanisms for instance initialization.
 Resource saving: Avoid creating multiple instances for the same purpose.
 
 Disadvantages:
 Difficult to test: Since Singleton is global state, it can be difficult to write unit tests, especially when mocking or resetting the state.
 Hidden dependencies: Classes using Singleton can become dependent on it without being aware of it, reducing code transparency.
 Singleton abuse: Can be easily abused to store global state, leading to code that is difficult to maintain (similar to using global variables).
 Difficult to extend: If you need to change the logic or add new instances, Singleton can be difficult because of its rigid design.
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
