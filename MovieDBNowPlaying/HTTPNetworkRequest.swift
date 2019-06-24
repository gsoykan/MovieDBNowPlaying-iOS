//
//  HTTPNetworkRequest.swift
//  MovieDBNowPlaying
//
//  Created by gurkan soykan on 21.06.2019.
//  Copyright © 2019 gurkan soykan. All rights reserved.
//

import Foundation

public typealias HTTPParameters = [String: Any]?
public typealias HTTPHeaders = [String: Any]?

struct HTTPNetworkRequest {
    
    static func configureHTTPRequest(from route: HTTPNetworkRoute, with parameters: HTTPParameters, includes headers: HTTPHeaders? = nil, contains body: Data? = nil, and method: HTTPMethod) throws -> URLRequest {
        
        guard let url = URL(string: "\(Constants.BASE_API_URL)\(route.rawValue)") else { throw HTTPNetworkError.missingURL}
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = method.rawValue
        request.httpBody = body
        try configureParametersAndHeaders(parameters: parameters, headers: headers, request: &request)
        return request
    }
    
    static func configureParametersAndHeaders(parameters: HTTPParameters?,
                                              headers: HTTPHeaders?,
                                              request: inout URLRequest) throws {
        do {
            if let headers = headers {
                try URLEncoder.setHeaders(for: &request, with: headers)
            }
            if let parameters = parameters {
                try URLEncoder.encodeParameters(for: &request, with: parameters)
            }
        } catch {
            throw HTTPNetworkError.encodingFailed
        }
    }
    
}
