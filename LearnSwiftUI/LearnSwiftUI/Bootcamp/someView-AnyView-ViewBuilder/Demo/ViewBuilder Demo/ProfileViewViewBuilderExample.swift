//
//  ProfileViewViewBuilder.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/2/26.
//

import SwiftUI

struct ProfileViewViewBuilderExample: View {
    let isLoggedIn: Bool
    
    var body: some View {
        VStack {
            header
            content
        }
    }
    
    @ViewBuilder
    var header: some View {
        if isLoggedIn {
            Text("Welcome back!")
            Image(systemName: "person.circle.fill")
        } else {
            Text("Please login")
        }
    }
    
    @ViewBuilder
    var content: some View {
        Text("Content here")
        Divider()
        Text("More content")
    }
}

#Preview {
    ProfileViewViewBuilderExample(isLoggedIn: true)
}

#Preview {
    ProfileViewViewBuilderExample(isLoggedIn: false)
}
