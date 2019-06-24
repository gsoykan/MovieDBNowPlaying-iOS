//
//  NetworkService.swift
//  MovieDBNowPlaying
//
//  Created by gurkan soykan on 21.06.2019.
//  Copyright © 2019 gurkan soykan. All rights reserved.
//

import Foundation

struct NetworkService{
    
    static let shared = NetworkService()
    let postSession = URLSession(configuration: .default)
    let baseParameters = [ Constants.API_QUERY_KEY: Constants.API_KEY ]
    // NOTE : NOT ALL Request requires parameters. You can pass nil in the configureHTTPRequest() method for the parameter argument.
    func get<T:Codable>(route: HTTPNetworkRoute, params: HTTPParameters = [:],  _ completion: @escaping (Result<T>) -> ()) {
        do{
            var newParams = params
            newParams?.merge(baseParameters){ (current, _) in current }
            let request = try HTTPNetworkRequest.configureHTTPRequest(from: route, with: newParams, contains: nil, and: .get)
            debugPrint(request)
            postSession.dataTask(with: request) { (data, res, err) in
                
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    
                    switch result {
                    case .success:
                        do{
                             let result = try JSONDecoder().decode(T.self, from: unwrappedData)
                             completion(Result.success(result))
                        }catch{
                            print(error)
                            completion(Result.failure(error))
                        }
                    case .failure:
                        completion(Result.failure(HTTPNetworkError.decodingFailed))
                    }
                }
                }.resume()
        }catch{
            completion(Result.failure(HTTPNetworkError.badRequest))
        }
    }
}
