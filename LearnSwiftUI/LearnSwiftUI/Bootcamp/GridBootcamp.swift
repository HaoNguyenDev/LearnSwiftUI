//
//  GridBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 2/6/25.
//

import SwiftUI

struct GridBootcamp: View {
//    let columns: [GridItem] = [GridItem(.fixed(100)),
//                               GridItem(.flexible()),
//                               GridItem(.adaptive(minimum: 50))]

    let columns: [GridItem] = [GridItem(.fixed(40)),
                               GridItem(.flexible()),
                               GridItem(.adaptive(minimum: 20))]
    
//    let columns: [GridItem] = [GridItem(.flexible(minimum: 100), spacing: nil, alignment: .center),
//                               GridItem(.flexible(minimum: 100), spacing: nil, alignment: .center)]
    
//                               GridItem(.flexible(minimum: 100), spacing: nil, alignment: .center),
//                               GridItem(.flexible(minimum: 100, maximum: 200), spacing: nil, alignment: .center)]
    
    let rows: [GridItem] = [GridItem(.fixed(100))]
    
    private let alphabet: [Character] = Array("abcdefghijklmnopqrstuvwxyz")
    
    var body: some View {
        ScrollView() {
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach(alphabet, id: \.self) { word in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                            .frame(height: 40)
                            .overlay(content: {
                                Text("\(word)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            })
                            .onTapGesture {
                                print(">>> Tapped: ", word)
                            }
                    }
                }
                .padding(20)
            }
        
            
            ScrollView(.horizontal) {
                HStack {
                    LazyHGrid(rows: rows) {
                        ForEach (alphabet, id: \.self) { word in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                                .frame(width: 50, height: 50)
                                .overlay(content: {
                                    Text("\(word)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                })
                                .onTapGesture {
                                    print(">>> Tapped: ", word)
                                }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            }
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], alignment: .leading, spacing: 10, pinnedViews: [.sectionHeaders]) {
                
                Section {
                    ForEach(alphabet, id: \.self) { word in
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 50, height: 50)
                            .overlay(content: {
                                Text("\(word)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            })
                    }
                } header: {
                    Text("Section Header 1")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                
                Section {
                    ForEach(0..<100) { word in
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 50, height: 50)
                            .overlay(content: {
                                Text("\(word)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            })
                    }
                } header: {
                    Text("Section Header 2")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                
                Section {
                    ForEach(29..<41) { word in
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 50, height: 50)
                            .overlay(content: {
                                Text("\(word)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            })
                    }
                } header: {
                    Text("Section Header 3")
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }
            
            



        }
        .padding(.top, 10)
        
    }
}

#Preview {
    GridBootcamp()
}
