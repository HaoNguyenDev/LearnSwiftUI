//
//  NetworkingBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 14/10/25.
//

import Foundation
import Combine

// MARK: - Networking Protocol
protocol NetworkingBootcampProtocol {
    func fetchData<T: Decodable>(from urlString: String, as type: T.Type) async throws -> T
    func fetchData<T: Decodable>(from urlString: String, as type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    func fetchData<T: Decodable>(from urlString: String, as type: T.Type) -> AnyPublisher<T, Error>
}

// MARK: - Networking Class
final class NetworkingBootcamp: NetworkingBootcampProtocol {
    
    // Use default URLSession.shared or inject a custom session for testing
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    // MARK: - AsyncAwait Implementation
    func fetchData<T: Decodable>(from urlString: String, as type: T.Type) async throws -> T {
        
        // Check the URL
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        // Make Request
        let (data, response) : (Data, URLResponse)
        do {
            (data, response) = try await urlSession.data(from: url)
        } catch let urlError as URLError {
            // Catch low-level network errors (timeout, offline, host not found...)
            throw NetworkError.networkError(error: urlError)
        } catch {
            // Catch other network errors
            throw NetworkError.networkError(error: error)
        }
        
        // Check HTTP Response
        guard let httpResponse = response as? HTTPURLResponse else {
            // Non-HTTP error (e.g. file://)
            throw NetworkError.invalidResponse(statusCode: 0)
        }
        
        // Status Code Processing
        try handleStatusCode(httpResponse.statusCode)
        
        // Decode data
        do {
            let decodedObject = try self.decodeData(data, to: T.self)
            return decodedObject
        } catch let decodingError {
            throw NetworkError.decodingError(error: decodingError)
        }
    }
    
    // MARK: - Callback/Result Implementation
    func fetchData<T: Decodable>(from urlString: String, as type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        // 1. Check the URL
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        // 2. Create and Run Data Task
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            
            // Closure processing always runs on Background Thread
            
            // A. Low-level Network error handling (timeout, no connection)
            if let error = error {
                let networkError: NetworkError
                if error is URLError {
                    networkError = .networkError(error: error)
                } else {
                    networkError = .networkError(error: error)
                }
                completion(.failure(networkError))
                return
            }
            
            // B. HTTP Response Processing
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse(statusCode: 0)))
                return
            }
            
            // C. Processing Status Code and Data
            do {
                try self.handleStatusCode(httpResponse.statusCode)
                
                guard let data = data else {
                    throw NetworkError.invalidData // Empty data but success status code
                }
                
                // D. Decoding Data
                let decodedObject = try self.decodeData(data, to: T.self)
                completion(.success(decodedObject))
                
            } catch let networkError as NetworkError {
                completion(.failure(networkError))
            } catch let decodingError as DecodingError {
                completion(.failure(NetworkError.decodingError(error: decodingError)))
            } catch {
                completion(.failure(error))
            }
        }
        
        // Start task
        task.resume()
    }
    
    // MARK: - Combine Publisher Implementation
    func fetchData<T: Decodable>(from urlString: String, as type: T.Type) -> AnyPublisher<T, Error> {
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return urlSession.dataTaskPublisher(for: url)
        
            // Handling Response and Error Mapping (mapError/tryMap)
            .tryMap { (data, response) in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse(statusCode: 0)
                }
                
                let statusCode = httpResponse.statusCode
            
                do {
                    try self.handleStatusCode(statusCode)
                } catch {
                    // If Status Code is an error (4xx, 5xx), throw the specific network error
                    throw error
                }
                
                return data
            }
        
            .decode(type: T.self, decoder: JSONDecoder())
        
            // Map Decoding error to NetworkError.decodingError
            .mapError { error -> Error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else if error is DecodingError {
                    return NetworkError.decodingError(error: error)
                } else {
                    return NetworkError.networkError(error: error)
                }
            }
        
            // Convert to AnyPublisher to hide the intrinsic type
            .eraseToAnyPublisher()
    }
    
    /// Logic for handling HTTP status codes.
    private func handleStatusCode(_ statusCode: Int) throws {
        switch statusCode {
        case 200..<300:
            // Success, doing nothing
            break
        case 400..<500:
            throw NetworkError.clientError(statusCode: statusCode)
        case 500..<600:
            throw NetworkError.serverError(statusCode: statusCode)
        default:
            throw NetworkError.unknownError(statusCode: statusCode)
        }
    }
}

extension NetworkingBootcamp {
    private func decodeData<T: Decodable>(_ data: Data, to type: T.Type) throws -> T {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
#if DEBUG
            Logger.shared.debug("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
#endif
            return result
        } catch {
            throw NetworkError.decodingError(error: error)
        }
    }
}


// MARK: - Demo

struct PostModel: Decodable {
    let id: Int
    let title: String
    let body: String
}

// Example of calling:
let networker = NetworkingBootcamp()
let jsonPlaceholderUrl = "https://jsonplaceholder.typicode.com/posts/1"

func loadData() async {
    do {
        // Specify the desired return type: Post.self
        let post = try await networker.fetchData(from: jsonPlaceholderUrl, as: PostModel.self)
        print("Fetched Post Title: \(post.title)")
    } catch {
        if let networkError = error as? NetworkError {
            print("Network Error: \(networkError.localizedDescription)")
        } else {
            print("Unexpected Error: \(error.localizedDescription)")
        }
    }
}

