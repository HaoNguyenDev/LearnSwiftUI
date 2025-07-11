//
//  SheetBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 8/6/25.
//

import SwiftUI

struct SheetBootcamp: View {
    
    @State private var showSheet = false
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            Button {
                showSheet.toggle()
            } label: {
                Text("Show Sheet")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
                    .frame(width: 200, height: 50)
                    .background(Color.white)
                    .cornerRadius(25)
            }
            
            .sheet(isPresented: $showSheet) {
                print("Sheet is presented")
            } content: {
                SecondView(stringInput: .constant(""))
            }
            
//            .fullScreenCover(isPresented: $showSheet) {
//                SecondView()
//            }
        }
    }
}

struct SecondView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var stringInput: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.green
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .padding(.top, 10)
                            .padding(.leading, 10)
                            .font(.system(size: 30))
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 50)
                
                VStack(spacing: 20) {
                    Text("Hello, World!")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                        .padding(.top, 30)
                    
                    TextField("Enter your name", text: $stringInput)
                        .frame(width: .infinity, height: 50)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Submit")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .cornerRadius(25)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 20)
            }
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
    }
}

#Preview {
    SheetBootcamp()
//    SecondView(stringInput: .constant(""))
}
