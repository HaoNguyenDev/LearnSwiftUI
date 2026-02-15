//
//  FormViewSafeAreaInset.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/1/26.
//

import SwiftUI

struct FormViewSafeAreaInset: View {
    @State private var name = ""
    @State private var address = ""
    @State private var phone = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)

                TextField("Address", text: $address)
                    .textFieldStyle(.roundedBorder)

                TextField("Phone", text: $phone)
                    .textFieldStyle(.roundedBorder)

                ForEach(0..<10) { i in
                    Text("Extra Field \(i)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
        }
        .safeAreaInset(edge: .bottom) {
            Button("Submit") {
                print("Submit")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.ultraThinMaterial)
        }
    }
}
