import Foundation

/*
 Main Queue (is a special serial queue that runs on the main thread (main thread) UI run on main queue, use main queue when working with UI).
 
 Global Queue (is a concurrent queue provided by the system, work with hard work).
 
 Custom DispatchQueue (serial queue, concurent queue).
 
 Serial Queue: Its nature is that Only one task is run at a time, and the next task waits for the previous task to complete.
 
 serial.sync: Blocks the current thread: The calling thread waits for the task to complete. Causes deadlock if called on the main queue from the main thread.
 
 serial.async: The current thread (usually the main thread) continues immediately after adding the task. But still runs sequentially according to its nature. Guaranteed in the order of addition (FIFO).

 Concurrent Queue:
 sync: Blocks the current thread: The calling thread waits for the task to complete, even though the concurrent queue can run multiple tasks at the same time. Causes deadlock if called on the main queue from the main thread.
 async: Tasks can be executed concurrently on multiple threads, depending on CPU resources. Tasks do not need to wait for each other, and the order of completion is not guaranteed.
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
    
//    func increment() {
//        for _ in 0..<100 {
//            DispatchQueue.global().async {
//                self.serialQueue.async {
//                    self.counter += 1
//                    print(self.counter)
//                }
//            }
//        }
//    }
    
}

//let testRaceCondition = TestRaceCondition()
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
