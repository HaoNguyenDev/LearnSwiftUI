//
//  TextBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/5/25.
//


import SwiftUI

struct TextBootcamp: View {
    @Environment(\.theme) var theme
    
    var body: some View {
        Spacer()
        ScrollView {
            //MARK: - AttributedString
            CodePreviewContainer(title: "AttributedString",
                                 code:
"""
var attributedHighlight: AttributedString {
    var attributedString = AttributedString("SwiftUI makdevelopmsimple")
    attributedString.font = .system(.subheadline, weight: .regular)
    attributedString.foregroundColor = .black
             
    if let range1 = attributedString.range(of: "SwiftUI") {
        attributedString[range1].font = .largeTitle
        attributedString[range1].foregroundColor = .green
    }
             
    if let range2 = attributedString.range(of: "simple") {
        attributedString[range2].font = .system(size: 20, weight: .bold)
        attributedString[range2].foregroundColor = .blue
        attributedString[range2].underlineStyle = .single
    }
    return attributedString
}
             
Text(attributedHighlight)
""", resultView: AnyView(
    ResultBlockView(content: {
        var attributedHighlight: AttributedString {
            var attributedString = AttributedString("SwiftUI makes UI development simple")
            attributedString.font = .system(.subheadline, weight: .regular)
            attributedString.foregroundColor = .black
            
            if let range1 = attributedString.range(of: "SwiftUI") {
                attributedString[range1].font = .largeTitle
                attributedString[range1].foregroundColor = .green
            }
            
            if let range2 = attributedString.range(of: "simple") {
                attributedString[range2].font = .system(size: 20, weight: .bold)
                attributedString[range2].foregroundColor = .blue
                attributedString[range2].underlineStyle = .single
            }
            return attributedString
        }
        Text(attributedHighlight)
    })))
            
            
            //MARK: - Title
            CodePreviewContainer(title: "Title",
                                 code:
"""
Text("Title")
    .font(.title)
""", resultView: AnyView( ResultBlockView(content: {
                Text("Title")
                    .font(.title)
            })))
            
            //MARK: - Custom font
            CodePreviewContainer(title: "Custom font", code:
"""
Text("Custom")
    .font(.system(size: 18, weight: .bold, design: .rounded))
    /*
    .largeTitle
    .title, .title2, .title3
    .headline
    .body
    .callout
    .caption, .caption2
    */

    Text("Bold")
        .fontWeight(.bold)
                
    Text("Italic")
        .italic()


""", resultView: AnyView(ResultBlockView(content: {
                Text("Custom font")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                
                Text("Bold")
                    .fontWeight(.bold)
                
                Text("Italic")
                    .italic()
            })))
            
            //MARK: - foregroundColor
            CodePreviewContainer(title: "foregroundColor", code:
"""
Text("Blue")
    .foregroundColor(.blue)
""", resultView: AnyView(ResultBlockView(content: {
                Text("Blue")
                    .foregroundColor(.blue)
            })))
            
            
            //MARK: - Add multi text
            CodePreviewContainer(title: "Add multi text",
                                 code:
"""
Text("Hello ")
    .foregroundColor(.blue)
+ Text("SwiftUI")
    .fontWeight(.bold)
""", resultView: AnyView(ResultBlockView(content: {
                Text("Hello ")
                    .foregroundColor(.blue)
                + Text("SwiftUI")
                    .fontWeight(.bold)
            })))
            
            //MARK: - Gradient text
            CodePreviewContainer(title: "Gradient text",
                                 code:
"""
Text("Gradient")
    .foregroundStyle(.linearGradient(
        colors: [.red, .orange, .blue],
        startPoint: .leading,
        endPoint: .trailing))
""", resultView: AnyView(ResultBlockView(content: {
                Text("Gradient")
                    .foregroundStyle(.linearGradient(
                        colors: [.red, .orange, .blue],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
            })))
            
            //MARK: - underline text
            CodePreviewContainer(title: "underline text",
                                 code:
"""
Text("Underline")
    .underline(true, pattern: .dashDot, color: .blue)
""", resultView: AnyView(ResultBlockView(content: {
                Text("Underline")
                    .underline(true, pattern: .dashDot, color: .blue)
            })))
            
            //MARK: - strikethrough text
            CodePreviewContainer(title: "strikethrough text",
                                 code:
"""
Text("Strikethrough")
    .strikethrough()
""", resultView: AnyView(ResultBlockView(content: {
                Text("Strikethrough")
                    .strikethrough()
            })))
            
            //MARK: - kerning text
            CodePreviewContainer(title: "kerning text",
                                 code:
"""
Text("Kerning")
    .kerning(8.0)
""", resultView: AnyView(ResultBlockView(content: {
                Text("Kerning")
                    .kerning(8.0)
            })))
            
            //MARK: - lineSpacing text
            CodePreviewContainer(title: "lineSpacing text",
                                 code:
"""
Text("Line 1"\n"Line 2")
    .lineSpacing(8)
""", resultView: AnyView(ResultBlockView(content: {
                Text("Line 1\nLine 2")
                    .lineSpacing(8)
            })))
            
            //MARK: - lineLimit text
            CodePreviewContainer(title: "lineLimit text",
                                 code:
"""
Text("lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit")
        .font(.system(size: 12, weight: .semibold, design: .rounded))
        .lineLimit(2)
        .frame(width: 120, height: 80, alignment: .center)
        .padding()
        .background(Color.green)
""", resultView: AnyView(ResultBlockView(content: {
                Text("lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .lineLimit(2)
                    .frame(width: 120, height: 80, alignment: .center)
                    .padding()
                    .background(Color.green)
            })))
            
            //MARK: - truncationMode text
            CodePreviewContainer(title: "truncationMode text",
                                 code:
"""
Text("truncationMode truncationMode truncationMode truncationMode")
    .lineLimit(1)
    .truncationMode(.middle) // .head / .middle
    .frame(width: 200, height: 40, alignment: .center)
    .background(Color.green)
""", resultView: AnyView(ResultBlockView(content: {
                Text("truncationMode truncationMode truncationMode truncationMode")
                    .lineLimit(1)
                    .truncationMode(.middle) // .head / .middle
                    .frame(width: 200, height: 40, alignment: .center)
                    .background(Color.green)
            })))
            
            //MARK: - contentShape text
            CodePreviewContainer(title: "contentShape text",
                                 code:
"""
Text("Tap with \n.contentShape(Rectangle()) ")
    .contentShape(Rectangle())
    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
    .background(Color.green)
    .onTapGesture {
        debugPrint("Tapped!")
    }
    .padding(.horizontal)
""", resultView: AnyView(ResultBlockView(content: {
                Text("Tap with \n.contentShape(Rectangle()) ")
                    .contentShape(Rectangle())
                    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                    .background(Color.green)
                    .onTapGesture {
                        debugPrint("Tapped!")
                    }
                    .padding(.horizontal)
            })))
            
            // MARK: - The order of modifiers when working with text.
            CodePreviewContainer(title: "The order of modifiers when working with text.", code: """
“Does SwiftUI require a specific modifier order?”

“SwiftUI doesn’t require a specific modifier order,
but for layout accuracy and hit-testing,
We always set the text style modifier first so SwiftUI measures the size,
then the layout, drawing, and finally the gesture.
This helps avoid tap area and layout errors when dynamic typing.”

SwiftUI doesn't enforce this, but it's best practice.

    // 1️⃣ Content
Text("Hello SwiftUI") 
    // 2️⃣ Text style 
    .font(.headline) 
    .foregroundStyle(.blue) 
    .lineLimit(2) 
    .lineSpacing(6) 

    // 3️⃣ Layout 
    .padding() 
    .frame(maxWidth: .infinity, alignment: .leading) 

    // 4️⃣ Drawing 
    .background(Color.yellow) 
    .cornerRadius(8) 

    // 5️⃣ Interaction 
    .contentShape(Rectangle()) 
    .onTapGesture { }

1️⃣ WHY IS MODIFIER ORDER IMPORTANT?
SwiftUI renders using a pipeline:

    Text
    
    → Apply text modifiers
    
    → Calculate intrinsic size
    
    → Apply layout modifiers
    
    → Draw background / overlay
    
    → Apply gestures & hit-testing
    👉 Modifiers applied later use the results applied earlier.

2️⃣ MODIFIER GROUPS & STANDARD ORDER
    🧱 1. CONTENT (always first)
    Text("Hello")
    Data Source
    Localization
    AttributedString
    ❌ Never place modifiers before Text

    🎨 2. TEXT STYLE MODIFIERS (MUST BE PLACED EARLY)
    Affects intrinsic size
    .font(.body)
    .fontWeight(.bold)
    .foregroundStyle(.red)
    .lineLimit(2)
    .lineSpacing(4)
    .multilineTextAlignment(.center)
    .truncationMode(.tail)
    📌 Why place them early?

    Font → affects height
    Line limit → affects wrap
    SwiftUI needs to know the size before layout

    📐 3. LAYOUT MODIFIERS
    .padding()
    .frame(maxWidth: .infinity)
    .fixedSize()
    .layoutPriority(1)
    🧠 Principle
    Layout modifier uses the size calculated from the text style.
    ❌ Incorrect thinking:
    Text("Hello")
    
    .frame(width: 100)
    
    .font(.largeTitle) // ❌

    🖌️ 4. DRAWING MODIFIERS
    .background(Color.green)
    .overlay(RoundedRectangle(cornerRadius: 8).stroke())
    .cornerRadius(8)
    .opacity(0.8)
    .shadow(radius: 4)
    🧠 Drawing modifier:
    Does not affect intrinsic size
    Only affects render
    ⚠️ cornerRadius is always behind background

    🖱️ 5. INTERACTION & HIT-TESTING (ALWAYS LAST)
    .contentShape(Rectangle())
    .onTapGesture { }
    .onLongPressGesture { }
    .allowsHitTesting(true)
    📌 Because of the gesture:
    Based on the final shape
    Need to know the background/frame is finished
""", resultView: AnyView(ResultBlockView(content: {
                Text("Hello SwiftUI")
                // 2️⃣ Text style
                    .font(.headline)
                    .foregroundStyle(.blue)
                    .lineLimit(2)
                    .lineSpacing(6)
                
                // 3️⃣ Layout
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // 4️⃣ Drawing
                    .background(Color.yellow)
                    .cornerRadius(8)
                
                // 5️⃣ Interaction
                    .contentShape(Rectangle())
                    .onTapGesture { }
            })))
            
            VStack(spacing: 10) {
                baselineOffsetText
                textWithLeadingFrame
                textWithBottomFrame
                textWithTopLeftFrame
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 10)
    }
    
    
    private var baselineOffsetText: some View {
        Text("Base line offset text")
            .fontWeight(.regular)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
            .background(Color.gray)
            .baselineOffset(20.0)
            .padding(.horizontal)
    }
    
    
    private var textWithLeadingFrame: some View {
        Text("Text with leading frame")
            .font(.headline)
            .frame(width: 150, height: 50, alignment: .leading)
            .background(Color.green)
    }
    
    private var textWithBottomFrame: some View {
        Text("Text with bottom frame")
            .font(.headline)
            .frame(width: 150, height: 80, alignment: .bottom)
            .background(Color.green)
    }
    
    private var textWithTopLeftFrame: some View {
        Text("Text with top left frame")
            .font(.headline)
            .frame(width: 150, height: 80, alignment: .topLeading)
            .background(Color.green)
    }
}

#Preview {
    TextBootcamp()
}
