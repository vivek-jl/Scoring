//
//  APIClient.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 26/1/22.
//

import Combine
import Resolver
import Foundation


protocol APIClientType {
    init(
        configuration: URLSessionConfiguration,
        environment: ServerEnvironment
    )
    func change(environment: ServerEnvironment)
    func request<T: Decodable>(
        type: T.Type,
        endpoint: EndpointType
    ) -> AnyPublisher<T, APIError>
}

final class APIClient: APIClientType {
    private let sessionConfiguration: URLSessionConfiguration
    private(set) var environment: ServerEnvironment
    private lazy var urlSession = URLSession(
        configuration: sessionConfiguration,
        delegate: nil,
        delegateQueue: nil
    )
    
    required init(
        configuration: URLSessionConfiguration = Resolver.resolve(),
        environment: ServerEnvironment = Resolver.resolve()
    ) {
        self.sessionConfiguration = configuration
        self.environment = environment
    }
    
    func change(environment: ServerEnvironment) {
        self.environment = environment
    }
    
    func request<T: Decodable>(
        type: T.Type,
        endpoint: EndpointType
    ) -> AnyPublisher<T, APIError> {
        return getData(endpoint: endpoint)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { APIError(from: $0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func getData(endpoint: EndpointType) -> AnyPublisher<Data, APIError> {
        let urlRequest = endpoint.buildRequest(environment)
        return urlSession.dataTaskPublisher(for: urlRequest)
            .tryMap { try self.validate(result: $0) }
            .mapError { APIError(from: $0) }
            .eraseToAnyPublisher()
    }
}

extension APIClient {
    
    func validate(result: URLSession.DataTaskPublisher.Output) throws -> Data {
        let statusCode = (result.response as? HTTPURLResponse)?.statusCode ?? 0
        guard (200 ..< 300).contains(statusCode) else {
            let backendError = APIError.failedRequest(statusCode: statusCode)
            throw backendError
        }
        return result.data
    }
}

