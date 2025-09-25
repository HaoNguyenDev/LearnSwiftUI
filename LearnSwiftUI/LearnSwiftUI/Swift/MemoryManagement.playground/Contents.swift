/*
 How to Manage Memory and Save Memory
 
 Effective memory management in iOS programming revolves around the use of ARC (Automatic Reference Counting).
 ARC automatically tracks and frees unused objects, helping you avoid memory leaks.
 
 * Using Weak and Unowned References:
 - Weak is used when an object does not have strong ownership of another object, and that object can be released at any time (e.g., delegates and outlets). If the object is released, the weak reference will automatically become nil.
 - Unowned is used when you know for sure that the referenced object will always be present during the lifetime of the referenced object. If the object is deallocated, the unowned reference will become a dangling pointer and cause an application error if you try to access it because Unowned is not an optional type like Weak.
 
 Avoid Retain Cycles:
 - Retain cycles occur when two objects hold strong references to each other, resulting in ARC not being able to release both, causing a memory leak. You can solve this problem by using weak or unowned references.
 
 - Use appropriate Data Structures: Instead of using classes, consider using structs when you need to store simple data. Structs are value types, which help avoid reference counting problems and save memory.
   Don't use classes if you don't need inheritance to reduce the stress on ARC. ARC has to constantly scan to check and count references.
 
 * Optimize performance:
 
 UI/UX Optimization:
 - Use Auto Layout effectively by limiting the number of constraints and avoiding complex constraints.
 - Reduce the number of views on the screen. Use container views to manage child views and load only the necessary views.
 - Use reusable cells for UITableView and UICollectionView to optimize scrolling.

 Data Optimization:
 - Lazy Loading: Only load data when really needed, especially large data such as images or videos. Use lazy HStack, lazy VStack for SwiftUI
 - Caching: Use caching to store previously loaded data, helping to reduce the number of reloads from the internet.
 
 Code Optimization:
 - The golden rule is to never load data or do heavy processing on the main thread. Always do tasks like fetching images from the network, processing JSON, or saving data to disk on a background thread using GCD or async/await.
 - Use GCD (Grand Central Dispatch) or Operation Queues to perform heavy tasks (e.g., data loading, image processing) on ​​background threads, to prevent UI freezing.
 - Prefer using structs and enums instead of classes when possible, as they are value types and more memory efficient.
 - Avoid nested loops or complex algorithms when processing large amounts of data. Look for more efficient algorithms.

 Performance Testing and Monitoring:
 - Use Instruments in Xcode to analyze performance, detect memory leaks, and check CPU/GPU usage.
 - Always test your app on real devices, not just the simulator.
 
 Code and Compiler Optimization:
 - Reduce Dynamic Dispatch: In Swift, class methods are often called using dynamic dispatch, which costs more than static dispatch. To optimize, use the final keyword for class or func to tell the compiler that this method will not be overridden, thereby allowing the use of static dispatch. Similarly, using the private or fileprivate keywords also helps the compiler optimize.
 
 - Use Value Type (Struct/Enum): struct and enum are value types, which help avoid the memory management cost of reference types (classes). Prefer to use them for simple data.
 - Choose the right Data Structure:
    Array: Good for index access, but inserting/deleting at the top of the array is slow.
    Dictionary and Set: Best for searching, inserting, and deleting individual elements.
 
 Networking and Data Optimization:
 - Reduce Network Requests: Instead of calling multiple small APIs, combine related requests into one larger request.This reduces latency and saves battery.
 Use Caching: Store frequently used data (like images, JSON) on the device. This reduces network calls, speeds up loading, and reduces server load.
 Prefetching: Predict user behavior and preload data that is likely to be used next. For example, in a news app, you can preload the next article while the user is reading the current one.
 
 UI/Rendering Optimization:
 - Reduce View Hierarchy Complexity: A complex view hierarchy with many nested layers will slow down rendering performance. Simplify your view structure as much as possible.
 - Use Opaque Views: For non-transparent views, make sure their opaque property is set to true. This makes them more efficient to render because transparency doesn't need to be calculated.
 Optimize Images:
 - Reduce image size and weight to the minimum necessary. A 5000x5000px image will consume memory and slow down performance if it is only displayed in a 100x100px frame.
 - Use modern, optimized image formats.
 
 Using Pro Tools
 - Instruments: This is an indispensable tool in Xcode for performance analysis. You can use Instruments to:
 - Time Profiler: Find CPU bottlenecks.
 - Allocations: Monitor memory usage and detect memory leaks.
 - Energy Log: Check your app's energy consumption.
 - Asynchronous Programming (Async/Await): With Swift 5.5 and above, use async/await to manage complex asynchronous tasks (like network calls) in a more efficient and readable way, ensuring the main thread is always freed to update the UI.
 */

