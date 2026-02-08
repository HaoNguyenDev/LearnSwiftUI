//
//  ViewCompositionAndViewBuilderLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 7/2/26.
//

import SwiftUI

struct ViewCompositionAndViewBuilderLesson {
    static let all = [Lesson(title: "View Composition Principles", code: """
Why do we need View Composition?

✅ GOOD: Composed views
struct GoodDashboard: View {
    @State private var user: User
    @State private var stats: Stats
    @State private var notifications: [Notification]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ProfileHeader(user: user)
                StatsCard(stats: stats)
                NotificationsList(notifications: notifications)
            }
        }
    }
}

// Benefits:
// 1. Clear structure
// 2. Each component testable
// 3. Reusable components
// 4. Better performance (granular updates)
// 5. Easy to maintain
""", result: nil),
                      Lesson(title: "View Extraction Patterns", code: nil, result: nil),
    Lesson(title: "Pattern 1: Extract by Responsibility", code: """
struct UserProfileView: View {
    let user: User
    
    var body: some View {
        VStack {
            // ❌ Don't do this:
            // HStack { Image(...) VStack { Text(...) Text(...) } }
            // Circle().overlay(...)
            // HStack { Button(...) Button(...) }
            
            // ✅ Do this:
            ProfileImageSection(user: user)
            ProfileInfoSection(user: user)
            ProfileActionsSection(user: user)
        }
    }
}

// Each section has single responsibility like (SOLID) S principle
struct ProfileImageSection: View {
    let user: User
    
    var body: some View {
        Circle()
            .fill(Color.blue)
            .frame(width: 100, height: 100)
            .overlay {
                AsyncImage(url: user.avatarURL) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    ProgressView()
                }
            }
            .clipShape(Circle())
    }
}

""", result: nil),
                      Lesson(title: "Pattern 2: Extract Repeated Elements", code: """
// ❌ BAD: Repeated code
struct BadSettings: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "bell")
                Text("Notifications")
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding()
            
            HStack {
                Image(systemName: "lock")
                Text("Privacy")
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding()
            
            HStack {
                Image(systemName: "person")
                Text("Account")
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding()
        }
    }
}

// ✅ GOOD: Extract component
struct GoodSettings: View {
    var body: some View {
        VStack {
            SettingsRow(icon: "bell", title: "Notifications")
            SettingsRow(icon: "lock", title: "Privacy")
            SettingsRow(icon: "person", title: "Account")
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30)
            Text(title)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
    }
}

""", result: nil),
                      Lesson(title: "Pattern 3: Extract Complex Logic", code: """
// ❌ BAD: Complex logic in body
struct BadProductCard: View {
    let product: Product
    
    var body: some View {
        VStack {
            Text(product.name)
            
            // Complex discount calculation
            if product.discount > 0 {
                HStack {
                    Text("$(product.price)")
                        .strikethrough()
                    Text("$(product.price * (1 - product.discount))")
                        .foregroundColor(.red)
                }
            } else {
                Text("$(product.price)")
            }
            
            // Complex availability logic
            if product.stock > 0 {
                if product.stock < 5 {
                    Text("Only (product.stock) left!")
                        .foregroundColor(.orange)
                } else {
                    Text("In stock")
                        .foregroundColor(.green)
                }
            } else {
                Text("Out of stock")
                    .foregroundColor(.red)
            }
        }
    }
}

// ✅ GOOD: Extract subviews
struct GoodProductCard: View {
    let product: Product
    
    var body: some View {
        VStack(spacing: 12) {
            Text(product.name)
                .font(.headline)
            
            PriceView(product: product)
            AvailabilityView(product: product)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

struct PriceView: View {
    let product: Product
    
    private var finalPrice: Double {
        product.price * (1 - product.discount)
    }
    
    var body: some View {
        if product.discount > 0 {
            HStack {
                Text("$(product.price, specifier: "%.2f")")
                    .strikethrough()
                    .foregroundColor(.secondary)
                Text("$(finalPrice, specifier: "%.2f")")
                    .foregroundColor(.red)
                    .bold()
            }
        } else {
            Text("$(product.price, specifier: "%.2f")")
                .bold()
        }
    }
}

struct AvailabilityView: View {
    let product: Product
    
    var body: some View {
        Group {
            if product.stock == 0 {
                Label("Out of stock", systemImage: "xmark.circle")
                    .foregroundColor(.red)
            } else if product.stock < 5 {
                Label("Only (product.stock) left!", systemImage: "exclamationmark.triangle")
                    .foregroundColor(.orange)
            } else {
                Label("In stock", systemImage: "checkmark.circle")
                    .foregroundColor(.green)
            }
        }
        .font(.caption)
    }
}
""", result: nil),
    Lesson(title: "ViewBuilder Deep Dive", code: """
What is ViewBuilder?
// @ViewBuilder is the result builder for SwiftUI
// Allows writing declarative syntax

// Without @ViewBuilder:
func makeViews() -> some View { 
    return VStack { 
        TupleView(( 
            Text("Line 1"), 
            Text("Line 2"), 
            Text("Line 3") 
        )) 
    }
}

// With @ViewBuilder:
@ViewBuilder
func makeViews() -> some View { 
    Text("Line 1") 
    Text("Line 2") 
    Text("Line 3")
}
// Compiler automatically wraps in TupleView

ViewBuilder Transformations
// Input code:
@ViewBuilder
var content: some View {
    Text("A")
    Text("B")
    if condition {
        Text("C")
    }
}

// Compiler transforms to:
var content: some View {
    buildBlock(
        Text("A"),
        Text("B"),
        buildIf(condition ? Text("C") : nil)
    )
}

// Result type:
// TupleView<(Text, Text, Text?)>
""", result: nil),
                      Lesson(title: "ViewBuilder Control Flow", code: """
@ViewBuilder
func conditionalView(show: Bool) -> some View {
    // ✅ if
    if show {
        Text("Visible")
    }
    
    // ✅ if-else
    if show {
        Text("True")
    } else {
        Text("False")
    }
    
    // ✅ switch
    switch status {
    case .loading:
        ProgressView()
    case .success:
        Text("Success")
    case .error:
        Text("Error")
    }
    
    // ❌ NO: for loops
    // for i in 0..<5 {
    //     Text("(i)")  // Compile error!
    // }
    
    // ✅ YES: ForEach
    ForEach(0..<5) { i in
        Text("(i)")
    }
    
    // ❌ NO: guard
    // guard condition else { return }  // Can't return from ViewBuilder
    
    // ❌ NO: while
    // while condition { }  // Not supported
}
""", result: nil),
                      Lesson(title: "ViewBuilder Limitations", code: """
// ViewBuilder maximum 10 children
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
    Text("11")  // ❌ Compile error: > 10 views!
}

// ✅ Solution 1: Group
@ViewBuilder
var fixedViews: some View {
    Group {
        Text("1")
        Text("2")
        // ... up to 10
    }
    Group {
        Text("11")
        Text("12")
        // ... more
    }
}

// ✅ Solution 2: Extract subviews
@ViewBuilder
var fixedViews: some View {
    FirstGroup()
    SecondGroup()
}

struct FirstGroup: View {
    var body: some View {
        Group {
            Text("1")
            // ...
        }
    }
}
""", result: nil),
                      Lesson(title: "Custom ViewBuilder Functions", code: """
// Pattern: Custom container views

struct Card<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 4)
    }
}

// Usage:
Card {
    Text("Title")
    Text("Subtitle")
    Button("Action") { }
}
""", result: nil),
                      Lesson(title: "Advanced: Multiple ViewBuilder Parameters", code: """
struct SplitView<Leading: View, Trailing: View>: View {
    let leading: Leading
    let trailing: Trailing
    
    init(
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.leading = leading()
        self.trailing = trailing()
    }
    
    var body: some View {
        HStack {
            leading
                .frame(maxWidth: .infinity)
            Divider()
            trailing
                .frame(maxWidth: .infinity)
        }
    }
}

// Usage:
SplitView {
    Text("Left")
    Text("Side")
} trailing: {
    Text("Right")
    Text("Side")
}
""", result: nil),
                      Lesson(title: "Generic Container Pattern", code: """
// Reusable container with custom styling
struct StyledContainer<Content: View>: View {
    enum Style {
        case primary, secondary, danger
        
        var color: Color {
            switch self {
            case .primary: return .blue
            case .secondary: return .gray
            case .danger: return .red
            }
        }
    }
    
    let style: Style
    let content: Content
    
    init(style: Style = .primary, @ViewBuilder content: () -> Content) {
        self.style = style
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(style.color.opacity(0.1))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style.color, lineWidth: 2)
            }
    }
}

// Usage:
StyledContainer(style: .danger) {
    Text("Error!")
    Text("Something went wrong")
}
""", result: {
        AnyView(ResultBlockView(content: {
            VStack {
                StyledContainerExample(style: .danger) {
                    Text("Error!")
                    Text("Something went wrong!")
                }
                
                StyledContainerExample(style: .primary) {
                    Text("Welcome!")
                    Text("Let's style with me!")
                }
            }
        }))
    }),
                      Lesson(title: "COMPOSITION PATTERNS", code: nil, result: nil),
                      Lesson(title: " Container-Presentational Pattern", code: """
// Container: Logic + State
struct TodoListContainer: View {
    @State private var todos: [Todo] = []
    @State private var isLoading = false
    @State private var error: Error?
    
    var body: some View {
        TodoListPresentation(
            todos: todos,
            isLoading: isLoading,
            error: error,
            onAdd: addTodo,
            onDelete: deleteTodo,
            onToggle: toggleTodo
        )
        .task {
            await loadTodos()
        }
    }
    
    // Logic methods
    private func addTodo(_ todo: Todo) {
        todos.append(todo)
    }
    
    private func deleteTodo(at indices: IndexSet) {
        todos.remove(atOffsets: indices)
    }
    
    private func toggleTodo(_ todo: Todo) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isCompleted.toggle()
        }
    }
    
    private func loadTodos() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            todos = try await TodoAPI.fetchTodos()
        } catch {
            self.error = error
        }
    }
}

// Presentational: Pure UI, no logic
struct TodoListPresentation: View {
    let todos: [Todo]
    let isLoading: Bool
    let error: Error?
    let onAdd: (Todo) -> Void
    let onDelete: (IndexSet) -> Void
    let onToggle: (Todo) -> Void
    
    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    ProgressView()
                } else if let error {
                    ErrorView(error: error)
                } else if todos.isEmpty {
                    EmptyStateView()
                } else {
                    TodoList(
                        todos: todos,
                        onDelete: onDelete,
                        onToggle: onToggle
                    )
                }
            }
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add", systemImage: "plus") {
                        onAdd(Todo(title: "New"))
                    }
                }
            }
        }
    }
}

Benefits:
Container = testable logic
Presentation = testable UI
Clear separation of concerns
Easy to preview
""", result: nil),
                      Lesson(title: "Modifier Pattern", code: """
// Extract common modifiers into extensions

// ❌ BAD: Repeated modifiers
struct BadView: View {
    var body: some View {
        VStack {
            Text("Title")
                .font(.headline)
                .foregroundColor(.primary)
                .padding()
            
            Text("Subtitle")
                .font(.headline)
                .foregroundColor(.primary)
                .padding()
            
            Text("Body")
                .font(.headline)
                .foregroundColor(.primary)
                .padding()
        }
    }
}

// ✅ GOOD: Custom modifier
struct CardTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.primary)
            .padding()
    }
}

extension View {
    func cardTextStyle() -> some View {
        modifier(CardTextStyle())
    }
}

struct GoodView: View {
    var body: some View {
        VStack {
            Text("Title").cardTextStyle()
            Text("Subtitle").cardTextStyle()
            Text("Body").cardTextStyle()
        }
    }
}
""", result: nil),
                      Lesson(title: "Advanced Modifiers", code: """
// Configurable modifier
struct BorderedStyle: ViewModifier {
    let color: Color
    let width: CGFloat
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(color, lineWidth: width)
            }
    }
}

extension View {
    func bordered(
        color: Color = .blue,
        width: CGFloat = 2,
        cornerRadius: CGFloat = 8
    ) -> some View {
        modifier(BorderedStyle(
            color: color,
            width: width,
            cornerRadius: cornerRadius
        ))
    }
}

// Usage:
Text("Hello")
    .bordered()  // Default styling

Text("Custom")
    .bordered(color: .red, width: 3, cornerRadius: 12)
""", result: nil),
                       Lesson(title: "Builder Pattern", code: """
// Fluent API for complex views
struct AlertConfiguration {
    var title: String = ""
    var message: String = ""
    var primaryButton: String = "OK"
    var secondaryButton: String?
    var onPrimary: () -> Void = {}
    var onSecondary: () -> Void = {}
}

struct AlertBuilder {
    private var config = AlertConfiguration()
    
    func title(_ title: String) -> Self {
        var copy = self
        copy.config.title = title
        return copy
    }
    
    func message(_ message: String) -> Self {
        var copy = self
        copy.config.message = message
        return copy
    }
    
    func primaryButton(_ text: String, action: @escaping () -> Void) -> Self {
        var copy = self
        copy.config.primaryButton = text
        copy.config.onPrimary = action
        return copy
    }
    
    func secondaryButton(_ text: String, action: @escaping () -> Void) -> Self {
        var copy = self
        copy.config.secondaryButton = text
        copy.config.onSecondary = action
        return copy
    }
    
    func build() -> Alert {
        if let secondary = config.secondaryButton {
            return Alert(
                title: Text(config.title),
                message: Text(config.message),
                primaryButton: .default(Text(config.primaryButton), action: config.onPrimary),
                secondaryButton: .cancel(Text(secondary), action: config.onSecondary)
            )
        } else {
            return Alert(
                title: Text(config.title),
                message: Text(config.message),
                dismissButton: .default(Text(config.primaryButton), action: config.onPrimary)
            )
        }
    }
}

// Usage:
AlertBuilder()
    .title("Delete Item")
    .message("Are you sure?")
    .primaryButton("Delete") {
        deleteItem()
    }
    .secondaryButton("Cancel") {
        // Cancel
    }
    .build()
""", result: nil),
                      Lesson(title: "PERFORMANCE OPTIMIZATION", code: nil, result: nil),
                      Lesson(title: "View Identity & Composition", code: """
// ❌ BAD: Anonymous views lose identity
struct BadList: View {
    @State private var items: [Item]
    
    var body: some View {
        List(items) { item in
            // Anonymous view
            HStack {
                Text(item.name)
                Spacer()
                Text("(item.count)")
            }
        }
    }
}
// Problem: Every item recreate when every items changes

// ✅ GOOD: Named views preserve identity
struct GoodList: View {
    @State private var items: [Item]
    
    var body: some View {
        List(items) { item in
            ItemRow(item: item)  // Explicit type
        }
    }
}

struct ItemRow: View {
    let item: Item
    
    var body: some View {
        HStack {
            Text(item.name)
            Spacer()
            Text("(item.count)")
        }
    }
}
// SwiftUI can track ItemRow identity → better performance
""", result: nil),
                      Lesson(title: "Equatable Views", code: """
// Heavy view that should minimize updates
struct ExpensiveItemView: View, Equatable {
    let item: Item
    
    // Define equality
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.item.id == rhs.item.id &&
        lhs.item.name == rhs.item.name
    }
    
    var body: some View {
        // Expensive rendering...
        ComplexChart(data: item.data)
            .overlay {
                Text(item.name)
            }
    }
}

// Usage:
List(items) { item in
    ExpensiveItemView(item: item)
        .equatable()  // SwiftUI checks equality before re-rendering
}

// Performance:
// Without .equatable(): Re-renders every time parent updates
// With .equatable(): Only re-renders when item actually changes
""", result: nil),
                      Lesson(title: "Lazy View Loading", code: """
// ❌ BAD: All views created upfront
struct BadTabView: View {
    var body: some View {
        TabView {
            ExpensiveView1()  // Created immediately
                .tabItem { Label("Tab 1", systemImage: "1.circle") }
            
            ExpensiveView2()  // Created immediately
                .tabItem { Label("Tab 2", systemImage: "2.circle") }
            
            ExpensiveView3()  // Created immediately
                .tabItem { Label("Tab 3", systemImage: "3.circle") }
        }
    }
}

// ✅ GOOD: Lazy loading
struct GoodTabView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Group {
                switch selection {
                case 0: ExpensiveView1()
                case 1: ExpensiveView2()
                case 2: ExpensiveView3()
                default: EmptyView()
                }
            }
            .tabItem { Label("Tab (selection + 1)", systemImage: "(selection + 1).circle") }
        }
    }
}

// Alternative: LazyView wrapper
struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: some View {
        build()
    }
}

// Usage:
TabView {
    LazyView(ExpensiveView1())  // Only created when tab shown
        .tabItem { Label("Tab 1", systemImage: "1.circle") }
}

Demo: 

VStack {
    TabViewWithLazyView()
        .frame(maxWidth: .infinity, minHeight: 400)
        .padding()
}
""", result: {
        AnyView(ResultBlockView(content: {
            VStack {
                TabViewWithLazyView()
                    .frame(maxWidth: .infinity, minHeight: 400)
                    .padding()
            }
            
        }))
    }),
                      Lesson(title: "INTERVIEW QUESTIONS", code: """
Q1: When should you extract a view into a separate component?

A:
Views larger than 50-100 lines
Complex logic (> 3 conditions)
Repeated UI patterns
Need to reuse
Improve readability

Q2: What is a ViewBuilder?
A:
Result builder for SwiftUI
Enables declarative syntax
Automatically wrap multiple views in TupleView
Supports control flow (if/switch)
Maximum 10 children

Q3: Explain the Container-Presentational pattern
A:
// Container: Logic + State
- Manages @State
- Business logic
- API calls
- Not concerned with UI details

// Presentational: Pure UI
- No @State (only lets/bindings)
- Display data
- Call callbacks
- Easy to preview

// Benefits:
- Separation of concerns
- Testability
- Reusability

Q4: Custom ViewModifier vs extension View?
A:
// ViewModifier: Complex, reusable styling
struct CardStyle: ViewModifier { 
    func body(content: Content) -> some View { 
        content. content 
        .padding() 
        .background(.white) 
        .cornerRadius(12) 
        .shadow(radius: 4) 
    }
}

// Extension: Simple, one-off helpers
extension View { 
    func cardStyle() -> some View { 
        modifier(CardStyle()) 
    }
}

// Use ViewModifier when:
// - Complex logic
// - Needs configuration
// - Reused across project

// Use extension when:
// - Simple wrapper
// - Convenience method

Q5: ViewBuilder maximum 10 children - why and how to workaround?
A:
// Why: Swift function builder limitation
// Compiler generates buildBlock overloads for 1-10 parameters

// Workarounds:
// 1. Group
Group { 
    View1(); View2(); ... View10()
}
Group { 
    View11(); View12()
}

// 2. Extract subviews
FirstGroup() // Contains 10 views
SecondGroup() // Contains more

// 3. Arrays + ForEach
ForEach(0..<20) { i in 
    Text("(i)")
}

// 4. TupleView (advanced)
Q6: Equatable views performance impact?
A:
// Without .equatable():
// - View re-renders when parent updates
// - Even if props unchanged
// - Waste CPU cycles

// With .equatable():
// - SwiftUI checks == before render
// - Skip render if props same
// - Trade: Equality check cost

// Benchmark:
struct Heavy: View, Equatable { 
    let data: [Int] 

    var body: some View { 
        // Expensive Chart rendering 
        Chart(data) 
    }
}

// Without .equatable():
// Parent update → 16ms render time × 100 items = 1600ms

// With .equatable():
// Parent update → 0.1ms equality check × 100 = 10ms
// Only changed items render

// 160x faster! 🚀
Q7: Implement custom container with multiple ViewBuilder slots?
A:
swiftstruct Modal<Header: View, Content: View, Footer: View>: View { 
    let header: Header 
    let content: Content 
    let footer: Footer 

init( 
        @ViewBuilder header: () -> Header, 
        @ViewBuilder content: () -> Content, 
        @ViewBuilder footer: () -> Footer 
    ) { 
    self.header = header() 
    self.content = content() 
    self.footer = footer() 
} 

var body: some View { 
    VStack(spacing: 0) { 
        header. header 
            .frame(height: 60) 
            .background(Color.gray.opacity(0.1)) 

        ScrollView { 
            content. content 
                .padding() 
        } 

        footer 
            .frame(height: 60) 
            .background(Color.white) 
            .shadow(radius: 4) 
        } 
    }
}

// Usage:
Modal { 
    Text("Title")
} content: { 
    Text("Body") 
    Text("Content")
} footer: { 
    Button("Save") { }
}
""", result: nil)
    ]
}

