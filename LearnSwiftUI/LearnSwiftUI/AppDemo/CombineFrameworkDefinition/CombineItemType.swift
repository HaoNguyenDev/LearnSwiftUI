//
//  CombineItemType.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 2/10/25.
//

import Foundation

enum CombineItemType {
    case combinePublisher
    case combineSubscriber
    case combineOperator
}

struct CombineItem {
    let name: String
    let type: CombineItemType
    let description: String
    let codeDemo: String
}

struct CombineData {
    static let publishers: [CombineItem] = [
        CombineItem(
            name: "Just",
            type: .combinePublisher,
            description: "A Publisher that emits a single value and then completes.",
            codeDemo: """
            let publisher = Just("Hello, Combine!")
            publisher
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: Hello, Combine!
            """
        ),
        CombineItem(
            name: "Future",
            type: .combinePublisher,
            description: "A Publisher that emits a single value or an error asynchronously, then completes.",
            codeDemo: """
            let future = Future<String, Never> { promise in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    promise(.success("Hello, Future!"))
                }
            }
            future
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output after 1 second: Received value: Hello, Future!
            """
        ),
        CombineItem(
            name: "PassthroughSubject",
            type: .combinePublisher,
            description: "A Subject that broadcasts values to downstream subscribers without buffering.",
            codeDemo: """
            let subject = PassthroughSubject<String, Never>()
            subject
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            subject.send("Test")
            // Output: Received value: Test
            """
        ),
        CombineItem(
            name: "CurrentValueSubject",
            type: .combinePublisher,
            description: "A Subject that maintains its last value and emits it to new subscribers immediately.",
            codeDemo: """
            let subject = CurrentValueSubject<String, Never>("Initial")
            subject
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            subject.send("Updated")
            // Output: Received value: Initial
            //         Received value: Updated
            """
        ),
        CombineItem(
            name: "Deferred",
            type: .combinePublisher,
            description: "A Publisher that delays the creation of the underlying publisher until a subscriber attaches.",
            codeDemo: """
            let deferred = Deferred {
                print("Creating publisher")
                return Just("Hello, Deferred!")
            }
            deferred
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Creating publisher
            //         Received value: Hello, Deferred!
            """
        ),
        CombineItem(
            name: "Empty",
            type: .combinePublisher,
            description: "A Publisher that never emits any values and completes immediately.",
            codeDemo: """
            let publisher = Empty<String, Never>()
            publisher
                .sink(receiveCompletion: { completion in
                    print("Completion: \\(completion)")
                }, receiveValue: { value in
                    print("Received value: \\(value)")
                })
                .store(in: &cancellables)
            // Output: Completion: finished
            """
        ),
        CombineItem(
            name: "Fail",
            type: .combinePublisher,
            description: "A Publisher that immediately emits an error and completes.",
            codeDemo: """
            enum CustomError: Error { case failure }
            let publisher = Fail<String, CustomError>(error: .failure)
            publisher
                .sink(receiveCompletion: { completion in
                    print("Completion: \\(completion)")
                }, receiveValue: { value in
                    print("Received value: \\(value)")
                })
                .store(in: &cancellables)
            // Output: Completion: failure(__lldb_expr_3.CustomError.failure)
            """
        )
    ]
    
    static let subscribers: [CombineItem] = [
        CombineItem(
            name: "Subscribing to Publishers",
            type: .combineSubscriber,
            description: """
            In Combine, subscribing to a Publisher allows a Subscriber to receive values, errors, or completion events. Common ways to subscribe include:
            - `sink`: Receives values and completion events, typically used for simple subscriptions.
            - `assign`: Assigns values to a property of an object, useful for updating UI or state.
            - Custom Subscriber: Implement the `Subscriber` protocol for fine-grained control, including backpressure.
            """,
            codeDemo: """
            import Combine

            var cancellables = Set<AnyCancellable>()

            // 1. Using sink
            let publisher = Just("Hello, Combine!")
            publisher
                .sink { value in
                    print("Received via sink: \\(value)")
                }
                .store(in: &cancellables)

            // 2. Using assign
            class ViewModel {
                @Published var name: String = ""
            }
            let viewModel = ViewModel()
            publisher
                .assign(to: &\\ViewModel.name)
                .store(in: &cancellables)
            print("Assigned value: \\(viewModel.name)")

            // 3. Custom Subscriber
            class CustomSubscriber: Subscriber {
                typealias Input = String
                typealias Failure = Never

                func receive(subscription: Subscription) {
                    subscription.request(.max(1))
                }

                func receive(_ input: String) -> Subscribers.Demand {
                    print("Custom Subscriber received: \\(input)")
                    return .none
                }

                func receive(completion: Subscribers.Completion<Never>) {
                    print("Custom Subscriber completion: \\(completion)")
                }
            }
            publisher.subscribe(CustomSubscriber())

            // Output:
            // Received via sink: Hello, Combine!
            // Assigned value: Hello, Combine!
            // Custom Subscriber received: Hello, Combine!
            // Custom Subscriber completion: finished
            """
        )
    ]
    
