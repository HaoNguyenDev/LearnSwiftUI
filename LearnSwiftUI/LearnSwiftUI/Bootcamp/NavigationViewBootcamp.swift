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
                    DestinationDemoView()
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
    
    init(dismiss: (() -> Void)? = nil) {
        self.dismiss = dismiss
    }
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            VStack {
                Text("Destination View")
                    .font(.headline)
                    .foregroundStyle(.white)
                
                dismissButton
            }
        }
        
    }
    
    @ViewBuilder
    private var dismissButton: some View {
        if dismiss != nil {
            Button {
                dismiss?()
            } label: {
                Text("Dissmiss")
                    .font(.headline)
                    .foregroundStyle(.white)
            }.buttonStyle(.borderedProminent)
        }
    }
    
}

#Preview {
    NavigationViewBootcamp()
}
