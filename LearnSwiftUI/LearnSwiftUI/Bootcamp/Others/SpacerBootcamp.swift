//
//  SpacerBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/5/25.
//

import SwiftUI

struct SpacerBootcamp: View {
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Spacer()
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .frame(width: 100, height: 100)
                
                Spacer()
                    .frame(width: 20)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
                
                Spacer()
            }
            .background(Color.gray.opacity(0.2))
            
            HStack {
                Image(systemName: "xmark")
                    .font(.title)
                Spacer()
                    .frame(width: 20)
                Image(systemName: "gear")
                    .font(.title)
            }
            .font(.title)
            .background(Color.green.opacity(0.5))
        }
    }
}

#Preview {
    SpacerBootcamp()
}
