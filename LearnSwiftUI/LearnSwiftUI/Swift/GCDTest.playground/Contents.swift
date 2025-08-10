import Foundation

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
//serialTest.testSync()
//serialTest.testAsync()

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
        
        concurrentQueue.async(flags: .barrier) {
            Thread.sleep(forTimeInterval: 1)
            print("task 2")
        }
        
        concurrentQueue.async {
            Thread.sleep(forTimeInterval: 1)
            print("task 3")
        }
        
        print("testAsync >>> End")
    }
}

let testConcurrent = ConcurrentTest()
//testConcurrent.testSync()
//testConcurrent.testAsync()

//the way of serial.sync and concurrent.sync excute task the same way

let group = DispatchGroup()
let queue = DispatchQueue.global()

func testAsyncGroup(_ task: @escaping () -> Void) {
    group.enter()
    queue.async {
        Thread.sleep(forTimeInterval: 1)
        print("Excuted task 1")
        group.leave()
    }

    group.enter()
    queue.async {
        Thread.sleep(forTimeInterval: 2)
        print("Excuted task 2")
        group.leave()
    }
    
    task()
}

//group.notify(queue: .main) {
//    print("Task finished!")
//}
//
//testAsyncGroup {
//    print("Waiting for tasks...")
//    let result = group.wait(timeout: .now() + 3) // maximum wait time in 5 seconds
//    if result == .timedOut {
//        print("Timeout")
//        return
//    } else {
//        print("Finished before timeout")
//    }
//    print("All tasks finished!")
//}

let workItem1 = DispatchWorkItem {
    print("Hello, World!")
}

@MainActor func excuteWorkItem() {
    queue.async(execute: workItem1)
}
workItem1.cancel()
//excuteWorkItem()


//MARK: Avoid Race Condition
//With DispathGroup enter and leave
//@MainActor
//func testMainActor() {
//    
//    let concurrentQueue2 = DispatchQueue(label: "com.example.concurrent", attributes: .concurrent)
//    let group2 = DispatchGroup()
//
//    var sharedArray = [Int]()
//
//    for i in 1...3 {
//        group2.enter()
//        concurrentQueue2.async {
//            print("Read: \(sharedArray)")
//            group2.leave()
//        }
//    }
//
//    group.notify(queue: concurrentQueue2) {
//        concurrentQueue2.async(flags: .barrier) {
//            sharedArray.append(42) // Wtite when all read task finished
//            print("Write: \(sharedArray)")
//        }
//    }
//
//}
//testMainActor()
