//
//  ObservablePattern.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/8/25.
//

/*
 Swift 6 and iOS 17+ @Observable Pattern
 Clean syntax with @Observable macro
 Automatic property tracking
 Use the same @Environment wrapper
 Better performance than ObservableObject
 */
import Foundation
import SwiftUI

@Observable final class ObservablePattern {
    var count: Int = 0
    var name: String = "Tap to change me"
    var textSize: CGFloat = 17
    @ObservationIgnored // Mark untrack the changes of the properties below  @ObservationIgnored macro
    var number: Int = 0
}

struct ObservableView: View {
    @State private var observableObject: ObservablePattern = .init()
    
    var body: some View {
        VStack {
            ObservableContentView()
                .environment(observableObject)
        }
    }
}

struct ObservableContentView: View {
    @Environment(ObservablePattern.self) private var observable
    
    var body: some View {
        @Bindable var bind = observable // make binding with Bindable
        
        VStack {
            Button {
                observable.name = "Hello, World!"
                observable.count += 1 // test change value of untracked properties
            } label: {
                Text("\(observable.name)")
                    .font(.system(size: observable.textSize))
            }.buttonStyle(.borderedProminent)

            
            Text("@ObservationIgnored number \(observable.number)")
            
            ObservableSubView(observable: observable) //Subview with Bindable
            
            TextField("enter text", text: $bind.name)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.yellow))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue.opacity(0.7))
        )
    }
}

struct ObservableSubView: View {
    @Bindable var observable: ObservablePattern
    
    var body: some View {
        VStack {
            Slider(value: $observable.textSize, in: 10...40)
                .padding()
            
            Text("\(Int(observable.textSize))")
                .font(.system(size: observable.textSize))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.green)
        )
          
    }
}
#Preview {
    ObservableView()
        .environment(ObservablePattern())
}
