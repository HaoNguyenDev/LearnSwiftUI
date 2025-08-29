import UIKit

/*
 The final keyword in Swift is used to:
 Prevent inheritance (for classes): When a class is marked as final, no other class can inherit from it.
 Prevent overriding (for methods, properties, or subscripts): When a method, property, or subscript is marked as final, it cannot be overridden in child classes.
 
 Use final for classes that are not designed to be inherited (like Singleton).
 This allows the compiler to optimize and make the code run faster.
 Use final for methods or properties that are important to ensure the integrity and correctness of the object, like a user authentication function.
 
 final also has an important performance benefit.
 When the compiler sees a class or method as final, it knows that it doesn't need to look up subclasses to see if there are any overriding versions.
 This allows the compiler to perform an optimization technique called static dispatch instead of dynamic dispatch.
 Static dispatch is significantly faster than dynamic dispatch.
 */

final class FinalClass {
    final var pi: Int = 0
    final func methodsAreFinal() {}
}
