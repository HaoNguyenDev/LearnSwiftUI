//
//  FormView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 7/8/25.
//

import SwiftUI

#Preview {
    FormView()
}

struct FormView: View {
    @State private var username: String = ""
    @State private var enableNotification: Bool = false
    var body: some View {
        Form {
            section1()
            section2()
        }
    }
}

extension FormView {
    @ViewBuilder
    func section1() -> some View {
        Section("Account") {
            TextField("Username", text: $username)
            
            Toggle(isOn: $enableNotification) {
                Text("Enable notification")
            }
        }
    }
    
    @ViewBuilder
    func section2() -> some View {
        Section("General") {
            Button("Change password") {
                
            }.buttonStyle(.borderedProminent)
            
            Toggle(isOn: $enableNotification) {
                Text("Enable notification")
            }
        }
    }
}
