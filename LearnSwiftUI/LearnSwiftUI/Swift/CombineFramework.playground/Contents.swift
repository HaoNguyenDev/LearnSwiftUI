import Foundation
import Combine

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
var cancellables = Set<AnyCancellable>()
/*
 What is the Combine Framework?
 Combine is a framework introduced by Apple to provide a declarative approach to handling asynchronous events over time.

 Simply put, Combine helps you manage the flow of data over time, such as:
 Network responses: When the application fetches data from the internet.
 User interactions: Pressing a button, changing text in an input field.
 Timers: Events that repeat after a certain period of time.
 Instead of using old techniques like Callbacks or Delegates which can easily lead to Callback Hell (nesting too many callback functions), Combine allows you to create a chain of data processing operations in a flexible, readable and maintainable way.
 
 Combine Core Concepts
 Combine is based on three main components that interact with each other:

 1. Publisher
 What is it? A Publisher is an object that can emit values ​​over time.
 Emitted Values: Each Publisher has two types of Output values:
 Output: The type of data the Publisher will send (e.g., String, Int, a User object).
 Failure: The type of error the Publisher can send if the process fails (e.g., URLError, CustomError).
 Conclusion: A Publisher will send 0 or more Output values ​​and only one of two ending events:
 Completion.
 Failure.
 
 2. Subscriber
 What is it? A Subscriber is an object that can receive values ​​and completion events from a Publisher.
 Start: When a Subscriber registers with a Publisher, the association begins.
 Request: The Subscriber must request the number of values ​​it wants to receive from the Publisher. Typically, it will request an unlimited number of values.
 Receive: The Subscriber receives Output values ​​and Completion or Failure events.
 
 3. Operator
 What is it? Operators are special methods placed between the Publisher and the Subscriber.
 Function: They change, filter, combine, or transform the values ​​emitted from the Publisher before they reach the Subscriber.
 Examples: map, filter, debounce, combineLatest.
 Publisher
 Publisher -> Operator 1 -> Operator 2 -> Subscriber
 */
 
/*
 Benefits of Combine
 Readable: Chaining makes it easy to track where data comes from and what steps it goes through.
 Composable: You can easily combine multiple data streams or apply different operations flexibly.
 Declarative: You declare what you want to do with the data, rather than doing it step by step (imperative).
 Good integration: Combine integrates very well with SwiftUI (Apple uses attributes like @Published to automatically create Publishers) and other asynchronous APIs like URLSession (to make network requests).
 */

// MARK: - Subjects

// MARK: - PassthroughSubject
/// In English: A Subject that broadcasts elements to its subscribers.
/// It does not have an ``initial value`` and only emits elements that are sent
/// *after* a subscription is established.
///
/// ⚙️ When to Use?
/// - To model event streams where you only care about ``transient events``
///   (e.g., button taps, notifications, user actions).
/// - When integrating non-Combine code (legacy code, delegation, or completion handlers)
///   into a Combine pipeline.
///
/// ⚠️ Notes:
/// - Since it doesn't hold a value, new subscribers will **not** receive the
///   ``most recently emitted value``.
/// - You must manually call `.send(value)` to emit an element, and `.send(completion:)`
///   to end the stream.

class PassthroughSubjectDemo {
    
    @MainActor func runDemo() {
        print("--- Demo PassthroughSubject ---")
        
        let subject = PassthroughSubject<String, Never>()
        
        // 1. Send the value BEFORE subscribing (Subject will ignore it)
        subject.send("Ignored value (Pre-subscription)")
        
        // 🚨 Subscriber 1 has subscribed
        let subcription1 = subject
            .sink { value in
                debugPrint("Subscription 1 received: \(value)")
            }
        
        subcription1.store(in: &cancellables)
        
        // 2. Send the value AFTER registration (S1 receives)
        subject.send("First event (Post-subscription)")
        
        // 🚨 Subscriber 2 has subscribed
        let subscription2 = subject
            .sink { value in
                debugPrint("Subscription 2 received: \(value)")
            }
        subscription2.store(in: &cancellables)
        
        subject.send("Second event (Both received)")
        
        subject.send(completion: .finished)
        
        print("--- End of PassthroughSubject Demo ---")
        
    }
}

//let passthroughSubjectDemo = PassthroughSubjectDemo()
//passthroughSubjectDemo.runDemo()

