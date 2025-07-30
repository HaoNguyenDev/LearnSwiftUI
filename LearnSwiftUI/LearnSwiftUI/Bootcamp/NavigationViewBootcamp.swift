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
    let items = ["Apple", "Orange", "Banana", "Pineapple"]
    var body: some View {
        
        NavigationView { //NavigationView wraps the entire interface to enable navigation.
            VStack {
                
                //NavigationLink creates a button or clickable area that, when clicked, switches to a DetailView.
                NavigationLink(destination: {
                    DestinationView()
                }, label: {
                    Text("Go to Destination")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.blue)
                })
                
                //Show sheet
                Button(action: {
                    isPresented = true
                }, label: {
                    Text("Present Modal")
                        .foregroundStyle(.white)
                        .padding()
                }).buttonStyle(.borderedProminent)
                
                //Show fullscreen cover
                Button(action: {
                    showFullScreenCover = true
                }, label: {
                    Text("Show FullScreen Cover")
                        .foregroundStyle(.white)
                        .padding()
                }).buttonStyle(.borderedProminent)
                
                //Destination with list
                VStack(alignment: .leading) {
                    ForEach(items, id: \.self) { item in
                        NavigationLink(destination: DestinationView(string: item)) {
                            Text(item)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.5))
                
                .navigationTitle(Text("NavigationView"))
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        
        .sheet(isPresented: $isPresented, onDismiss: {
            print(">>> Dismissed")
            isPresented = false
        }, content: {
            DestinationView(dismiss: {
                isPresented = false
            })
        })
        
        .fullScreenCover(isPresented: $showFullScreenCover, onDismiss: {
            print(">>> Dismissed")
            showFullScreenCover = false
        }, content: {
            DestinationView(dismiss: {
                showFullScreenCover = false
            })
        })
    }
}

struct DestinationView: View {
    var dismiss: (() -> Void)?
    var string: String?
    
    init(string: String? = nil, dismiss: (() -> Void)? = nil) {
        self.string = string
        self.dismiss = dismiss
    }
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            VStack {
                text
                dismissButton
            }
        }
        .navigationTitle(
            Text("Destination View")
                .font(.headline)
                .foregroundStyle(.white)
        )
        .navigationBarItems(
            trailing: Button(action: {
                print("Pressed Plus")
            }) {
                Image(systemName: "plus")
            }
        )
//        .navigationBarHidden(true) // Hide the navigation bar
        
        
    }
    
    @ViewBuilder
    private var text: some View {
        if let unwrapString = string {
            Text(unwrapString)
                .font(.headline)
                .foregroundStyle(.white)
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
