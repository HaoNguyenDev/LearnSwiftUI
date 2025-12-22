//
//  BootcampListView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/12/25.
//

import SwiftUI


struct BootcampListView: View {
    @Environment(\.theme) var theme
    
    var body: some View {
        ForEach(BootcampEnums.allCases, id: \.self) { bootcamp in
            VStack {
                Text(bootcamp.rawValue)
                    .font(theme.font.bold(ofSize: 18.0))
                    .foregroundColor(Color.blue)
            }
        }
    }
}
