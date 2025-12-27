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
            // MARK: - The order of modifiers when working with text.
            
            CodePreviewContainer(title: "The order of modifiers when working with text.\n1️⃣ Content → 2️⃣ Text style → 3️⃣ Layout \n→ 4️⃣ Drawing → 5️⃣ Interaction", code: """
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
