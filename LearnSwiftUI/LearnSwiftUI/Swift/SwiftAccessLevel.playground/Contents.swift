// MARK: Open
/*
 open is the least restrictive access level, designed for frameworks. A class or class member marked as open can be accessed and overridden by any other module.
 */
open class OpenClass {
    open var openProperty: Int = 0
    open func openMethod() {}
}

// MARK: Public
/*
 public allows access to entities from any source file in the same module and from other modules. However, a public class or class member cannot be overridden by other modules, unlike open.
 */
public class PublicClass {
    public var publicProperty: Int = 0
    public func publicMethod() {}
}

// MARK: Internal
/*
 internal is the default access level in Swift. It allows access to entities from any source file within the same module, but not from outside that module.
 */
internal class InternalClass {
    internal var internalProperty: Int = 0
    internal func internalMethod() {}
}

// MARK: fileprivate
/*
 fileprivate restricts access to the current source file only. Entities marked as fileprivate can only be used in the file in which they are defined.
 */
fileprivate class FileprivateClass {
    fileprivate var fileprivateProperty: Int = 0
    fileprivate func fileprivateMethod() {}
}

// MARK: private
/*
 private is the most restrictive level of access. It limits access to entities only within their declaration (scope), not just within the file. For example, a private variable declared within a class can only be accessed from within that class, even if it is inherited.
 */

/*
 Summary and Explanation
 To make it easier to understand, you can visualize these levels as follows:
 
 open and public: For libraries or frameworks that you want others to use and interact with. open allows inheritance and overrides, while public does not.
 
 internal: For internal components of an application or a module. This is the default level because most of your code is usually used within that application.
 
 fileprivate and private: For internal implementation details. fileprivate is limited to the file level, while private is limited to the object or class level.
 
 private helps hide information, preventing access from outside, a very important concept in object-oriented (OOP) called Encapsulation.
 
 Choosing the right access level helps you build code in a safe and structured way, preventing unwanted access or modification to sensitive parts of the application.Observe an ObservableObject owned elsewhere
 */

/*
 Easy to understand summary
 You can visualize the access levels as follows:
 open / public: The main door of a building. People from other buildings can enter.
 internal: A private floor of a company in that building. Only employees of that company are allowed to enter.
 fileprivate: A small meeting room on that floor. Only people who are in the room can see and use the things inside.
 private: Your personal cabinet in the meeting room. Only you have the key.
 */
