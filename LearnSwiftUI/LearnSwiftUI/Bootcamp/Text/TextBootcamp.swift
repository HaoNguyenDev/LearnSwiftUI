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
            VStack(spacing: 10) {
                Text("Title")
                    .font(.title)
                
                /*
                 .largeTitle
                 .title, .title2, .title3
                 .headline
                 .body
                 .callout
                 .caption, .caption2
                 */

                Text("Custom")
                    .font(.system(size: 18, weight: .bold, design: .rounded))

                
                Text("Blue")
                    .foregroundColor(.blue)
                
                Text("Hello ")
                    .foregroundColor(.blue)
                + Text("SwiftUI")
                    .fontWeight(.bold)

                var attributed: AttributedString {
                    var text = AttributedString("Attributed String")
                    text.foregroundColor = .blue
                    text.font = .system(size: 20, weight: .bold)
                    return text
                }
                Text(attributed)

                var attributedHighlight: AttributedString {
                    var text = AttributedString("Highlight Text")
                    text.foregroundColor = .black
                    text[text.range(of: "Text")!].foregroundColor = .red
                    text.font = .system(size: 20, weight: .bold)
                    return text
                }
                Text(attributedHighlight)
                                
                Text("Gradient")
                    .foregroundStyle(.linearGradient(
                        colors: [.red, .orange],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))

                Text("Bold")
                    .fontWeight(.bold)

                Text("Italic")
                    .italic()

                Text("Underline")
                    .underline(true, pattern: .dashDot, color: .blue)

                Text("Strikethrough")
                    .strikethrough()
               
                Text("Kerning")
                    .kerning(8.0)
                
                Text("Hello SwiftUI")
                    .multilineTextAlignment(.center)

                Text("Line 1\nLine 2")
                    .lineSpacing(8)

                Text("lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit lineLimit")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .lineLimit(2)
                    .frame(width: 120, height: 80, alignment: .center)
                    .padding()
                    .background(Color.green)
                
                Text("truncationMode truncationMode truncationMode truncationMode")
                    .lineLimit(1)
                    .truncationMode(.middle) // .head / .middle
                    .frame(width: 200, height: 40, alignment: .center)
                    .background(Color.green)
                
                
                Text("Tap with \n.contentShape(Rectangle()) ")
                    .contentShape(Rectangle())
                    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                    .background(Color.green)
                    .onTapGesture {
                        debugPrint("Tapped!")
                    }
                    .padding(.horizontal)

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
