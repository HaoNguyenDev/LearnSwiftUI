class AccessControl {
    var value: Int {
        get {
            return _value
        }
        set {
            _value = newValue
        }
    }
    
    // MARK: Private
    private var _value: Int = 0
    /*
     Most restrictive access level.
     Scope: A private entity can be used only within the enclosing declaration and to extensions of that declaration that are in the same file.
     Use case: This is used to hide implementation details of a specific piece of functionality when those details are used only within a single declaration (e.g., a single class or struct).
     */
    
    // MARK: fileprivate
    fileprivate func printValue() {
        print("value: \(value)")
    }
    /*
     Scope: A fileprivate entity can be used only within its defining source file.
     Use case: This is helpful for hiding implementation details that need to be shared across multiple types or extensions within a single file.
     For example, if you have a class and an extension in the same file that both need to access a helper method, fileprivate is a good choice.
     */
    
    // MARK: internal
    internal let pi = 3.14
    /*
     Default access level.
     Scope: An internal entity can be used within any source file from its defining module, but not from outside that module.
     Use case: This is the most common access level for app development, where you want to share functionality across your application's entire module but not expose it to other modules or frameworks that might use your code.
     */
    
    // MARK: public
    public func printPi() {
        print("pi: \(pi)")
    }
    /*
     Scope: A public entity can be used within its defining module and in any other module that imports the defining module.
     Key difference from open: It does not allow for subclassing or overriding outside of the defining module. A public class can only be subclassed within its own module, and a public class member can only be overridden by subclasses within the same module. This is used for the public-facing API of a framework where you want to expose functionality but not allow for modification.
     */
    
    // MARK: open
    open func printSomething() {
        print("something")
    }
    /*
     Most permissive access level.
     Scope: An open class or class member can be used within its defining module and also in any other module that imports the defining module.
     Key difference from public: It allows for subclassing of open classes and overriding of open class members from other modules. This is primarily used when creating a framework that you want others to extend.
     */
    
}
