//
//  SomeViewAnyViewViewBuilderLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/2/26.
//

import SwiftUI

struct SomeViewAnyViewAndViewBuilderLesson {
    static let all = [Lesson(title: "some View - Opaque Return Type", code: """
What's some View?

Some View is an opaque type.
It allows you to hide the specific type of the View while still ensuring the compiler knows exactly what that type is.

Characteristics of Some View:

Compile-time fixed type: 
The compiler knows the exact return type,
but you don't need to explicitly declare it.

For example, if you return a Text, the compiler will know it's Text,
but the function signature only needs to be Some View.

Better performance:
Because the compiler knows the exact type at compile-time,
it can optimize the code better.
There is no memory or performance overhead like type erasure.

Type identity is preserved: 
Each instance of the view retains its type identity, helping SwiftUI optimize rendering and diffing.

Limitations in flexibility: 
You must return the same specific type in all cases.
You cannot return Text in one case and Image in another.

Example of some View:

var body: some View {
    Text("Hello SwiftUI")
}

func body() -> some View {
    VStack {
        Text("Username")
        if showDetails {
            Text("Further details")
        }
    }
}
// Compiler knows this is always VStack<TupleView<...>>
Note: In the example above, even with the if condition, the return type is still a fixed type (VStack contains a TupleView which may or may not have a second Text), not two different types.
""", result: nil),
    Lesson(title: "AnyView - Type Erasure", code: """
What is AnyView?

AnyView is a type-erased wrapper around any View. 
It "erases" specific type information and allows you to work with different Views flexibly.

Characteristics of AnyView:
Type flexibility: 
You can return completely different View types from the same function/property.

Performance overhead: 
Type erasure has a cost in memory and performance. 
SwiftUI cannot optimize any View as well as with some Views.

Loss of type identity: 
SwiftUI may have more difficulty tracking and optimizing view hierarchy.

Runtime type checking: 
Types are determined at runtime, not compile-time.

Example of AnyView:

struct DynamicView: View {
    let type: String

    var body: some View {
        getView()
    }

    // Returns completely different View types
    func getView() -> AnyView {
        switch type {
            case "text":
                return AnyView(Text("This is Text"))
            case "image":
                return AnyView(Image(systemName: "star"))
            case "button":
                return AnyView(Button("Press here") { })
            default:
                return AnyView(EmptyView())
            }
    }
}
""", result: nil),
    Lesson(title: "Detailed Comparison between some View vs AnyView", code: """
Comparison Table:
Criteria                Some View                     Any View
Type checking           Compile-time                  Runtime
Performance             High (good optimization)      Lower (has overhead) 
Memory                  Efficiency                    Overhead added     
Flexibility             Low (one fixed style)         High (many different styles) 
SwiftUI optimization    Good                          Poor 
When to use             Most cases                    When really necessary

In conclusion, `someView` is the default choice and should be preferred in most cases due to its better performance and better optimization by SwiftUI. Only use `AnyView` when you truly need the flexibility to return completely different View types that cannot be solved with `@ViewBuilder` or other techniques.
""", result: nil),
                      Lesson(title: "@ViewBuilder", code: """
What is @ViewBuilder?

@ViewBuilder is a result builder (function builder) in SwiftUI
 that allows you to build multiple views within a closure without having to wrap them in a container like Group or TupleView.

Simply put: it allows you to write multiple views consecutively in a block of code,
 and SwiftUI will automatically combine them into a single view.

How it works
// NO @ViewBuilder - Error!
func makeViews() -> some View {
    Text("Hello")
    Text("World") // ❌ Compiler error
}

// WITH @ViewBuilder - OK!
@ViewBuilder
func makeViews() -> some View {
    Text("Hello")
    Text("World") // ✅ Works correctly
}

// @ViewBuilder allows multiple views:
struct MultipleViews: View { 
    var body: some View { 
    // No need for returns or containers! 
        Text("First") 
        Text("Second") 
        Text("Third") 
    }
}
            ↓        
// ViewBuilder transform code into:
struct MultipleViews: View { 
    var body: some View { 
        TupleView(( 
            Text("First"), 
            Text("Second"), 
            Text("Third") 
        )) 
    }
}

// Custom ViewBuilder:
@ViewBuilder
func makeConditionalView(show: Bool) -> some View { 
    if show { 
        Text("Visible") 
    } else { 
        EmptyView() 
    }
}

""", result: nil),
                      Lesson(title: "When to use @ViewBuilder?", code: """
1. Create custom container views

struct CustomCardWithViewBuilder<Content: View>: View {
    let content: Content 

    // Use @ViewBuilder for initializer 
    init(@ViewBuilder content: () -> Content) { 
        self.content = content() 
    } 

    var body: some View { 
        VStack { 
            content
        } 
        .padding() 
        .background(Color.gray.opacity(0.2)) 
        .cornerRadius(10) 
    }
}


// Use:
CustomCardWithViewBuilder { 
    Text("Title") 
    Text("Subtitle") 
    Image(systemName: "star")
}
""", result: {
        AnyView(ResultBlockView(content: {
            CustomCardWithViewBuilder {
                Text("Title")
                Text("Subtitle")
                Image(systemName: "star")
            }
        }))
    }),
                      Lesson(title: "", code: """
2. Create computed properties that returns multiple views.

struct ProfileViewViewBuilderExample: View {
    let isLoggedIn: Bool
    
    var body: some View {
        VStack {
            header
            content
        }
    }
    
    @ViewBuilder
    var header: some View {
        if isLoggedIn {
            Text("Welcome back!")
            Image(systemName: "person.circle.fill")
        } else {
            Text("Please login")
        }
    }
    
    @ViewBuilder
    var content: some View {
        Text("Content here")
        Divider()
        Text("More content")
    }
}
""", result: {
        AnyView(
            ResultBlockView(content: {
                VStack(spacing: 20.0) {
                    ProfileViewViewBuilderExample(isLoggedIn: false)
                    ProfileViewViewBuilderExample(isLoggedIn: true)
                }
            })
        )
    }),
                      Lesson(title: "", code: """
3. Create helper functions to reuse UI

struct DashboardViewViewBuilderExample: View { 
    var body: some View { 
        VStack { 
            makeHeader() 
            makeStats() 
            makeFooter() 
        } 
    } 

    @ViewBuilder 
    func makeHeader() -> some View { 
        Text("Dashboard") 
            .font(.largeTitle) 
        Text("Last updated: Now") 
            .font(.caption) 
    } 

    @ViewBuilder 
    func makeStats() -> some View { 
        HStack { 
            StatCard(title: "Users", value: "1.2K") 
            StatCard(title: "Revenue", value: "$45K") 
        } 
    } 

    @ViewBuilder 
    func makeFooter() -> some View { 
        Divider() 
        Text("© 2024") 
    }
}
""", result: {
        AnyView(ResultBlockView(content: {
            DashboardViewViewBuilderExample()
        }))
    }),
                      Lesson(title: "", code: """
4. Handle complex conditional rendering

struct ContentView: View { 
    let userRole: UserRole 

    var body: some View { 
        VStack { 
            menuItems 
        } 
    } 

    @ViewBuilder 
    var menuItems: some View { 
        Text("Home") 
        Text("Profile") 

        if userRole == .admin { 
            Text("Admin Panel") 
            Text("User Management") 
        } else if userRole == .moderator { 
            Text("Moderation Tools") 
        } 

        Text("Settings") 
    }
}
""", result: nil),
    Lesson(title: "Important Notes", code: """
1. Limit of 10 views
SwiftUI only supports a maximum of 10 child views directly within a @ViewBuilder block:

@ViewBuilder
var tooManyViews: some View {
    Text("1")
    Text("2")
    Text("3")
    Text("4")
    Text("5")
    Text("6")
    Text("7")
    Text("8")
    Text("9")
    Text("10")
    Text("11") // ❌ Error: "Extra argument in call"
}

// Solution: Group views
    @ViewBuilder
    var fixedViews: some View {
        Group {
            Text("1")
            Text("2")
            // ... 8 views
        }
        Text("11") // ✅ OK
    }

""", result: nil),
                      Lesson(title: "", code: """
2. Cannot return directly

    @ViewBuilder
    func makeView() -> some View {
        return Text("Hello") // ❌ Error: Cannot use 'return' with @ViewBuilder
    }

// Correct way:

    @ViewBuilder
    func makeView() -> some View {
        Text("Hello") // ✅ No 'return' needed
    }
""", result: nil),
                      Lesson(title: "", code: """
3. Only supports certain statements

    @ViewBuilder
    func conditionalView(show: Bool) -> some View {
        if show {
            Text("Visible")
        } else {
            Text("Hidden")
        }

// ✅ if-else OK

// ❌ NOT supported:
// - for-in loops
// - while loops
// - do-catch
// - guard
}

// Solution for loops: Use ForEach
    @ViewBuilder
    func listView(items: [String]) -> some View {
        ForEach(items, id: .self) { item in
            Text(item)
        }
    }

""", result: nil),
                      Lesson(title: "", code: """
4. Switch statements. statements

    enum ViewType { 
        case home, profile, settings
    }

    @ViewBuilder
    func makeView(for type: ViewType) -> some View { 
        switch type { 
            case .home: 
                Text("Home") 
                Image(systemName: "house") 
            case .profile: 
                Text("Profile") 
                Image(systemName: "person") 
            case .settings: 
                Text("Settings") 
                Image(systemName: "gear") 
        }
    }
""", result: nil),
                      Lesson(title: "", code: """
5. Optional views

    struct OptionalView: View { 
        let title: String? 

        var body: some View { 
            VStack { 
                // Method 1: Use if-let 
                if let title = title { 
                    Text(title) 
                } 
                // Method 2: Inline (no need for separate @ViewBuilder) 
                title.map { Text($0) } 
            } 
        }
    }

""", result: {
        AnyView(ResultBlockView(content: {
            OptionalViewExample(title: "Hello Swift")
        }))
    }),
    Lesson(title: "Alternatives to AnyView", code: """
In many cases, you can avoid using AnyView:

Use @ViewBuilder:

struct BetterApproach: View {
    let condition: Bool

    var body: some View {
        content
    }

    @ViewBuilder
    var content: some View {
        if condition {
            Text("Case A")
                .foregroundColor(.blue)
        } else {
            Image(systemName: "star")
                .foregroundColor(.yellow)
            }
}

Use Group or conditional modifiers:

struct ConditionalStyling: View {
    let isHighlighted: Bool
    
    var body: some View {
        Text("Content")
            .foregroundColor(isHighlighted ? .red : .black)
            .font(isHighlighted ? .title : .body)
    }
}

""", result: nil)]
}
