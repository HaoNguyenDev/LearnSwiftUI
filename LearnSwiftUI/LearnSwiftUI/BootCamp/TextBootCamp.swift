//
//  TextBootCamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/5/25.
//


import SwiftUI

struct TextBootCamp: View {
    var body: some View {
        Text("Hello! This is a text, and we can style it, color it, and make it look pretty! And we can even make it look like a link!")
//            .font(.title)
//            .fontWeight(.semibold)
//            .font(.system(size: 18.0, weight: .bold, design: .serif))
            .font(.dosis(fontweight: .bold, size: 18.0)) //Custom font in from Font folder
            .foregroundColor(Color.blue)
            .multilineTextAlignment(.center)
            .baselineOffset(20.0)
            .kerning(5.0)
            .underline(true, color: .red)
            .strikethrough(true, color: .black)
            .padding(.horizontal, 10.0)
            .frame(width: 400.0, height: 200.0, alignment: .center)
    }
    
    init() {
        UIFont.familyNames.forEach {
            print($0)
            UIFont.fontNames(forFamilyName: $0).forEach {
                print($0)
            }
        }
    }
}

#Preview {
    TextBootCamp()
}
