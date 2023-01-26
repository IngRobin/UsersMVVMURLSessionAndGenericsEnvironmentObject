//
//  APIHandler.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 23/01/23.
//

import Foundation

public typealias APICompletionResponse = (Response) -> Void

public struct Response {
    let data: Data?
    let response: URLResponse?
    let error: Error?
    
    init(_ data: Data?, _ response: URLResponse?, _ error: Error?){
        self.data = data
        self.response = response
        self.error = error
    }
}


protocol RequestHandler {
    func send(request: APIRequest, completion: @escaping APICompletionResponse) -> URLSessionDataTask?
}

extension RequestHandler {
    func send(request: APIRequest, completion: @escaping APICompletionResponse) -> URLSessionDataTask? {
        let baseUrl = AppEnvironment.baseURL
        print(baseUrl)
        guard let url = URL(string: "\(baseUrl)\(request.path)") else {
            completion(Response(nil, nil, NetworkError.urlError))
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        
        request.httpHeaders?.forEach({ header in
            urlRequest.addValue(header.value, forHTTPHeaderField: header.field)
        })
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            completion(Response(data, response, error))
        }
        task.resume()
        return task
    }
        
}