    static let operators: [CombineItem] = [
        CombineItem(
            name: "map",
            type: .combineOperator,
            description: "Transforms each value emitted by a publisher using a provided closure.",
            codeDemo: """
            let publisher = [1, 2, 3].publisher
            publisher
                .map { $0 * 2 }
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 2
            //         Received value: 4
            //         Received value: 6
            """
        ),
        CombineItem(
            name: "tryMap",
            type: .combineOperator,
            description: "Transforms values and allows throwing errors during transformation.",
            codeDemo: """
            enum CustomError: Error { case invalid }
            let publisher = ["1", "2", "invalid"].publisher
            publisher
                .tryMap { value in
                    guard let intValue = Int(value) else { throw CustomError.invalid }
                    return intValue
                }
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output: Received value: 1
            //         Received value: 2
            //         Completion: failure(__lldb_expr_3.CustomError.invalid)
            """
        ),
        CombineItem(
            name: "flatMap",
            type: .combineOperator,
            description: "Transforms values into new publishers and flattens the results.",
            codeDemo: """
            let publisher = [1, 2].publisher
            publisher
                .flatMap { Just($0 * 10) }
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 10
            //         Received value: 20
            """
        ),
        CombineItem(
            name: "replaceNil",
            type: .combineOperator,
            description: "Replaces nil values with a provided value.",
            codeDemo: """
            let publisher = [1, nil, 3].publisher
            publisher
                .replaceNil(with: 0)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 1
            //         Received value: 0
            //         Received value: 3
            """
        ),
        CombineItem(
            name: "scan",
            type: .combineOperator,
            description: "Accumulates values into a running result.",
            codeDemo: """
            let publisher = [1, 2, 3].publisher
            publisher
                .scan(0) { $0 + $1 }
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 1
            //         Received value: 3
            //         Received value: 6
            """
        ),
        CombineItem(
            name: "setFailureType",
            type: .combineOperator,
            description: "Converts a publisher’s failure type to a specified type.",
            codeDemo: """
            let publisher = Just("Hello")
            publisher
                .setFailureType(to: Error.self)
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output: Received value: Hello
            //         Completion: finished
            """
        ),
        CombineItem(
            name: "mapError",
            type: .combineOperator,
            description: "Transforms an error into a different error type.",
            codeDemo: """
            enum CustomError: Error { case failure }
            enum NewError: Error { case newFailure }
            let publisher = Fail<String, CustomError>(error: .failure)
            publisher
                .mapError { _ in NewError.newFailure }
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output: Completion: failure(__lldb_expr_3.NewError.newFailure)
            """
        ),
        CombineItem(
            name: "replaceEmpty",
            type: .combineOperator,
            description: "Replaces an empty publisher with a provided value.",
            codeDemo: """
            let publisher = Empty<Int, Never>()
            publisher
                .replaceEmpty(with: 42)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 42
            """
        ),
        CombineItem(
            name: "replaceError",
            type: .combineOperator,
            description: "Replaces an error with a default value.",
            codeDemo: """
            enum CustomError: Error { case failure }
            let publisher = Fail<String, CustomError>(error: .failure)
            publisher
                .replaceError(with: "Default")
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: Default
            """
        ),
        CombineItem(
            name: "filter",
            type: .combineOperator,
            description: "Filters values based on a predicate.",
            codeDemo: """
            let publisher = [1, 2, 3, 4].publisher
            publisher
                .filter { $0 % 2 == 0 }
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 2
            //         Received value: 4
            """
        ),
        CombineItem(
            name: "tryFilter",
            type: .combineOperator,
            description: "Filters values and allows throwing errors during filtering.",
            codeDemo: """
            enum CustomError: Error { case invalid }
            let publisher = [1, 2, 3].publisher
            publisher
                .tryFilter { $0 < 3 ? true : throw CustomError.invalid }
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output: Received value: 1
            //         Received value: 2
            //         Completion: failure(__lldb_expr_3.CustomError.invalid)
            """
        ),
        CombineItem(
            name: "compactMap",
            type: .combineOperator,
            description: "Transforms values and filters out nil results.",
            codeDemo: """
            let publisher = ["1", "2", "invalid"].publisher
            publisher
                .compactMap { Int($0) }
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 1
            //         Received value: 2
            """
        ),
        CombineItem(
            name: "tryCompactMap",
            type: .combineOperator,
            description: "Transforms values, filters out nil, and allows throwing errors.",
            codeDemo: """
            enum CustomError: Error { case invalid }
            let publisher = ["1", "invalid"].publisher
            publisher
                .tryCompactMap { value in
                    guard let intValue = Int(value) else { throw CustomError.invalid }
                    return intValue
                }
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output: Received value: 1
            //         Completion: failure(__lldb_expr_3.CustomError.invalid)
            """
        ),
        CombineItem(
            name: "removeDuplicates",
            type: .combineOperator,
            description: "Removes consecutive duplicate values.",
            codeDemo: """
            let publisher = [1, 1, 2, 2, 3].publisher
            publisher
                .removeDuplicates()
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 1
            //         Received value: 2
            //         Received value: 3
            """
        ),
        CombineItem(
            name: "tryRemoveDuplicates",
            type: .combineOperator,
            description: "Removes duplicates and allows throwing errors during comparison.",
            codeDemo: """
            enum CustomError: Error { case invalid }
            let publisher = [1, 1, 2].publisher
            publisher
                .tryRemoveDuplicates { a, b in
                    if a == b { return true }
                    if a > 2 { throw CustomError.invalid }
                    return false
                }
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output: Received value: 1
            //         Received value: 2
            //         Completion: finished
            """
        ),
        CombineItem(
            name: "dropFirst",
            type: .combineOperator,
            description: "Drops the first n values emitted by a publisher.",
            codeDemo: """
            let publisher = [1, 2, 3, 4].publisher
            publisher
                .dropFirst(2)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 3
            //         Received value: 4
            """
        ),
        CombineItem(
            name: "drop(while:)",
            type: .combineOperator,
            description: "Drops values until a predicate returns false.",
            codeDemo: """
            let publisher = [1, 2, 3, 4].publisher
            publisher
                .drop { $0 < 3 }
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 3
            //         Received value: 4
            """
        ),
        CombineItem(
            name: "tryDrop(while:)",
            type: .combineOperator,
            description: "Drops values until a predicate returns false, allowing errors.",
            codeDemo: """
            enum CustomError: Error { case invalid }
            let publisher = [1, 2, 3].publisher
            publisher
                .tryDrop { $0 < 3 ? true : throw CustomError.invalid }
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output: Completion: failure(__lldb_expr_3.CustomError.invalid)
            """
        ),
        CombineItem(
            name: "drop(untilOutputFrom:)",
            type: .combineOperator,
            description: "Drops values until another publisher emits a value.",
            codeDemo: """
            let trigger = PassthroughSubject<Void, Never>()
            let publisher = [1, 2, 3].publisher
            publisher
                .drop(untilOutputFrom: trigger)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            trigger.send(())
            // Output: Received value: 1
            //         Received value: 2
            //         Received value: 3
            """
        ),
        CombineItem(
            name: "prefix",
            type: .combineOperator,
            description: "Emits only the first n values.",
            codeDemo: """
            let publisher = [1, 2, 3, 4].publisher
            publisher
                .prefix(2)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 1
            //         Received value: 2
            """
        ),
        CombineItem(
            name: "prefix(while:)",
            type: .combineOperator,
            description: "Emits values until a predicate returns false.",
            codeDemo: """
            let publisher = [1, 2, 3, 4].publisher
            publisher
                .prefix { $0 < 3 }
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 1
            //         Received value: 2
            """
        ),
        CombineItem(
            name: "tryPrefix(while:)",
            type: .combineOperator,
            description: "Emits values until a predicate returns false, allowing errors.",
            codeDemo: """
            enum CustomError: Error { case invalid }
            let publisher = [1, 2, 3].publisher
            publisher
                .tryPrefix { $0 < 3 ? true : throw CustomError.invalid }
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output: Received value: 1
            //         Received value: 2
            //         Completion: failure(__lldb_expr_3.CustomError.invalid)
            """
        ),
        CombineItem(
            name: "prefix(untilOutputFrom:)",
            type: .combineOperator,
            description: "Emits values until another publisher emits a value.",
            codeDemo: """
            let trigger = PassthroughSubject<Void, Never>()
            let publisher = [1, 2, 3].publisher
            publisher
                .prefix(untilOutputFrom: trigger)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            trigger.send(())
            // Output: (no values emitted if trigger sends immediately)
            """
        ),
        CombineItem(
            name: "merge",
            type: .combineOperator,
            description: "Combines values from multiple publishers into a single stream.",
            codeDemo: """
            let pub1 = [1, 2].publisher
            let pub2 = [3, 4].publisher
            pub1
                .merge(with: pub2)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 1
            //         Received value: 2
            //         Received value: 3
            //         Received value: 4
            """
        ),
        CombineItem(
            name: "combineLatest",
            type: .combineOperator,
            description: "Combines the latest values from multiple publishers.",
            codeDemo: """
            let pub1 = PassthroughSubject<Int, Never>()
            let pub2 = PassthroughSubject<String, Never>()
            pub1
                .combineLatest(pub2)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            pub1.send(1)
            pub2.send("a")
            // Output: Received value: (1, "a")
            """
        ),
        CombineItem(
            name: "zip",
            type: .combineOperator,
            description: "Pairs values from multiple publishers.",
            codeDemo: """
            let pub1 = [1, 2].publisher
            let pub2 = ["a", "b"].publisher
            pub1
                .zip(pub2)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: (1, "a")
            //         Received value: (2, "b")
            """
        ),
        CombineItem(
            name: "prepend",
            type: .combineOperator,
            description: "Prepends values or another publisher’s output to the stream.",
            codeDemo: """
            let publisher = [3, 4].publisher
            publisher
                .prepend(1, 2)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 1
            //         Received value: 2
            //         Received value: 3
            //         Received value: 4
            """
        ),
        CombineItem(
            name: "append",
            type: .combineOperator,
            description: "Appends values or another publisher’s output to the stream.",
            codeDemo: """
            let publisher = [1, 2].publisher
            publisher
                .append(3, 4)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 1
            //         Received value: 2
            //         Received value: 3
            //         Received value: 4
            """
        ),
        CombineItem(
            name: "switchToLatest",
            type: .combineOperator,
            description: "Switches to the latest publisher emitted by a publisher of publishers.",
            codeDemo: """
            let subject = PassthroughSubject<PassthroughSubject<Int, Never>, Never>()
            let pub1 = PassthroughSubject<Int, Never>()
            let pub2 = PassthroughSubject<Int, Never>()
            subject
                .switchToLatest()
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            subject.send(pub1)
            pub1.send(1)
            subject.send(pub2)
            pub2.send(2)
            // Output: Received value: 1
            //         Received value: 2
            """
        ),
        CombineItem(
            name: "reduce",
            type: .combineOperator,
            description: "Accumulates values into a single result.",
            codeDemo: """
            let publisher = [1, 2, 3].publisher
            publisher
                .reduce(0, +)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 6
            """
        ),
        CombineItem(
            name: "tryReduce",
            type: .combineOperator,
            description: "Accumulates values, allowing errors during reduction.",
            codeDemo: """
            enum CustomError: Error { case invalid }
            let publisher = [1, 2, 3].publisher
            publisher
                .tryReduce(0) { acc, value in
                    if value > 2 { throw CustomError.invalid }
                    return acc + value
                }
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output: Completion: failure(__lldb_expr_3.CustomError.invalid)
            """
        ),
        CombineItem(
            name: "collect",
            type: .combineOperator,
            description: "Collects all values into an array.",
            codeDemo: """
            let publisher = [1, 2, 3].publisher
            publisher
                .collect()
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: [1, 2, 3]
            """
        ),
        CombineItem(
            name: "collectByCount",
            type: .combineOperator,
            description: "Collects values into arrays of a specified size.",
            codeDemo: """
            let publisher = [1, 2, 3, 4].publisher
            publisher
                .collect(2)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: [1, 2]
            //         Received value: [3, 4]
            """
        ),
        CombineItem(
            name: "collectByTime",
            type: .combineOperator,
            description: "Collects values over a specified time interval.",
            codeDemo: """
            let publisher = Timer.publish(every: 0.5, on: .main, in: .common)
                .autoconnect()
                .map { _ in 1 }
            publisher
                .collect(.byTime(DispatchQueue.main, .seconds(1)))
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: [1, 1] (approximately every second)
            """
        ),
        CombineItem(
            name: "ignoreOutput",
            type: .combineOperator,
            description: "Ignores all values and only emits completion.",
            codeDemo: """
            let publisher = [1, 2, 3].publisher
            publisher
                .ignoreOutput()
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output: Completion: finished
            """
        ),
        CombineItem(
            name: "max",
            type: .combineOperator,
            description: "Emits the maximum value emitted by a publisher.",
            codeDemo: """
            let publisher = [3, 1, 4, 2].publisher
            publisher
                .max()
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 4
            """
        ),
        CombineItem(
            name: "tryMax",
            type: .combineOperator,
            description: "Emits the maximum value, allowing errors during comparison.",
            codeDemo: """
            enum CustomError: Error { case invalid }
            let publisher = [1, 2, 3].publisher
            publisher
                .tryMax { a, b in
                    if a > 2 { throw CustomError.invalid }
                    return a < b
                }
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output: Completion: failure(__lldb_expr_3.CustomError.invalid)
            """
        ),
        CombineItem(
            name: "min",
            type: .combineOperator,
            description: "Emits the minimum value emitted by a publisher.",
            codeDemo: """
            let publisher = [3, 1, 4, 2].publisher
            publisher
                .min()
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 1
            """
        ),
        CombineItem(
            name: "tryMin",
            type: .combineOperator,
            description: "Emits the minimum value, allowing errors during comparison.",
            codeDemo: """
            enum CustomError: Error { case invalid }
            let publisher = [1, 2, 3].publisher
            publisher
                .tryMin { a, b in
                    if a > 2 { throw CustomError.invalid }
                    return a < b
                }
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output: Completion: failure(__lldb_expr_3.CustomError.invalid)
            """
        ),
        CombineItem(
            name: "count",
            type: .combineOperator,
            description: "Emits the number of values emitted by a publisher.",
            codeDemo: """
            let publisher = [1, 2, 3].publisher
            publisher
                .count()
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 3
            """
        ),
        CombineItem(
            name: "first",
            type: .combineOperator,
            description: "Emits the first value emitted by a publisher.",
            codeDemo: """
            let publisher = [1, 2, 3].publisher
            publisher
                .first()
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 1
            """
        ),
        CombineItem(
            name: "tryFirst",
            type: .combineOperator,
            description: "Emits the first value satisfying a predicate, allowing errors.",
            codeDemo: """
            enum CustomError: Error { case invalid }
            let publisher = [1, 2, 3].publisher
            publisher
                .tryFirst { $0 < 3 ? true : throw CustomError.invalid }
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output: Received value: 1
            //         Completion: finished
            """
        ),
        CombineItem(
            name: "last",
            type: .combineOperator,
            description: "Emits the last value emitted by a publisher.",
            codeDemo: """
            let publisher = [1, 2, 3].publisher
            publisher
                .last()
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 3
            """
        ),
        CombineItem(
            name: "tryLast",
            type: .combineOperator,
            description: "Emits the last value satisfying a predicate, allowing errors.",
            codeDemo: """
            enum CustomError: Error { case invalid }
            let publisher = [1, 2, 3].publisher
            publisher
                .tryLast { $0 < 3 ? true : throw CustomError.invalid }
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output: Received value: 2
            //         Completion: finished
            """
        ),
        CombineItem(
            name: "output(at:)",
            type: .combineOperator,
            description: "Emits the value at a specified index.",
            codeDemo: """
            let publisher = [1, 2, 3].publisher
            publisher
                .output(at: 1)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 2
            """
        ),
        CombineItem(
            name: "output(in:)",
            type: .combineOperator,
            description: "Emits values within a specified range of indices.",
            codeDemo: """
            let publisher = [1, 2, 3, 4].publisher
            publisher
                .output(in: 1...2)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: 2
            //         Received value: 3
            """
        ),
        CombineItem(
            name: "catch",
            type: .combineOperator,
            description: "Handles errors by replacing the failed publisher with a new one.",
            codeDemo: """
            enum CustomError: Error { case failure }
            let publisher = Fail<String, CustomError>(error: .failure)
            publisher
                .catch { _ in Just("Recovered") }
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: Recovered
            """
        ),
        CombineItem(
            name: "tryCatch",
            type: .combineOperator,
            description: "Handles errors with a closure that can throw errors.",
            codeDemo: """
            enum CustomError: Error { case failure }
            let publisher = Fail<String, CustomError>(error: .failure)
            publisher
                .tryCatch { _ in Just("Recovered") }
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output: Received value: Recovered
            //         Completion: finished
            """
        ),
        CombineItem(
            name: "retry",
            type: .combineOperator,
            description: "Retries the publisher a specified number of times if it fails.",
            codeDemo: """
            enum CustomError: Error { case failure }
            var attempt = 0
            let publisher = Future<String, CustomError> { promise in
                attempt += 1
                if attempt < 3 {
                    promise(.failure(.failure))
                } else {
                    promise(.success("Success"))
                }
            }
            publisher
                .retry(2)
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output: Received value: Success
            //         Completion: finished
            """
        ),
        CombineItem(
            name: "assertNoFailure",
            type: .combineOperator,
            description: "Converts a publisher to one that never fails, crashing on error.",
            codeDemo: """
            let publisher = Just("Safe")
                .setFailureType(to: Error.self)
            publisher
                .assertNoFailure()
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Received value: Safe
            """
        ),
        CombineItem(
            name: "receive(on:)",
            type: .combineOperator,
            description: "Specifies the scheduler for receiving values and completion.",
            codeDemo: """
            let publisher = Just("Hello")
            publisher
                .receive(on: DispatchQueue.main)
                .sink { value in
                    print("Received value: \\(value) on thread: \\(Thread.current)")
                }
                .store(in: &cancellables)
            // Output: Received value: Hello on thread: <NSThread: 0x...>{number = 1, name = main}
            """
        ),
        CombineItem(
            name: "subscribe(on:)",
            type: .combineOperator,
            description: "Specifies the scheduler for the publisher’s execution.",
            codeDemo: """
            let publisher = Future<String, Never> { promise in
                print("Future running on thread: \\(Thread.current)")
                promise(.success("Hello"))
            }
            publisher
                .subscribe(on: DispatchQueue.global())
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Future running on thread: <NSThread: 0x...>{number = 2, name = (null)}
            //         Received value: Hello
            """
        ),
        CombineItem(
            name: "debounce",
            type: .combineOperator,
            description: "Delays emitting values until a specified time has passed without new values.",
            codeDemo: """
            let subject = PassthroughSubject<String, Never>()
            subject
                .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            subject.send("A")
            subject.send("B")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                subject.send("C")
            }
            // Output: Received value: B
            //         Received value: C
            """
        ),
        CombineItem(
            name: "throttle",
            type: .combineOperator,
            description: "Emits the first or latest value in a specified time interval.",
            codeDemo: """
            let subject = PassthroughSubject<String, Never>()
            subject
                .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            subject.send("A")
            subject.send("B")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                subject.send("C")
            }
            // Output: Received value: B
            //         Received value: C
            """
        ),
        CombineItem(
            name: "delay",
            type: .combineOperator,
            description: "Delays emission of values by a specified time.",
            codeDemo: """
            let publisher = Just("Hello")
            publisher
                .delay(for: .seconds(1), scheduler: DispatchQueue.main)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output after 1 second: Received value: Hello
            """
        ),
        CombineItem(
            name: "timeout",
            type: .combineOperator,
            description: "Terminates the publisher if no values are emitted within a specified time.",
            codeDemo: """
            let subject = PassthroughSubject<String, Never>()
            subject
                .timeout(.seconds(1), scheduler: DispatchQueue.main)
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output after 1 second: Completion: finished
            """
        ),
        CombineItem(
            name: "measureInterval",
            type: .combineOperator,
            description: "Measures the time interval between emitted values.",
            codeDemo: """
            let publisher = Timer.publish(every: 1, on: .main, in: .common)
                .autoconnect()
            publisher
                .measureInterval(using: DispatchQueue.main)
                .sink { interval in
                    print("Interval: \\(interval)")
                }
                .store(in: &cancellables)
            // Output: Interval: ~1 second (varies)
            """
        ),
        CombineItem(
            name: "encode",
            type: .combineOperator,
            description: "Encodes values into a data format using a provided encoder.",
            codeDemo: """
            struct User: Codable { let name: String }
            let publisher = Just(User(name: "Alice"))
            publisher
                .encode(encoder: JSONEncoder())
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Output: Received value: <encoded JSON data>
            //         Completion: finished
            """
        ),
        CombineItem(
            name: "decode",
            type: .combineOperator,
            description: "Decodes data into a specified type using a provided decoder.",
            codeDemo: """
            struct User: Codable { let name: String }
            let data = try! JSONEncoder().encode(User(name: "Alice"))
            let publisher = Just(data)
            publisher
                .decode(type: User.self, decoder: JSONDecoder())
                .sink { value in
                    print("Received value: \\(value.name)")
                }
                .store(in: &cancellables)
            // Output: Received value: Alice
            """
        ),
        CombineItem(
            name: "breakpoint",
            type: .combineOperator,
            description: "Triggers a debugger breakpoint for specific events.",
            codeDemo: """
            let publisher = [1, 2, 3].publisher
            publisher
                .breakpoint(receiveOutput: { $0 == 2 })
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Triggers debugger at value 2
            """
        ),
        CombineItem(
            name: "breakpointOnError",
            type: .combineOperator,
            description: "Triggers a debugger breakpoint when an error occurs.",
            codeDemo: """
            enum CustomError: Error { case failure }
            let publisher = Fail<String, CustomError>(error: .failure)
            publisher
                .breakpointOnError()
                .sink(receiveCompletion: { print("Completion: \\($0)") },
                      receiveValue: { print("Received value: \\($0)") })
                .store(in: &cancellables)
            // Triggers debugger on error
            """
        ),
        CombineItem(
            name: "handleEvents",
            type: .combineOperator,
            description: "Performs side effects for specific publisher events.",
            codeDemo: """
            let publisher = [1, 2, 3].publisher
            publisher
                .handleEvents(receiveOutput: { print("Handling output: \\($0)") })
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Handling output: 1
            //         Received value: 1
            //         Handling output: 2
            //         Received value: 2
            //         Handling output: 3
            //         Received value: 3
            """
        ),
        CombineItem(
            name: "print",
            type: .combineOperator,
            description: "Logs all publisher events for debugging.",
            codeDemo: """
            let publisher = [1, 2, 3].publisher
            publisher
                .print("Debug")
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            // Output: Debug: receive value: 1
            //         Received value: 1
            //         Debug: receive value: 2
            //         Received value: 2
            //         Debug: receive value: 3
            //         Received value: 3
            //         Debug: receive completion: finished
            """
        ),
        CombineItem(
            name: "buffer",
            type: .combineOperator,
            description: "Buffers values until the downstream subscriber is ready.",
            codeDemo: """
            let subject = PassthroughSubject<Int, Never>()
            subject
                .buffer(size: 2, prefetch: .byRequest, whenFull: .dropOldest)
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            subject.send(1)
            subject.send(2)
            subject.send(3) // Dropped
            // Output: Received value: 1
            //         Received value: 2
            """
        ),
        CombineItem(
            name: "share",
            type: .combineOperator,
            description: "Shares a single subscription among multiple subscribers.",
            codeDemo: """
            let publisher = URLSession.shared.dataTaskPublisher(for: URL(string: "https://api.example.com")!)
                .map(\\.data)
                .share()
            publisher
                .sink { value in
                    print("Subscriber 1 received: \\(value.count) bytes")
                }
                .store(in: &cancellables)
            publisher
                .sink { value in
                    print("Subscriber 2 received: \\(value.count) bytes")
                }
                .store(in: &cancellables)
            // Output: (single API call, shared data)
            """
        ),
        CombineItem(
            name: "multicast",
            type: .combineOperator,
            description: "Shares a publisher’s output via a subject.",
            codeDemo: """
            let subject = PassthroughSubject<Int, Never>()
            let publisher = [1, 2, 3].publisher
                .multicast(subject: subject)
            publisher
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            publisher.connect()
                .store(in: &cancellables)
            // Output: Received value: 1
            //         Received value: 2
            //         Received value: 3
            """
        ),
        CombineItem(
            name: "publish",
            type: .combineOperator,
            description: "Converts a publisher into a connectable publisher.",
            codeDemo: """
            let publisher = [1, 2, 3].publisher
                .publish()
            publisher
                .sink { value in
                    print("Received value: \\(value)")
                }
                .store(in: &cancellables)
            publisher.connect()
                .store(in: &cancellables)
            // Output: Received value: 1
            //         Received value: 2
            //         Received value: 3
            """
        )
    ]
}
