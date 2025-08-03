//
//  NetworkProtocols.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 3/8/25.
//

import Foundation
import Combine

// MARK: - Define HTTP
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// MARK: - Endpoint
protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParameters: [String: String]? { get }
    var headers: [String: String]? { get }
}

// MARK: - NetworkService
protocol NetworkService {
    func fetchData<T: Decodable>(endpoint: Endpoint, responseType: T.Type) async throws -> T
    func fetchData<T: Decodable>(endpoint: Endpoint, responseType: T.Type) -> AnyPublisher<T, Error>
    func fetchData<T: Decodable>(endpoint: Endpoint, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

