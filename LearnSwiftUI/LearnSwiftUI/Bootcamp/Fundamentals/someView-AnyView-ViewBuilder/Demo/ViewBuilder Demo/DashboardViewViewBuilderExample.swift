//
//  DashboardViewViewBuilderExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/2/26.
//

import SwiftUI

struct DashboardViewViewBuilderExample: View {
    var body: some View { 
        VStack { 
            makeHeader() 
            makeStats() 
            makeFooter() 
        } 
    } 

    @ViewBuilder 
    func makeHeader() -> some View { 
        Text("Dashboard") 
            .font(.largeTitle) 
        Text("Last updated: Now") 
            .font(.caption) 
    } 

    @ViewBuilder 
    func makeStats() -> some View { 
        HStack { 
            StatCard(title: "Users", value: "1.2K") 
            StatCard(title: "Revenue", value: "$45K") 
        } 
    } 

    @ViewBuilder 
    func makeFooter() -> some View { 
        Divider() 
        Text("© 2024") 
    }
}

struct StatCard: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack {
            Text(title)
            Text(value)
        }
    }
}
