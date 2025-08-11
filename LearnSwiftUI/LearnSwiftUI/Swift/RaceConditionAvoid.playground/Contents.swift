import Foundation

// MARK: Barrier
//struct DemoBarrierQueue {
//    let concurrentQueue = DispatchQueue(label: "com.example.concurrent", attributes: .concurrent)
//    func run() {
//        concurrentQueue.async {
//            print("Task 1 .....")
//            Thread.sleep(forTimeInterval: 2)
//            print("Task 1 finish")
//        }
//
//        concurrentQueue.async {
//            print("Task 2 .....")
//            Thread.sleep(forTimeInterval: 1)
//            print("Task 2 finish")
//        }
//
//        concurrentQueue.async {
//            print("Task 3 .....")
//            Thread.sleep(forTimeInterval: 1)
//            print("Task 3 finish")
//        }
//
//        concurrentQueue.async(flags: .barrier) {
//            print("Task 4 .....")
//            Thread.sleep(forTimeInterval: 1)
//            print("Task 4 finish")
//        }
//
//        concurrentQueue.async {
//            print("Task 5 .....")
//            Thread.sleep(forTimeInterval: 2)
//            print("Task 5 finish")
//        }
//
//        concurrentQueue.async {
//            print("Task 6 .....")
//            Thread.sleep(forTimeInterval: 2)
//            print("Task 6 finish")
//        }
//    }
//
//
//}
//
//let demoBarrierQueue = DemoBarrierQueue()
//demoBarrierQueue.run()

//MARK: Smaphore
//struct SmaphoreDemo {
//    let concurrentQueue = DispatchQueue(label: "com.example.concurrent", attributes: .concurrent)
//    let semaphore = DispatchSemaphore(value: 1)
//    func run() {
//        for i in 1...10 {
//            DispatchQueue.global().async {
////                concurrentQueue.sync {
//                    self.semaphore.wait()
//                    print("Task \(i) start")
//                    Thread.sleep(forTimeInterval: 0.5)
//                    print("Task \(i) finish")
//                    self.semaphore.signal()
////                }
//               
//            }
//        }
//    }
//}
//
//let smaphoreDemo = SmaphoreDemo()
//smaphoreDemo.run()

    //MARK: NSLOCK
struct DemoNSLock {
    let nsLock = NSLock()

    func run() {
        for i in 1...10 {
            DispatchQueue.global().async {
                nsLock.lock()
                print("Task \(i) .....")
                Thread.sleep(forTimeInterval: 0.5)
                print("Task \(i) finish")
                nsLock.unlock()
            }
        }
    }
}

let demoNSLock = DemoNSLock()
demoNSLock.run()


