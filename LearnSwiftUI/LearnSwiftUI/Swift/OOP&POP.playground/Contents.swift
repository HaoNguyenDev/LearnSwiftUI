/*
 OOP
 Object Oriented Programming (OOP)
 
 OOP focuses on objects, which are defined by classes. An object combines both data (attributes) and behavior (methods).
 Characteristics:
 Class: Is a template for creating objects. Class supports single inheritance, meaning a child class can only inherit from one parent class.
 Inheritance: This is a core mechanism of OOP. It allows a child class to inherit the properties and methods of a parent class. However, it can lead to a tight and rigid class hierarchy, making it difficult to change or extend.
 Polymorphism: Achieved through inheritance and method overriding.
 Reference Type: A class is a reference type, meaning that when you pass an object, you are passing a reference to it.
 
 POP
 Protocol Oriented Programming (POP)
 POP focuses on protocols. A protocol defines a set of methods or properties that a data type (such as a class, struct, or enum) must conform to.
 Characteristics:
 Protocol: A blueprint that specifies what a data type should do. A data type can conform to multiple protocols, also known as multiple protocol inheritance.
 Composition: This is the core mechanism of POP. Instead of inheriting from a parent class, you combine behaviors by conforming to multiple protocols. This creates more flexible, loosely coupled, and reusable code.
 Protocol Extension: Allows you to provide a default implementation for protocol methods, reducing code duplication.
 Value Type: POP works very well with structs and enums, which are value types, avoiding potential problems of sharing state in reference types.
 
 Detailed Comparison
 Characteristics   Object Oriented Programming (OOP)                                    Protocol Oriented Programming (POP)
 Thinking          "What is it?"                                                        "What can it do?"
 Core              Mechanism Inheritance                                                Composition
 Flexibility       Decreased, due to strict inheritance tree dependency.                Increased, because a data type can conform to multiple protocols.
 Extension         More difficult when changing parent classes.                         Easier to extend by adding protocols or protocol extensions.
 Polymorphism      Achieved through class inheritance.                                  Achieved through protocol conformity.
 Suitable for      Problems with clear "is-a" relationships (e.g., Car is a Vehicle).   Problems with "can do" relationships (e.g., FlyingCar can do Flyable and Drivable).
 */
