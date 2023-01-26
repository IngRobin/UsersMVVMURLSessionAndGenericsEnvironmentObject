//
//  UserDatasource.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 18/01/23.
//

import Foundation

protocol UserData {
    func sendRequest<T: Decodable>(_ route: APIAssembleRequest, _ type: T.Type, _ params: Any?..., completionBlock: @escaping HandlerUser<T>)
}


/// This class contains the logic for process request and organice data of users with external api, simplifies data binding making loading, paging, filtering and saving data easier
/// Is declarated final for more performance of the app, however, is not a good practice if it need 
final class UserDatasource: UserData, RequestGenerator, RequestHandler, ResponseHandler {
    
    func sendRequest<T: Decodable>(_ route: APIAssembleRequest, _ type: T.Type, _ params: Any?..., completionBlock: @escaping HandlerUser<T>){
        
        let request = self.generateRequest(route: route, params: params)
        _ = self.send(request: request) { response in
            self.handleResponse(response, type, completionBlock: completionBlock)
        }
    }    
}
