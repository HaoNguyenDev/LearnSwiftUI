import Foundation

/*
 1. MainQueue
 Operations: This is a unique and special queue that runs on the main thread of the application.
 Properties: MainQueue is a SerialQueue. This means that it will execute tasks in sequential order, one task at a time.
 Usage: All UI related tasks such as updating Labels, displaying Alerts or manipulating UIViewController must be executed on the MainQueue. Running UI tasks on another thread will cause errors or unexpected behavior.
 
 // Execute task on MainQueue
 DispatchQueue.main.async {
    // Update UI here
    self.myLabel.text = "Hello, world!"
 }
 
 Note:
 Never run heavy (time-consuming) tasks on the MainQueue. This will freeze the UI and negatively affect the user experience.
 If a heavy task is running, the app will not be able to handle user events (like taps, swipes) until the task is completed.
 
 
 
 2. SerialQueue
 Working: A SerialQueue has only one thread to process tasks.
 Properties: Tasks added to the queue will be executed sequentially, in first-in-first-out (FIFO) order. The second task will only start when the first task is complete.
 Uses:
 When you need to ensure that tasks are executed in a specific order.
 When you want to protect a resource (such as a shared variable) from being accessed by multiple threads at the same time, avoiding race conditions. By placing read/write operations on a SerialQueue, you ensure that only one thread is allowed to access it at a time.
 Swift
    // Initialize a private SerialQueue
    let mySerialQueue = DispatchQueue(label: "com.example.myqueue")

    // Execute tasks
    mySerialQueue.async {
        // Task 1: write data
    }

    mySerialQueue.async {
        // Task 2: read data
    }
    // Task 2 will run after Task 1 completes
 
 Note:
 SerialQueue is useful for synchronization.
 Although tasks are processed sequentially, they still run on a background thread, so they don't freeze the UI.
 
 
 
 3. ConcurrentQueue
 Working: A ConcurrentQueue has multiple threads to process tasks.
 Properties: Tasks added to the queue can be executed concurrently.
 Uses:
 When you have multiple independent tasks and want them to run at the same time to save time. For example, downloading multiple images from the network, processing multiple files, or performing complex calculations.
 System-available ConcurrentQueues: DispatchQueue.global().
 Swift
 // Using a Global ConcurrentQueue
 DispatchQueue.global().async {
 // Heavy Task 1: Loading Images
 }

 DispatchQueue.global().async {
 // Heavy Task 2: Processing Data
 }
 // Tasks 1 and 2 can run concurrently
 Note:
 Be careful with Race Conditions: Since multiple tasks can access the shared resource at the same time, you must use synchronization mechanisms like DispatchQueue.sync or DispatchSemaphore to protect the resource if needed.
 Execution Order Not Guaranteed: Although tasks are added to the queue in a certain order, they may complete at different times.
 */

class SerialTest {
    let serialQueue = DispatchQueue(label: "example.serialQueue")
    
    func testSync() {
        print("testSync >>> Start")
        
        serialQueue.sync {
            Thread.sleep(forTimeInterval: 1)
            print("task 1")
        }
        
        serialQueue.sync {
            Thread.sleep(forTimeInterval: 1)
            print("task 2")
        }
        
        print("testSync >>> End")
    }
    
    func testAsync() {
        print("testAsync >>> Start")
        
        serialQueue.async {
            Thread.sleep(forTimeInterval: 1)
            print("task 1")
        }
        
        serialQueue.async {
            Thread.sleep(forTimeInterval: 1)
            print("task 2")
        }
        
        print("testAsync >>> End")
    }
}

let serialTest = SerialTest()
//serialTest.testSync() // Tasks are executed sequentially. The calling thread is blocked.
//serialTest.testAsync() // Tasks are executed sequentially. The calling thread is not blocked.

class ConcurrentTest {
    let concurrentQueue = DispatchQueue(label: "example.concurrentQueue", qos: .userInteractive, attributes: .concurrent)
    
    func testSync() {
        print("testSync >>> Start")
        
        concurrentQueue.sync {
            Thread.sleep(forTimeInterval: 1)
            print("task 1")
        }
        
        concurrentQueue.sync {
            Thread.sleep(forTimeInterval: 1)
            print("task 2")
        }
        
        print("testSync >>> End")
    }
    
    func testAsync() {
        print("testAsync >>> Start")
        
        concurrentQueue.async {
            Thread.sleep(forTimeInterval: 1)
            print("task 1")
        }
        
        concurrentQueue.async {
            Thread.sleep(forTimeInterval: 2)
            print("task 2")
        }
        
        concurrentQueue.async {
            Thread.sleep(forTimeInterval: 1)
            print("task 3")
        }
        
        concurrentQueue.async(flags: .barrier) { // (flags: .barrier)
            Thread.sleep(forTimeInterval: 1)
            print("task 4")
        }
        
        print("testAsync >>> End")
    }
}

let testConcurrent = ConcurrentTest()
//testConcurrent.testSync() // The task is executed immediately. The calling thread is blocked until the task completes.
//testConcurrent.testAsync() // Tasks are executed concurrently (multiple tasks at the same time). The calling thread is not blocked, it continues to do its work.

//the way of serial.sync and concurrent.sync excute task the same way, the calling thread is blocked until the task completes

// Avoid race condition with Serial queue


class TestRaceCondition {
    var counter = 0
    let concurrentQueue = DispatchQueue(label: "com.example.concurrent", attributes: .concurrent)
    let serialQueue = DispatchQueue(label: "com.example.concurrent", attributes: .concurrent)
//    func increment() {
//        for _ in 0..<100 {
//            concurrentQueue.async { [weak self] in
//                self?.counter += 1 // Race condition occurs here!
//                print(self?.counter)
//            }
//        }
//        // With ConcurentQueue the final counter value may not be 100.
//    }
    
//    func increment2() {
//        for _ in 0..<100 {
////            DispatchQueue.global().async {
//                self.serialQueue.sync {
//                    self.counter += 1
//                    print(self.counter)
//                }
////            }
//        }
//    }
    
}

let testRaceCondition = TestRaceCondition()
//testRaceCondition.increment()
//testRaceCondition.increment2()

//let dispatchGroup = DispatchGroup() //DispatchGroup keeps track of the number of tasks through the enter() and leave() method pair.
//let queue = DispatchQueue.global()
//
//func testAsyncGroup(_ task: @escaping () -> Void) {
//    dispatchGroup.enter()
//    queue.async {
//        Thread.sleep(forTimeInterval: 1)
//        print("Excuted task 1")
//        dispatchGroup.leave()
//    }
//
//    dispatchGroup.enter()
//    queue.async {
//        Thread.sleep(forTimeInterval: 3)
//        print("Excuted task 2")
//        dispatchGroup.leave()
//    }
//    
//    task()
//}
//
//dispatchGroup.notify(queue: .main) {
//    print("Task finished!")
//}
//
//testAsyncGroup {
//    print("Waiting for tasks...")
//    let result = dispatchGroup.wait(timeout: .now() + 3) // maximum wait time in 3 seconds
//    if result == .timedOut {
//        print("Timeout")
//        return
//    } else {
//        print("Finished before timeout")
//    }
//    print("All tasks finished!")
//}

//let queue = DispatchQueue.global()
//let workItem1 = DispatchWorkItem {
//    print("Hello, World!")
//}
//
//@MainActor func excuteWorkItem() {
//    queue.async(execute: workItem1)
//}
////workItem1.cancel()
//excuteWorkItem()
