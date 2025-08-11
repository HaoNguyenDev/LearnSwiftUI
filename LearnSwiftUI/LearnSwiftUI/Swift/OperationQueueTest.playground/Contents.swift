import Foundation

/*
 You should consider using Operation Queue in the following cases:
 Dependent tasks: When you need to execute a series of tasks in a specific order, where the next task can only start when the previous task has completed. For example, downloading an image, then applying a filter to that image, and finally saving it to disk.
 
 Cancelable tasks: When you need to allow the user to cancel a running process (e.g. cancel a download, cancel a long computation task).
 
 Need more granular control: When you need to monitor the status of tasks, change their priority, or limit the number of concurrent tasks to optimize performance and resource usage.
 
 Complex, reusable tasks: When tasks have complex logic and you want to encapsulate them into Operation classes for reuse.
 */
class OperationQueueTest {
    let operationQueue = OperationQueue()
    
    func test() {
        operationQueue.maxConcurrentOperationCount = 2
        
        print(">>> Start test")
        
        let block1 = BlockOperation {
            print("block1 start")
            Thread.sleep(forTimeInterval: 1)
            print("block1 result")
        }
        
        block1.completionBlock = {
            print("block1 finished")
        }
        
        let block2 = BlockOperation {
            print("block2 start")
            Thread.sleep(forTimeInterval: 1)
            print("block2 result")
        }
        
        block2.completionBlock = {
            print("block2 finished")
        }
        
        let block3 = BlockOperation {
            print("block3 start")
            Thread.sleep(forTimeInterval: 1)
            print("block3 result")
        }
        
        block3.completionBlock = {
            print("block3 finished")
        }
        
        let block4 = BlockOperation {
            print("block4 start")
            Thread.sleep(forTimeInterval: 1)
            print("block4 result")
        }
        
        block4.completionBlock = {
            print("block4 finished")
        }
        
//        block1.addDependency(block2)
//        block3.addDependency(block4)
        
        operationQueue.addOperations([block1, block2, block3, block4], waitUntilFinished: true)
        /* waitUntilFinished will block the call thread until the call thread are finish */
        
        print(">>> End")
    }
    

}

let testOperationQueue = OperationQueueTest()
testOperationQueue.test()
//testOperationQueue.testRunManyQueue()
//testOperationQueue.testPriorityOfOperation()
