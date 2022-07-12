//
//  APIManager.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 10/07/22.
//

import Foundation
import Combine

class APIManager {

    static var defaultHeaders: NSMutableDictionary = [
        "Content-Type": "application/json"
    ]

}

// MARK: - Data Request Methods
extension APIManager {

    static func request<T: Decodable>(service: APIRouter) -> AnyPublisher<T, Error> {
        guard let request = service.request else {
            let error = NSError(domain: "error", code: 404, userInfo: [NSLocalizedDescriptionKey: "Bad URL"])
            return Fail(error: error).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: RunLoop.main)
            .map { (data: Data, response: URLResponse) in
                guard let response = String(data: data, encoding: .utf8) else { return data }
                print(response)
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    static func asyncRequest<T: Decodable>(service: APIRouter) async throws -> T {
        guard let request = service.request else {
            let error = NSError(domain: "error", code: 404, userInfo: [NSLocalizedDescriptionKey: "Bad URL"])
            throw error
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            let error = NSError(domain: "error", code: 0, userInfo: [NSLocalizedDescriptionKey: "StatusCode error"])
            throw error
        }
        guard statusCode == 200 else {
            let error = NSError(domain: "error", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "\(statusCode)"])
            throw error
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

}
