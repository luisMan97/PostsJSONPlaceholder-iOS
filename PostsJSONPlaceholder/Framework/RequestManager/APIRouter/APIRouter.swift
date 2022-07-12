//
//  APIRouter.swift
//  PostsJSONPlaceholder
//
//  Created by Jorge Luis Rivera Ladino on 10/07/22.
//

import Foundation

enum APIRouter {

    case Posts
    case User([String: AnyObject])
    case Comments([String: AnyObject])
    
    private var method: HTTPMethod {
        switch self {
        case .User,
             .Posts,
             .Comments:
            return .GET
        }
    }

    private var path: String {
        switch self {
        case .User(let data):
            let postId = data["postId"] as? Int
            return "users/\(postId ?? -1)"
        case .Posts:
            return "posts"
        case .Comments(let data):
            let postId = data["postId"] as? Int
            return "posts/\(postId ?? -1)/comments"
        }
    }

    private var url: String {
        APIManagerConstants.endpoint
    }

    private var urlRequest: URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = APIManager.defaultHeaders as? [String: String]
        return urlRequest
    }

    private var nsUrlRequest: URLRequest? {
        guard let nsUrl = NSURL(string: self.url + path) else {
            return nil
        }
        var urlRequest = URLRequest(url: nsUrl as URL)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = APIManager.defaultHeaders as? [String: String]
        return urlRequest
    }

    var request: URLRequest? {
        switch self {
        case .User,
             .Comments:
            return nsUrlRequest
        case .Posts:
            return urlRequest
        }
    }

}

