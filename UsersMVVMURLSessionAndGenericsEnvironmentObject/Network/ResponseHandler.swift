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

protocol ResponseHandler {
    func handleResponse<T: Decodable>(_ response: Response, _ decoder: T.Type, completionBlock: HandlerUser<T>)
}

extension ResponseHandler{
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
            let userDataModel = try JSONDecoder().decode(decoder.self , from: data)
            completionBlock(.success(userDataModel))
        } catch {
            completionBlock(.failure(.decodingError(error)))
            return
        }
    }
}
