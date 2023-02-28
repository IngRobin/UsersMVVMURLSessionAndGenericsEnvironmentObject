//
//  ResponseHandler.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 23/01/23.
//

import Foundation

//enum Result<Body> {
//    case success(Body)
//    case failure(NetworkError)
//}

typealias HandlerUser<T: Decodable> = (Result<T, NetworkError>) -> Void


/// Protocol for define operation that handle the response of external API
protocol ResponseHandler {
    func handleResponse<T: Decodable>(_ response: Response, _ decoder: T.Type, completionBlock: HandlerUser<T>)
}

extension ResponseHandler{
    
    /// Function for get the response of external API and decode in a Object, this depends of the decoder parameter
    /// - Parameters:
    ///   - response: Object with the response of external API without decoding
    ///   - decoder: Type of decoder for do this operation and convert the response in a object
    ///   - completionBlock: Closure for send the response with decoded Object
    func handleResponse<T: Decodable>(_ response: Response, _ decoder: T.Type, completionBlock: HandlerUser<T>) {
        if let error = response.error {
            completionBlock(.failure(.transportError(error)))
            return
        }
        if let response = response.response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
            completionBlock(.failure(.serverError(statusCode: response.statusCode)))
            return
        }
        
        guard let data = response.data else {
            completionBlock(.failure(.noData))
            return
        }
        do {
            let userDataModel = try JSONDecoder().decode(decoder.self, from: data)
            completionBlock(.success(userDataModel))
        } catch {
            completionBlock(.failure(.decodingError(error)))
            return
        }
    }
}
