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
 
 ​
 */
