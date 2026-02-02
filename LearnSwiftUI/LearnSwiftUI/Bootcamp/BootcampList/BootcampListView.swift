//
//  BootcampListView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/12/25.
//

import SwiftUI

struct BootcampListView: View {
    @Environment(\.theme) var theme
    
    var selecteRoute: SingleResult<Route.BootcampListRoute>?
    
    var body: some View {
        NavigationView {
            bootcampList
                .navigationBarTitle("SwiftUI Bootcamp List")
        }
    }
    
    private var bootcampList: some View {
        VStack {
            List {
                ForEach(Route.BootcampListRoute.allCases, id: \.self) { bootcamp in
                    bootcampItem(bootcamp: bootcamp)
                }
            }
        }
    }
    
    private func bootcampItem(bootcamp: Route.BootcampListRoute) -> some View {
        VStack {
            Text(bootcamp.rawValue)
                .font(theme.font.bold(ofSize: 18.0))
                .foregroundColor(Color.blue)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
//        .background(Color.gray)
        .contentShape(Rectangle())
        .onTapGesture {
            selecteRoute?(bootcamp)
        }
    }
}

#Preview {
    BootcampListView()
}
