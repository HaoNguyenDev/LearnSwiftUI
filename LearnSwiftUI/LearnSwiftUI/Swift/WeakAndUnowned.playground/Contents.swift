import Foundation

class Customer {
    let name: String
    var card: CreditCard?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Customer \(name) is being deallocated")
    }
}

class CreditCard {
    let number: String
    let customer: Customer // Credit card always need a Customer
    
    init(number: String, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    
    deinit {
        print("CreditCard \(number) is being deallocated")
    }
}

// Test
var customer: Customer? = Customer(name: "John")
var card: CreditCard? = CreditCard(number: "1234-5678", customer: customer!)

customer?.card = card
print(card?.customer.name ?? "no name") // show John

// deallocated
customer = nil // Then Customer and CreditCard deallocated too
card = nil
// If strong reference then the objects will not deallocated

///
///
///
//MARK: Weak
protocol DataManagerDelegate: AnyObject {
    func didFetchData(_ data: String)
}

class DataManager {
    weak var delegate: DataManagerDelegate? // Delegate are weak to avoid retain cycle
    
    func fetchData() {
        print("Start fetching data...")
        Thread.sleep(forTimeInterval: 3)
        delegate?.didFetchData("Some data")
    }
    
    deinit {
        print("DataManager is being deallocated")
    }
}

class ViewController: DataManagerDelegate {
    let dataManager = DataManager()
    
    init() {
        dataManager.delegate = self
    }
    
    func didFetchData(_ data: String) {
        print("Received data: \(data)")
    }
    
    deinit {
        print("ViewController is being deallocated")
    }
}

// Test weak
var vc: ViewController? = ViewController()
vc?.dataManager.fetchData() // Show: Received data: Some data
vc = nil // ViewController and DataManager deallocated too
