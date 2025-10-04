import Combine

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
 Real World Example: Handling TextFields
 Let's look at a concrete and easy-to-understand example: checking the length of text in a TextField and only updating it when the user stops typing for a short while.

 1. Prepare the Publisher (Using CurrentValueSubject)
 In Combine, **Subject** is a special kind of Publisher that allows you to actively inject new values ​​into the stream at any time. CurrentValueSubject holds the current value.
 
 import Combine
 import Foundation

 // 1. Initialize a Subject that emits a String and never fails (Never)
 var usernamePublisher = CurrentValueSubject<String, Never>("InitialName")

 // Variable to store the subscription object to prevent it from being destroyed immediately
 var cancellables = Set<AnyCancellable>()
 
 2. Define Operator String
 We will define a sequence of operations:

 Operator: debounce
 Meaning: Waits for a certain amount of time (e.g. 0.5 seconds) and only emits the last value if no new value has been emitted in that time. Very useful for searching.
 Operator: map
 Meaning: Transforms the value. Here, transforms the String to a Bool (checks if the length is ≥5).
 
 Operator: removeDuplicates
 Meaning: Filters out consecutive identical values. If the user types "abc" and then types "abcde", we will only get the change when the length changes from != 5 to ≥5
 
 usernamePublisher
 // 2. Wait 0.5 seconds after a new value before continuing
 .debounce(for: .seconds(0.5), scheduler: RunLoop.main)

 // 3. Convert String to a Bool (e.g. check length > 4)
 .map { text in
        return text.count >= 5
    }

 // 4. Only emit a value if it is different from the last emitted value
 .removeDuplicates()

 // 5. Register a Subscriber to receive the result
 .sink { isValid in
        print("Valid test result: \(isValid)")
    }
 // Store the subscriber object (cancellable) to keep the thread running
 .store(in: &cancellables)
 
 Benefits of Combine
 Readable: Chaining makes it easy to track where data comes from and what steps it goes through.
 Composable: You can easily combine multiple data streams or apply different operations flexibly.
 Declarative: You declare what you want to do with the data, rather than doing it step by step (imperative).
 Good integration: Combine integrates very well with SwiftUI (Apple uses attributes like @Published to automatically create Publishers) and other asynchronous APIs like URLSession (to make network requests).
 */
