/*
 1. Access Control Modifiers
 These are the keywords already mentioned, which define access to the members of a type:
 open: Can be accessed and overridden from other modules.
 public: Can be accessed from other modules, but cannot be overridden.
 internal: (Default) Only accessible within the same module.
 fileprivate: Only accessible within the same source file.
 private: Only accessible within its scope.
 
 2. Type Behavior Modifiers
 These keywords define how a member is associated with the type, rather than its instance.
 static: Belongs to the type and cannot be overridden. Can be used with classes, structs, and enums.
 class: Belongs to the type, but can be overridden by subclasses. Can only be used with classes.
 
 3. Modifiers Related to Inheritance & Lifecycle
 These keywords affect how subclasses inherit and behave.
 final: Prevents a class, property, or method from being overridden.
 override: Required when overriding a method or property from a parent class.
 required: Forces subclasses to implement a specified initializer.
 convenience: Marks an initializer as the class's secondary initializer.
 lazy: Delays initialization of a property until it is first accessed.
 mutating: Allows a method to change properties of a value type such as a struct or enum.
 nonmutating: The opposite of mutating, allows a method to not change the value.
 
 4. Modifiers Related to Property & Parameter
 These keywords determine how a property or parameter is stored or processed.
 weak: Creates a weak reference that does not increase the object's reference count, preventing a reference cycle.
 unowned: Creates a non-owning reference, similar to weak but assuming that the referenced object will never be released during the lifetime of the reference.
 inout: Allows a function parameter to be changed inside the function and retains that change after the function ends.
 
 5. Modifiers Related to Concurrency
 These are new keywords in Swift, used to handle asynchronous tasks.
 async: Marks a function as asynchronous (can be paused and resumed).
 await: Calls an async function and pauses execution until it completes.
 throws: Indicates that a function can throw an error.
 rethrows: Indicates that a function only throws an error if one of its closures throws an error.
 actor: A type that helps manage concurrent access to state data to avoid race conditions.
 */
