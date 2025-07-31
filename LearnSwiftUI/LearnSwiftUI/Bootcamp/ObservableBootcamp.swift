//
//  ObservableBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 31/7/25.
//

import Foundation
import SwiftUI

//MARK: ObservableObject (iOS 13+):
class ObservableObjectModel: ObservableObject {
    @Published var text: String = ""
    @Published var count: Int = 0
}

//MARK: Observable (iOS 17+)
@Observable
class ObservableModel {
    var someThings: String = "" // No need define @Published
    var count: Int = 0
}


 struct ObservableBootcamp: View {
     @StateObject var observableObjectModel = ObservableObjectModel()
     @State var observableModel = ObservableModel() // No need define @StateObject
     
   
     var body: some View {
         VStack {
             NewObservablView()
                 .environment(observableModel) // Conform @Observable
                 .environmentObject(observableObjectModel) // Conform @ObservableObject
             /*If we want inject an ObservableObject into an environment not environmentObject that object need to confrom both Observable and Observableobject protocol*/
         }
     }
 }
 

struct NewObservablView: View {
    @Environment(ObservableModel.self) var sharedModel // Use @Environment
    
    var body: some View {
        Text(sharedModel.someThings)
    }
}
