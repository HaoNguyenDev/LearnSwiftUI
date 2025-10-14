import UIKit
import Foundation

//MARK: Closure
/*
What is Closure in Swift?
* Closure in Swift is a self-contained block of code that can be passed around and reused in code.

Closure can take parameters, return values, and can capture variables,
constants from the scope around it.

Closure in Swift can be considered an anonymous function because it does not need to declare a name like a normal function.

Compared to function:
No name, can be assigned to a variable, or passed as a parameter
Can capture external variables

📌 Benefits of [weak self]
✅ If self is released, the closure will not retain it, avoiding retain cycles.
✅ self in the closure will become nil if the object has been deleted.

Function
Called directly by name
Cannot capture external variables unless using @escaping
*/
/*
 { (parameters) -> ReturnType in
    // Code to execute
 }
 */
var myClosure1: (String) -> String
var myClosure2: (Int, Int) -> Bool
var myClousre3 = {
    return 10
}
myClosure1 = { (str) -> String in
    return str
}
print(myClosure1("Hello myClosure1"))

var myClosure3 : (Int, Int) -> Int = { (a,b) -> Int in
    return a+b
}

//MARK: Usage Closure
//MARK: Make closure as function parameter:

var sumTwoNumberFormular: (Int, Int) -> String = { (a, b) -> String in
    return "\(a + b)"
}

func total(_ a: Int, _ b: Int, operation: (Int, Int) -> String) -> String {
    return "Total: \(operation(a, b))"
}

let totalValue = total(10, 20, operation: sumTwoNumberFormular)



//MARK: Use closure with map, filter, reduce:
let numbers: [Int?] = [1, 2, nil, 3, 4, 5, nil, 6, 8, 10, nil]

let evenNumberClosure:  (Int) -> Bool = { number in
    return number % 2 == 0
}

let compactMapNumber = numbers
    .compactMap { $0 } // Remove nil element
    .filter(evenNumberClosure) // Take even number only

let evenNumber1 = compactMapNumber.filter { $0 % 2 == 0 } // Filter elements that satisfy the condition

let evenNumber2 = compactMapNumber.filter(evenNumberClosure) // Filter elements that satisfy the condition closure

let oneValue = compactMapNumber.reduce(0, +) // Combine elements into one value

let transformEachElement = compactMapNumber.map { $0 + 1 } // Transform each element

let xapXepTangDan = compactMapNumber.sorted { $0 > $1 } // Sort array

compactMapNumber.forEach { print($0) } // Loop through each element

//MARK: Escaping Closure
//Closures can be stored and called later using @escaping:

var scheduledTasks: [(String) -> Void] = []

@MainActor func scheduleTask(task: @escaping (String) -> Void) {
    scheduledTasks.append(task)
}

// Add to to list
scheduleTask { taskName in
    print("Run task: \(taskName)")
}

scheduleTask { taskName in
    print("Log: \(taskName) completed")
}

// When it comes time to do the work
@MainActor func runScheduledTasks() {
    print("Excuting scheduled tasks:")
    for task in scheduledTasks {
        task("Backup data")
    }
}

// Simulate running all scheduled jobs
runScheduledTasks()



print("Closure Capture List can Capture variables from its surrounding scope")
// MARK: Closure can Capture variables from its surrounding scope

@MainActor func increaseCounter(numberParam: Int) -> (Int) -> Int {
    // Clousure capture number variable to excute for next time
    var number = numberParam
    return { input in
        print("input: \(input)")
        number += input
        return number
    }
}

let numberIncreased = increaseCounter(numberParam: 1)
print(numberIncreased(1))
print(numberIncreased(1))
print(numberIncreased(1))
print(numberIncreased(3))

@MainActor func countUp() -> (Int) -> Int {
    var counter = 0
    return { increment in
        counter += increment
        return counter
    }
}

let countUp1 = countUp()
print(countUp1(1))
print(countUp1(1))
print(countUp1(1))

print("Trailing Closure")
//MARK: Trailing Closure:
// The syntax will be more concise when the closure is the last parameter of the function
// For example, sort and filter APIs
func doSomething(completion: (Bool) -> String) -> String {
    completion(true)
}

doSomething { isCompletion in
    print(isCompletion)
    return "Is completion: \(isCompletion)"
}


let findEvenNumber: (Int) -> Bool
findEvenNumber = { number in
    number % 2 == 0
}

let ascendingOrder: (Int, Int) -> Bool
ascendingOrder = { a, b in
    a < b
}

//ascendingOrder = { $0 < $1 }

let soNgauNhien: [Int?]  = [nil, 11, 12, 15, nil, 18, 20, 0, nil, 2, 3, 4, nil, 5, 6, 7, 8, 9, 10]

let daySoUnwrap = soNgauNhien.compactMap { $0 }
let daySoChan1 = daySoUnwrap.filter(findEvenNumber)
let soTangDan = daySoChan1.sorted(by: ascendingOrder)
let soTangDan2 = daySoUnwrap.sorted { s1, s2 in s1 < s2 }
let soTangDan3 = daySoUnwrap.sorted { $0 < $1 }
let soTangDan4 = daySoUnwrap.sorted(by: <)
let compacMap = soNgauNhien.compactMap { $0 } // Remove nil element

let inSo: (Int) -> Void = { number in
    print("\(number % 2 == 0 ? "Even number\(number)" : "Odd number \(number)")")
}
daySoUnwrap.forEach(inSo)
