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


/// Protocol for define the operations to the external API with Json
protocol RequestHandler {
    func send(request: APIRequest, completion: @escaping APICompletionResponse) -> URLSessionDataTask?
}

extension RequestHandler {
    
    /// Function for make oeprations to the external API with Json
    /// It's designed for  build dynamic request with parameters of the external API
    /// - Parameters:
    ///   - request: Internal Object built with the parameters asked for the external API for build the Json Request
    ///   - completion: closure for obtain and send the response of external API
    /// - Returns: Object Task with the context of the call to external API
    func send(request: APIRequest, completion: @escaping APICompletionResponse) -> URLSessionDataTask? {
        let baseUrl = AppEnvironment.baseURL
        guard let url = URL(string: "\(baseUrl)\(request.path)") else {
            completion(Response(nil, nil, NetworkError.urlError))
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody = request.body
        
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
