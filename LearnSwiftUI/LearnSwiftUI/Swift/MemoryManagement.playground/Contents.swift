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
 - Use GCD (Grand Central Dispatch) or Operation Queues to perform heavy tasks (e.g., data loading, image processing) on ​​background threads, to prevent UI freezing.
 - Prefer using structs and enums instead of classes when possible, as they are value types and more memory efficient.
 - Avoid nested loops or complex algorithms when processing large amounts of data. Look for more efficient algorithms.

 Performance Testing and Monitoring:
 - Use Instruments in Xcode to analyze performance, detect memory leaks, and check CPU/GPU usage.
 - Always test your app on real devices, not just the simulator.
 */
