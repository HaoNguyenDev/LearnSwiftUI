//
//  InitializerBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/5/25.
//

import SwiftUI

struct InitializerBootcamp: View {
    
    var backgroundColor: Color = .red
    let point: Int
    var subtitle: String = "Low"
    
    init(newPoint: Int = 1) {
        self.point = newPoint
        changeThemeOfView(newPoint: newPoint)
    }
    
    var body: some View {
        VStack {
            Text("\(point)")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .underline(true, color: .white)
            
            Text(subtitle)
                .font(.headline)
                .foregroundStyle(.white)
        }
        .frame(width: 200, height: 200)
        .background(backgroundColor)
        .cornerRadius(20)
        
    }
}

extension InitializerBootcamp {
    private mutating func changeThemeOfView(newPoint: Int) {
        switch point {
        case 0..<30:
            backgroundColor = .red
            subtitle = "Low"
        case 30..<60:
            backgroundColor = .yellow
            subtitle = "Good"
        default:
            backgroundColor = .green
            subtitle = "Excellent"
        }
    }
}

#Preview {
    InitializerBootcamp(newPoint: 100)
}
