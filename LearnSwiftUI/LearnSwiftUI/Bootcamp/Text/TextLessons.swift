//
//  TextLessons.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 6/1/26.
//

import SwiftUI

enum TextLessons {
    static let all: [Lesson] = [
        //MARK: - Title
        Lesson(title: "Title",
               code: """
Text("Title")
    .font(.title)
""",
               result: {
                   AnyView( ResultBlockView(content: {
                       Text("Title")
                           .font(.title)
                   }))
               }),
        
        //MARK: - Custom font
        Lesson(title: "Custom font",
               code: """
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


""",
               result: {
                   AnyView(ResultBlockView(content: {
                       Text("Custom font")
                           .font(.system(size: 18, weight: .bold, design: .rounded))
                       
                       Text("Bold")
                           .fontWeight(.bold)
                       
                       Text("Italic")
                           .italic()
                   }))
               }),
        
        //MARK: - foregroundColor
        Lesson(title: "foregroundColor",
               code: """
Text("Blue")
    .foregroundColor(.blue)
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       Text("Blue")
                           .foregroundColor(.blue)
                   }))
               }),
        
        //MARK: - Add multi text
        Lesson(title: "Add multi text",
               code: """
Text("Hello ")
    .foregroundColor(.blue)
+ Text("SwiftUI")
    .fontWeight(.bold)
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       Text("Hello ")
                           .foregroundColor(.blue)
                       + Text("SwiftUI")
                           .fontWeight(.bold)
                   }))
               }),
        
        //MARK: - Gradient text
        Lesson(title: "Gradient text",
               code: """
Text("Gradient")
    .foregroundStyle(.linearGradient(
        colors: [.red, .orange, .blue],
        startPoint: .leading,
        endPoint: .trailing))
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       Text("Gradient")
                           .foregroundStyle(.linearGradient(
                            colors: [.red, .orange, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                           ))
                   }))
               }),
        
        //MARK: - underline text
        Lesson(title: "underline text",
               code: """
Text("Underline")
    .underline(true, pattern: .dashDot, color: .blue)
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       Text("Underline")
                           .underline(true, pattern: .dashDot, color: .blue)
                   }))
               }),
        
        //MARK: - strikethrough text
        Lesson(title: "strikethrough text",
               code: """
Text("Strikethrough")
    .strikethrough()
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       Text("Strikethrough")
                           .strikethrough()
                   }))
               }),
        
        //MARK: - kerning text
        Lesson(title: "kerning text",
               code: """
Text("Kerning")
    .kerning(8.0)
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       Text("Kerning")
                           .kerning(8.0)
                   }))
               }),
        
        //MARK: - lineSpacing text
        Lesson(title: "lineSpacing text",
               code: """
Text("Line 1"\n"Line 2")
    .lineSpacing(8)
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       Text("Line 1\nLine 2")
                           .lineSpacing(8)
                   }))
               }),
        
        //MARK: - lineLimit text
        Lesson(title: "lineLimit text",
               code: """
Text("lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit")
        .font(.system(size: 12, weight: .semibold, design: .rounded))
        .lineLimit(2)
        .frame(width: 120, height: 80, alignment: .center)
        .padding()
        .background(Color.green)
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       Text("lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit")
                           .font(.system(size: 12, weight: .semibold, design: .rounded))
                           .lineLimit(2)
                           .frame(width: 120, height: 80, alignment: .center)
                           .padding()
                           .background(Color.green)
                   }))
               }),
        
        //MARK: - truncationMode text
        Lesson(title: "truncationMode text",
               code: """
Text("truncationMode truncationMode truncationMode truncationMode")
    .lineLimit(1)
    .truncationMode(.middle) // .head / .middle
    .frame(width: 200, height: 40, alignment: .center)
    .background(Color.green)
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       Text("truncationMode truncationMode truncationMode truncationMode")
                           .lineLimit(1)
                           .truncationMode(.middle) // .head / .middle
                           .frame(width: 200, height: 40, alignment: .center)
                           .background(Color.green)
                   }))
               }),
        
        //MARK: - contentShape text
        Lesson(title: "contentShape text",
               code: """
Text("Tap with \n.contentShape(Rectangle()) ")
    .contentShape(Rectangle())
    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
    .background(Color.green)
    .onTapGesture {
        debugPrint("Tapped!")
    }
    .padding(.horizontal)
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       Text("Tap with \n.contentShape(Rectangle()) ")
                           .contentShape(Rectangle())
                           .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                           .background(Color.green)
                           .onTapGesture {
                               debugPrint("Tapped!")
                           }
                           .padding(.horizontal)
                   }))
               }),
        
        // MARK: - layoutPriority
        Lesson(title: "layoutPriority",
               code: """
HStack {
    Text("This is a very very long title")
        .lineLimit(1)
    Text("10:30 AM")
}
.frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
.padding(.horizontal, 50)
.background(Rectangle().foregroundStyle(.green))

HStack {
    Text("This is a very very long title")
        .lineLimit(1)
        .layoutPriority(1)
    Text("10:30 AM")
}
.frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
.padding(.horizontal, 50)
.background(Rectangle().foregroundStyle(.green))

""",
               result: {
                   AnyView(ResultBlockView(content: {
                       VStack {
                           HStack {
                               Text("This is a very very long title")
                                   .lineLimit(1)
                               Text("10:30 AM")
                           }
                           .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                           .padding(.horizontal, 50)
                           .background(Rectangle().foregroundStyle(.green))
                           
                           HStack {
                               Text("This is a very very long title")
                                   .lineLimit(1)
                                   .layoutPriority(1)
                               Text("10:30 AM")
                           }
                           .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                           .padding(.horizontal, 50)
                           .background(Rectangle().foregroundStyle(.green))
                       }
                   }))
               }),
        
        // MARK: - fixedSize
        Lesson(title: "fixedSize",
               code: """
Text("This is a very very long title")
    .fixedSize(horizontal: true, vertical: false)
    .background(RoundedRectangle(cornerRadius10).foregroundStyle(.green))

HStack {
    Text("This is a very very long title")
        .fixedSize(horizontal: false, vertical: true
    Image(systemName: "star")
}

    👉 Text:
    No wrapping
    No truncation
    Layout may break
""",
               result: {
                   AnyView(ResultBlockView(content: {
                       VStack {
                           Text("This is a very very long title")
                               .fixedSize(horizontal: true, vertical: false)
                               .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.green))
                           
                           HStack {
                               Text("This is a very very long title")
                                   .fixedSize(horizontal: false, vertical: true)
                               
                               Image(systemName: "star")
                           }
                       }
                   }))
               }),
        
        // MARK: - The order of modifiers when working with text.
        Lesson(title: "The order of modifiers when working with text.",
               code: """
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
""",
               result: {
                   AnyView(ResultBlockView(content: {
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
                   }))
               }),
        //MARK: - AttributedString
        Lesson(title: "AttributedString",
               code: """
AnyView(
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
 }))
""",
               result: {
                   AnyView(
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
                    }))
               }),
        // MARK: - Base line offset text
        Lesson(title: "Base line offset text",
               code: """
Text("Base line offset text")
    .fontWeight(.regular)
    .foregroundStyle(.primary)
    .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
    .background(Color.gray)
    .baselineOffset(20.0)
    .padding(.horizontal)
""",
               result: {
                   AnyView(
                    ResultBlockView(content: {
                        Text("Base line offset text")
                            .fontWeight(.regular)
                            .foregroundStyle(.primary)
                            .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
                            .background(Color.gray)
                            .baselineOffset(20.0)
                            .padding(.horizontal)
                    })
                   )
               }),
        
        //MARK: - Text with leading frame
        Lesson(title: "Text with leading frame",
               code: """
        Text("Text with leading frame")
            .font(.headline)
            .frame(width: 150, height: 50, alignment: .leading)
            .background(Color.green)
""",
               result: {
                   AnyView(
                    ResultBlockView(content: {
                        Text("Text with leading frame")
                            .font(.headline)
                            .frame(width: 150, height: 50, alignment: .leading)
                            .background(Color.green)
                    })
                   )
               }),
        
        // MARK: - Text with bottom frame
        Lesson(title: "Text with bottom frame",
               code: """
        Text("Text with bottom frame")
            .font(.headline)
            .frame(width: 150, height: 80, alignment: .bottom)
            .background(Color.green)
""",
               result: {
                   AnyView(
                    ResultBlockView(content: {
                        Text("Text with bottom frame")
                            .font(.headline)
                            .frame(width: 150, height: 80, alignment: .bottom)
                            .background(Color.green)
                    })
                   )
               }),
        
        //MARK: - Text with top left frame
        Lesson(title: "Text with top left frame",
               code: """
        Text("Text with top left frame")
            .font(.headline)
            .frame(width: 150, height: 80, alignment: .topLeading)
            .background(Color.green)
""",
               result: {
                   AnyView(
                    ResultBlockView(content: {
                        Text("Text with top left frame")
                            .font(.headline)
                            .frame(width: 150, height: 80, alignment: .topLeading)
                            .background(Color.green)
                    })
                   )
               }),
        
        // MARK: - Debug Text
        Lesson(title: "Debug Text",
               code: """
/// Debug intrinsic size of Text
Text("Hello")
    .border(Color.red)
 // or //
Text("Hello")
    .padding()
    .border(Color.red)
👉 You see the correct font size, not full width.

/// Use backgrounds to debug wrap and spacing.
Text("Hello SwiftUI")
    .background(Color.yellow)
👉 Debug:
    Line height
    Wrap
    Alignment

Text("Hi Bro!")
    .background(.green)
    .frame(width: 80, height: 100, alignment: .center)
    .background(.blue)

    .background(.green) are intrinsic size
    .background(.blue) are parrent size

/// Debugging hit-testing (tap not responding)
Text("Tap me")
    .background(Color.blue.opacity(0.2))
    .contentShape(Rectangle())
    .onTapGesture { }
👉 You can see the actual tap area.

""",
               result: {
                   AnyView(
                    ResultBlockView(content: {
                        VStack(alignment: .center) {
                            Text("Hello")
                                .padding()
                                .border(Color.red)
                            
                            Text("Hello SwiftUI")
                                .background(Color.yellow)
                            
                            Text("Hi Bro!")
                                .background(.green)
                                .frame(width: 80, height: 100, alignment: .center)
                                .background(.blue)
                            
                            Text("Tap me")
                                .background(Color.blue.opacity(0.2))
                                .contentShape(Rectangle())
                                .onTapGesture { }
                        }
                    }))
               }),
    ]
}
