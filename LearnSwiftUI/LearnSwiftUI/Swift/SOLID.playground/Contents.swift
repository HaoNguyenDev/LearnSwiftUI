/*
 SOLID Principles
 
 SOLID stands for five key principles: Single Responsibility Principle, Open-Closed Principle, Liskov Substitution Principle, Interface Segregation Principle, and Dependency Inversion Principle.
 
 These principles aim to make code more maintainable, extensible, and reusable. They encourage flexible design of classes and modules, minimize tight dependencies between components, and avoid common problems like “spaghetti” code.
 
 1. Single Responsibility Principle (SRP) - Single Responsibility
 Explanation: A class should have only one reason to change, that is, it should have only one responsibility.
 
 For example, instead of adding an if-else statement every time a new type of object is introduced, we can use protocols or inheritance to add new functionality without modifying existing code.
 Why is it important?: Reduces complexity, makes it easier to maintain, and makes it easier to test.
 
 2. Open-Closed Principle (OCP) - Open for Extension, Closed for Modification
 Explanation: Classes should be easy to extend (add new features) without modifying the old code.
 Why is it important?: Prevents errors when modifying code, increases flexibility.
 
 3. Liskov Substitution Principle (LSP) - Liskov Substitution
 Explanation: Subclasses should be able to replace parent classes without breaking the program.
 This principle ensures that polymorphism is safe. If a subclass violates this principle, it can cause unexpected errors when used in place of the parent class.
 Why is it important?: Ensures consistency when using inheritance and polymorphism, and avoids runtime errors.
 
 4. Interface Segregation Principle (ISP) - Interface Segregation
 Explanation: Don't force classes to implement methods they don't need.
 In Swift, use protocols to break down interfaces.
 When new methods are needed, conform to the corresponding protocol
 Use protocols in Swift to break down interfaces. This helps avoid "fat protocols", where a protocol contains too many methods that are not needed by all objects that conform to it.
 Why is it important?: Avoid redundant code, reduce dependencies, increase flexibility.
 
 5. Dependency Inversion Principle (DIP) - Dependency Inversion Principle
 Explanation: High-level classes do not depend on low-level classes, both should depend on abstractions
 For example: Like protocols in Swift, inject a class that conforms to a defined protocol, instead of injecting a specific class).
 Why is it important?: Reduce tight coupling, easy to change and test.
 */
 
