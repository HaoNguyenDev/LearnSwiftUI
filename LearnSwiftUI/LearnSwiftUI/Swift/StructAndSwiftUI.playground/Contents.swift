/*
 Why Apple Uses Struct in SwiftUI
 
 1. Immutability and Predictability
    - Struct is a Value Type: When you modify a struct, Swift creates a new copy of it instead of directly changing the original (as with a class - a reference type).
    - Suitable for the Reactive Model: This ensures that each View is a function of the state at a given point in time. When the state changes, SwiftUI can efficiently create a new struct View and diff it with the old View to update only the necessary parts of the interface. This makes managing state and data flow easier and more predictable.
 
 2. Performance and Efficiency
    - Memory Allocation: Structs are often allocated on the Stack instead of the Heap (like classes). Allocation on the Stack is faster and reduces the burden on the memory management system (reducing Reference Counting), thereby improving performance.
    - Efficient Creation and Copying: Views in SwiftUI are small, simple structs, allowing them to be created and copied very quickly and almost for free. This allows SwiftUI to efficiently recreate the entire View Hierarchy every time the state changes without causing performance issues.
    - Avoid Redundant Inheritance: In UIKit (using classes), Views inherit a lot of properties and methods from their parent UIView, even if they are not needed. Structs in SwiftUI contain only the properties defined, eliminating the burden of unnecessary inheritance.
 
 3. Thread Safety
    - Since structs are value types and immutable (by default), they eliminate common issues of Race Conditions and shared state in multithreaded environments, making SwiftUI safer when dealing with concurrency.
 
 4. Simplified Memory Management
    - Since they are value types, structs do not suffer from complex memory management issues like Retain Cycle (strong reference cycle) that often occur with classes (reference types).
 
 Advantages                 Explanation
 Immutability               Ensures View state is encapsulated and only changes through the State/Binding mechanism, making code easier to understand and maintain.
 High performance           Stack allocation speed and fast creation/copying ability, allowing SwiftUI to update the interface efficiently.
 Thread safety              Minimizes the risk of working in a multi-threaded environment thanks to immutability, avoiding unintended shared state.
 Easy memory management     Eliminates the risk of Retain Cycle.
 Encouraging Composition    Struct does not support inheritance, encourages the use of composition (combining small Views) to create complex Views, leading to better modular and reusable code.
 */
