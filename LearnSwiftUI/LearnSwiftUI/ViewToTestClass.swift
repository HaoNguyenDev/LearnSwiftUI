//
//  ViewToTestClass.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 30/10/25.
//

import SwiftUI

struct ViewToTestClass: View {
    let alamofireManager: AlamofireManager
    
    init() {
        self.alamofireManager = AlamofireManager()
    }
    
    var body: some View {
        Text("ViewToTestClass")
            .onAppear {
//               fetchPost()
                fetchPostWithResult()
//                fetchPostDecodable()
            }
    }
}

extension ViewToTestClass {
    private func fetchPost() {
        let post = alamofireManager.fetchPost(postNumber: "1")
        guard let post = post else {
            return
        }
        
        let jsonString = try! JSONSerialization.data(withJSONObject: post, options: []).base64EncodedString()
        debugPrint(jsonString)
    }
    
    private func fetchPostWithResult() {
        alamofireManager.fetchAndDecodePostWithResult(postNumber: "1", completion: { result in
            switch result {
            case .success(let post):
                debugPrint(post)
            case .failure(let error):
                debugPrint(error)
            }
        })
    }
    
    private func fetchPostDecodable() {
        Task {
            do {
                let post = try await alamofireManager.fetchAndDecodePost()
                debugPrint(post)
            }
            catch {
                debugPrint(error)
            }
        }
    }
}
