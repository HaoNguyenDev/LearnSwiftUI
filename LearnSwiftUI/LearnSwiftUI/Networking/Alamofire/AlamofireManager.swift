//
//  AlamofireManager.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 30/10/25.
//

import Foundation
import Alamofire

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class AlamofireManager {
    private var baseURL: String
    
    init() {
        baseURL = "https://jsonplaceholder.typicode.com"
    }
    
    func fetchPost(postNumber: String) -> Post? {
        let urlString = "\(baseURL)/posts/\(postNumber)"
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var result: Post? = nil
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil)
        .response(queue: DispatchQueue.main) { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    return
                }
                
                do {
                    result = try JSONDecoder().decode(Post.self, from: data)
                } catch {
                    debugPrint(error)
                }
            case .failure(let error):
                debugPrint("Error: \(error)")
            }
        }
        
        return result
    }
    
    //MARK: Return Result<Post, AFError>
    func fetchAndDecodePostWithResult(postNumber: String, completion:  @escaping (Result<Post, AFError>) -> Void) {
        let urlString = "\(baseURL)/posts/\(postNumber)"
        AF.request(urlString).responseDecodable(of: Post.self) { response in
            completion(response.result)
        }
    }
    
    func fetchAndDecodePost() async throws -> [Post] {
        let urlString = "\(baseURL)/posts"
        
        let post = try await AF.request(urlString)
            .serializingDecodable([Post].self)
            .value
        
        return post
    }
    
    func customConfiguration() {
        let urlString = "\(baseURL)/posts)"
        
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil
        configuration.timeoutIntervalForRequest = 60
        
        let session = Session(configuration: configuration, interceptor: CustomInterceptor())
        
        session.request(urlString).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode([Post].self, from: data)
                } catch {
                    debugPrint(error)
                }
            case .failure(let error):
                debugPrint("Error: \(error)")
            }
        }
    }

}
