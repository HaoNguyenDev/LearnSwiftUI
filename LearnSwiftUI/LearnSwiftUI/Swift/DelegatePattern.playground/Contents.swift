import Foundation

/*
 Delegate Pattern is a way for one object to delegate tasks or pass data/information to another object.
 It is used to reduce the dependency between two objects,
 allowing them to communicate flexibly without having to know about each other's details.
 
 *** Not suitable for one-to-many communication
 */
protocol DelegateProtocol: AnyObject {
    func doSomething(parameter: String)
}

class Delegator: DelegateProtocol {
    func doSomething(parameter: String) {
        print("Delegator: \(parameter)")
    }
}

class DelegateWorker {
    weak var delegate: DelegateProtocol?
    
    func doSomething() {
        delegate?.doSomething(parameter: "Hello, World!")
    }
}


let delegator = Delegator()
let worker = DelegateWorker()
worker.delegate = delegator
worker.doSomething()
