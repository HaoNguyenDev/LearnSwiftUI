//
//  ImageStylingModifier.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 12/10/25.
//

import SwiftUI

struct ImageStylingModifier: ViewModifier {
    let size: CGSize
    let contentMode: ContentMode
    let cornerRadius: CGFloat
    let borderWidth: CGFloat
    let borderColor: Color

    func body(content: Content) -> some View {
        
        content
            .aspectRatio(contentMode: contentMode)
            .frame(width: size.width, height: size.height)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
    }
}

extension View {
    func imageStyle(
        width: CGFloat = 64,
        height: CGFloat = 64,
        mode: ContentMode = .fill,
        radius: CGFloat = 8,
        border: CGFloat = 0,
        color: Color = .clear
    ) -> some View {
        self.modifier(ImageStylingModifier(
            size: CGSize(width: width, height: height),
            contentMode: mode,
            cornerRadius: radius,
            borderWidth: border,
            borderColor: color
        ))
    }
    
    func avatarStyle(size: CGFloat = 50) -> some View {
        self.modifier(ImageStylingModifier(
            size: CGSize(width: size, height: size),
            contentMode: .fill,
            cornerRadius: size / 2, // Tạo hình tròn
            borderWidth: 2,
            borderColor: .gray.opacity(0.3)
        ))
    }
}


struct ImageStylingDemoView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Image Styling Modifier Demo (Must call .resizable() first)")
                .textStyle(font: R.font.ttHovesProTrialMd.font(size: 20))
            
     
            VStack {
                Text("Thumbnail Rounded Corners")
                    .font(.headline)
                Image(R.image.child)
                    .resizable()
                    .foregroundColor(.blue)
                    .imageStyle(
                        width: 200,
                        height: 150,
                        mode: .fill,
                        radius: 12,
                        border: 1,
                        color: .blue
                    )
            }
            
            VStack {
                Text("Round Avatar")
                    .font(.headline)
                Image(R.image.child)
                    .resizable()                    .renderingMode(.original)
                    .imageStyle(
                        width: 150,
                        height: 150,
                        mode: .fill,
                        radius: 75,
                        border: 3,
                        color: .green
                    )
            }
            
            VStack {
                Text("Fixed Icon (No need to resizable if using small size SF Symbol)")
                    .font(.headline)
                // Small sized SF Symbols usually do not need to be resizable.
                Image(systemName: "star.fill")
                    .foregroundColor(R.color.blueText.color)
                    .imageStyle(
                        width: 30,
                        height: 30,
                        mode: .fit,
                        radius: 6,
                        border: 0,
                        color: .clear
                    )
            }
        }
        .padding()
    }
}

#Preview {
    ImageStylingDemoView()
}
