//
//  NavigationViewBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 28/7/25.
//

import SwiftUI

struct NavigationViewBootcamp: View {
    @State private var isPresented: Bool = false
    @State private var showFullScreenCover: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: {
                    DestinationDemoView(dismiss: {})
                }, label: {
                    Text("Go to Destination")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.blue)
                })
                
                Button(action: {
                    isPresented = true
                }, label: {
                    Text("Present Modal")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.blue)
                })
                
                Button(action: {
                    showFullScreenCover = true
                }, label: {
                    Text("Show FullScreen Cover")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.blue)
                })
                
                
                .navigationTitle(Text("NavigationView"))
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        
        .sheet(isPresented: $isPresented, onDismiss: {
            print(">>> Dismissed")
            isPresented = false
        }, content: {
            DestinationDemoView(dismiss: {
                isPresented = false
            })
        })
        
        .fullScreenCover(isPresented: $showFullScreenCover, onDismiss: {
            print(">>> Dismissed")
            showFullScreenCover = false
        }, content: {
            DestinationDemoView(dismiss: {
                showFullScreenCover = false
            })
        })
    }
}

struct DestinationDemoView: View {
    var dismiss: (() -> Void)?
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            VStack {
                Text("Destination View")
                    .font(.headline)
                    .foregroundStyle(.white)
                
                Button {
                    dismiss?()
                } label: {
                    Text("Dissmiss")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(10)
                        .background(Color.blue)
                }

            }
        }
        
    }
}

#Preview {
    NavigationViewBootcamp()
}
