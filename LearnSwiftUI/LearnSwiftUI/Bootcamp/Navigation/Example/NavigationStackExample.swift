//
//  NavigationStackExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/1/26.
//

import SwiftUI

struct NavigationStackExample: View {
    var body: some View {
        NavigationStack {
            HomeViewExample()
                //.navigationTitle("Home Page")
        }
    }
}

struct HomeViewExample: View {
    var body: some View {
        NavigationLink("Details Page") {
            DetailPageExample()
        }
    }
}

struct DetailPageExample: View {
    var body: some View {
        Text("Here is Detail")
    }
}

#Preview {
    NavigationStackExample()
}
