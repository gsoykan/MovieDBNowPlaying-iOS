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
    
    /// Set the body, method, headers, and paramaters of the request
    static func configureHTTPRequest(from route: HTTPNetworkRoute, with parameters: HTTPParameters, includes headers: HTTPHeaders? = nil, contains body: Data? = nil, and method: HTTPMethod) throws -> URLRequest {
        
        guard let url = URL(string: "\(Constants.BASE_API_URL)\(route.rawValue)") else { throw HTTPNetworkError.missingURL}
        
        /*
         *** NOTES ABOUT REQUEST ***
         
         * You can use the simple initializer if you'd like:
         var request = URLRequest(url: url)
         * The timeoutInterval argument tells URLSession the amount of time(in seconds) to wait for a response from the server
         * When Making a GET request, we don't pass anything in the body
         * You can cmd+click on each method and parameter to learn more about them.
         */
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = method.rawValue
        request.httpBody = body
        try configureParametersAndHeaders(parameters: parameters, headers: headers, request: &request)
        
        return request
    }
    
    /// Configure the request parameters and headers before the API Call
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