// MARK: - CurrentValueSubject
/// In English: A Subject that broadcasts elements to its subscribers, retaining the
/// ``most recently published element`` and emitting it immediately to new subscribers.
/// It must be initialized with an initial value.
///
/// ⚙️ When to Use?
/// - To model ``state or persistent data`` within an application (e.g., current login status, shopping cart count).
/// - When new subscribers need immediate access to the current state of the data.
///
/// ⚠️ Notes:
/// - It must be initialized with a ``non-optional initial value``.
/// - You can always synchronously access the current value using the `.value` property.

class CurrentValueSubjectDemo {
    
    @MainActor func runDemo() {
        debugPrint("--- Demo CurrentValueSubject ---")
        
        let initialValue = 10
        let subject = CurrentValueSubject<Int, Never>(initialValue)
        
        // 1. Check init value
        debugPrint("Initial Value (before registration): \(subject.value)")
        
        debugPrint("Subscriber 1 subcribing...")
        // 2. Subscriber 1 subscribes (Receives 10 immediately)
        let subscription1 = subject
            .sink { value in
                debugPrint("Subscription 1 received: \(value)")
            }
        subscription1.store(in: &cancellables)
        
        debugPrint("Sending new value...")
        subject.send(20)
        
        debugPrint("Subscriber 2 subcribing...")
        let subscription2 = subject
            .sink { value in
                debugPrint("Subscription 2 received: \(value)")
            }
        subscription2.store(in: &cancellables)
        
        debugPrint("Sending new value...")
        subject.send(30)
        
        debugPrint("Current value (after several sends): \(subject.value)")
        
        subject.send(completion: .finished)
        
        debugPrint("--- End of CurrentValueSubject Demo ---")
    }
}

let currentValueSubjectDemo = CurrentValueSubjectDemo()
currentValueSubjectDemo.runDemo()

// MARK: - Just
/// Publishes an output to a subscriber just once, and then finishes.
/// It's useful for immediately supplying a value to a downstream operator.
/// The `Failure` type is always ``Never``.
///
/// ⚙️ When to Use?
/// - When you need to create a simple Publisher to ``start a Combine chain`` with a fixed, known value.
/// - In functions that return a Publisher, but you already have the value synchronously and need to wrap it to conform to the Combine API.
///
/// ⚠️ Notes:
/// - `Just` is one of the simplest Publishers to initialize and test.
/// - Because it emits the value and ``completes immediately``, it is often used to model a synchronous action within an asynchronous pipeline.

class JustDemo {
    var cancellables = Set<AnyCancellable>()

    func runDemo() {
        print("--- Demo Just Operator ---")

        let publisher = Just(42)
      
        publisher
            .sink(receiveValue: { value in
                debugPrint("Just emitted: \(value)")
            })
            .store(in: &cancellables)
    }
}

// JustDemo().runDemo()

// MARK: - Future
/// A Publisher that eventually produces a single value and then finishes,
/// or fails. It wraps an ``asynchronous operation`` that takes a closure argument
/// for resolving the result.
///
/// ⚙️ When to Use?
/// - When you want to adapt an asynchronous API that relies on a ``completion handler``
///   (e.g., network functions, database calls) into a Combine Publisher.
/// - When you need a Publisher that guarantees to emit ``only a single value``
///   (or an error) after the asynchronous process is complete.
///
/// ⚠️ Notes:
/// - The operation inside `Future` is executed **immediately** when the Future is initialized,
///   ``not`` when it is subscribed to.
/// - If multiple Subscribers subscribe to the same `Future`, they will all receive the
///   ``same single result`` after the internal operation has completed.

enum DataError: Error {
    case networkError
    case parsingError
}

class FutureDemo {
    var cancellables = Set<AnyCancellable>()
    
    // Function to simulate asynchronous data loading
    func fetchData(shouldSucceed: Bool) -> Future<String, DataError> {
        return Future { promise in
            if shouldSucceed {
                // Success: value sent via promise
                promise(.success("Data has been successfully loaded!"))
            } else {
                // Failure: sending error via promise.
                promise(.failure(.networkError))
            }
        }
    }
    
    func runDemo() {
        print("--- Demo Future Operator ---")
        
        // --- Test Successful case ---
        fetchData(shouldSucceed: true)
            .sink { completion in
                print("1. Trạng thái: \(completion)")
                                // Tắt execution sau khi nhận kết quả thành công
                                if case .finished = completion {
                                     PlaygroundPage.current.needsIndefiniteExecution = false
                                }
            } receiveValue: { value in
                debugPrint("Value received: \(value)")
            }
            .store(in: &cancellables)
    }
}

//let demo = FutureDemo()
//demo.runDemo()
