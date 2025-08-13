import UIKit

print("---------------------- Queue Example ----------------------")
// Queue operates on the FIFO (First In, First Out).
// 3,2,1 -> [3,2,1] -> 1,2,3

struct Queue<T> {
    var elements: [T] = []
    
    mutating func enqueue(_ queue: T) {
        elements.append(queue)
    }
    
    mutating func dequeue() -> T? {
        return elements.isEmpty ? nil : elements.removeFirst()
    }
}

var queue = Queue<String>()
queue.enqueue("1")
queue.enqueue("2")
queue.enqueue("3")

print(queue.elements)
print(queue.dequeue() ?? "Empty")
print(queue.elements)
print(queue.dequeue() ?? "Empty")
print(queue.elements)

print("---------------------- Stack Example ----------------------")
// Stack operates on the LIFO (Last In, First Out)
// 3,2,1 -> [3,2,1] -> 3,2,1

struct Stack<T> {
    var elements: [T] = []
    
    mutating func push(_ stack: T) {
        elements.append(stack)
    }
    
    mutating func pop() -> T? {
        return elements.isEmpty ? nil : elements.popLast()
    }
}

var stack = Stack<String>()
stack.push("1")
stack.push("2")
stack.push("3")

print(stack.elements)
print(stack.pop() ?? "Empty")
print(stack.elements)
stack.push("4")
print(stack.elements)
print(stack.pop() ?? "Empty")
print(stack.elements)
print(stack.pop() ?? "Empty")

print("---------------------- Heap (Referenced Counting) Example ----------------------")
// Definition: Heap in Swift is not a data structure like Queue or Stack but is related to memory management.
// Heap is a dynamic memory area where objects are allocated at runtime.

// In Swift, reference types like classes are stored on the Heap.
// Memory on the Heap is managed automatically by ARC (Automatic Reference Counting), which frees memory when there are no more references to an object.
// In Swift, every instance of a class (unlike a struct/enum) is stored on the heap, and the variable/constant you declare stores a reference (pointer) to that memory. variable/constant holds the address of the memory on the heap.
