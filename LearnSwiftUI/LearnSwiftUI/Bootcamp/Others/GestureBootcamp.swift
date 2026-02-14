//
//  GestureBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 6/8/25.
//

import Foundation
import SwiftUI

struct TapGestureView: View {
    @State private var message = "Chạm vào ô vuông!"
    private let doubleTap: Int = 2
    
    @State private var isPressed: Bool = false
    
    @State private var offset: CGSize = .zero
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                //Tap
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 200, height: 200)
                    .cornerRadius(20)
                    .overlay(
                        Text(message)
                            .foregroundColor(.white)
                            .font(.headline)
                    )
                    .gesture(
                        TapGesture(count: doubleTap)
                            .onEnded {
                                message = "You did tap \(doubleTap) times!"
                                print("You did tap on me \(doubleTap) times!")
                            }
                    )
                
                //Long press
                Circle()
                    .fill(isPressed ? Color.red : Color.green)
                    .frame(width: 150, height: 150)
                    .scaleEffect(isPressed ? 1.2 : 0.8)
                    .animation(.easeInOut, value: isPressed)
                    .gesture(
                        LongPressGesture(minimumDuration: 1.0) // Long press with at least 1 second
                            .onEnded { value in
                                isPressed.toggle()
                                print("Long press ended!")
                            }
                    )
                
                //Drag
                RoundedRectangle(cornerRadius: 20)
                           .fill(Color.orange)
                           .frame(width: 150, height: 150)
                           .offset(offset)
                           .animation(.spring(), value: offset) // Tạo hiệu ứng chuyển động mượt mà
                           .gesture(
                               DragGesture()
                                   .onChanged { value in
                                       self.offset = value.translation
                                       print("Offset: \(value.startLocation)")
                                   }
                                   .onEnded { value in
                                       withAnimation {
                                           self.offset = .zero // Quay về vị trí ban đầu
                                           print("Offset: \(offset)")
                                       }
                                   }
                           )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
 
    }
}

#Preview {
    TapGestureView()
}

struct InteractiveImageView: View {
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Angle = .zero

    var body: some View {
        Image(systemName: "photo.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .scaleEffect(scale)
            .rotationEffect(rotation)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        self.scale = value
                    }
            )
            .simultaneousGesture( // Cho phép cả hai gesture hoạt động cùng lúc
                RotationGesture()
                    .onChanged { value in
                        self.rotation = value
                    }
            )
    }
}

#Preview {
    InteractiveImageView()
}

struct SequencedGestureView: View {
    @State private var isTapped = false

    var body: some View {
        Text(isTapped ? "Unlocked, long press to lock" : "Long press to unlock")
            .padding()
            .background(isTapped ? Color.red : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .gesture(
                LongPressGesture(minimumDuration: 1)
                    .sequenced(before: TapGesture())
                    .onEnded { value in
                        self.isTapped.toggle()
//                        switch value {
//                        case .first(true):
//                            print("Long press detected, now waiting for tap...")
//                        case .second(true, nil):
//                            print("Long press ended, but no tap detected yet.")
//                        case .second(true, nil):
//                            withAnimation {
//                                self.isTapped.toggle()
//                            }
//                            print("Long press + Tap detected!")
//                        case .second(true, nil):
//                            withAnimation {
//                                self.isTapped.toggle()
//                            }
//                            print("Long press + Tap detected!")
//                        default:
//                            break
//                        }
                    }
            )
    }
}

#Preview {
    SequencedGestureView()
}
