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

/*
 struct vs class

 Features Class Struct
 Type | Reference Type | Value Type
 Inheritance | Can be inherited from other classes | Cannot be inherited
 Deinitializers | Have deinitializer to free resources | No deinitializer
 Polymorphism | Supports polymorphism | Does not support polymorphism in the way of classes
 ARC | Managed by ARC (Automatic Reference Counting) | Not managed by ARC
 Storage |Heap Storage | Stack Storage
 
 Advantages and Disadvantages
 1. Class (Reference Type)
 ✅ Advantages
 Inheritance: Allows inheritance of properties and methods from a parent class, allowing for code reuse and creating "is-a" relationships.
 Polymorphism: Supports polymorphism through method overriding and protocols.
 Deinitializer: Allows for cleanup operations before the object is released from memory.
 Use with Objective-C: Classes are required when interacting with Objective-C code (often found in older Apple frameworks).
 Identity: Has a unique Identity (memory address), allowing multiple references to the same instance.
 ❌ Disadvantages
 Shared Mutability: Because it is a reference type, if an instance is referenced by multiple variables, changing the instance's data through one variable will affect all other referenced variables. This can lead to unpredictable errors (side effects).
 Memory Management: Using ARC can lead to Reference Cycles if not managed carefully (need to use weak or unowned).
 Cost: Accessing data on the Heap is usually more expensive than on the Stack.
 
 2. Struct (Value Type)
 ✅ Advantages
 Predictable and safe: As a value type, when you assign or pass a struct, a copy of the data is created. Changing the copy will not affect the original. This helps prevent unwanted side effects.
 Performance: Stored on the Stack (for small structs), making memory allocation and release much faster.
 Immutability: Swift encourages the use of let with structs to create immutable objects, making code easier to understand and safer, especially in multi-threaded environments.
 Simple: No need to worry about ARC, Reference Cycles, or complex Identity management.
 ❌ Disadvantages
 No support for Inheritance: Cannot inherit properties or methods.
 Copying cost: For large structs, creating a copy on every assignment or cast can incur a significant performance cost (although Swift has optimizations like Copy-on-Write).
 
 When to use Class and Struct
 1. Use Struct when:
 You need to model a simple data value, such as:
 Point, Size, Distance.
 Simple configuration (e.g. Color, Rectangle).
 Data is small and frequently copied.
 You don't need Inheritance and Identity.
 You want thread-safety because each thread will keep a separate copy of the value.
 You want to combine with Protocols for flexibility.
 💡 Apple's rule: Most basic data types in Swift (like Int, String, Array, Dictionary, Optional) are Structs. You should favor value types unless there is a clear reason to use reference types.

 2. Use Class when:
 You need to Inherit from another class (e.g. UIViewController, UIKit classes).
 You need to model an Entity or an object with a unique Identity, where multiple parts of the application need to share and update the same state (e.g. User, NetworkManager, ShoppingCart).
 You need to use Deinitializer to manage resources.
 You need to work with Objective-C Code.
 
 */
