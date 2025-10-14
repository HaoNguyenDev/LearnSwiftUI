//
//  NetworkingBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 14/10/25.
//

import Foundation

protocol NetworkingBootcampProtocol {
    func callApiWithResult(urlString: String, completion: @escaping (Result<String, Error>) -> Void)
}

class NetworkingBootcamp: NetworkingBootcampProtocol {
    let urlSession = URLSession.shared
}

extension NetworkingBootcamp {
    
    func callApiWithResult(urlString: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        urlSession.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if error is URLError {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse(statusCode: 0000)))
                return
            }
            
            let statusCode = httpResponse.statusCode
            
            switch statusCode {
            case 200..<300:
                guard let data else {
                    completion(.failure(NetworkError.invalidResponse(statusCode: statusCode)))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(String.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(NetworkError.decodingError(error: error)))
                }
            case 400..<500:
                completion(.failure(NetworkError.clientError(statusCode: httpResponse.statusCode)))
            case 500..<600:
                completion(.failure(NetworkError.serverError(statusCode: httpResponse.statusCode)))
            default:
                completion(.failure(NetworkError.unknownError(statusCode: statusCode)))
            }
        }
    }
}
