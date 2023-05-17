//
//  UserDatasource.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 18/01/23.
//

import Foundation

/// Protocol for define the operations of UserDatasource for being used in class, this is a good practice with POP
protocol UserData {
    func sendRequest<T: Decodable>(_ route: APIAssembleRequest, _ type: T.Type, _ params: Any?..., completionBlock: @escaping HandlerUser<T>)
}


/// This class contains the logic for process request and organice data of users with external api, simplifies data binding making loading, paging, filtering and saving data easier
/// Is declarated final for more performance of the app
/// Have only one generic operation that handles getUser, updateUser, deleteUser, and createUser from UserRepository
final class UserDatasource: UserData, RequestGenerator, RequestHandler, ResponseHandler {
    
    
    /// Function designed for obtain the parameters of UserRepository and make CRUD operations with the use of generics functions for make the request, send the request, and handle response
    /// - Parameters:
    ///   - route:Parameter of enum type for choise the crud operation
    ///   - type: It's neccesary for the business logic for handle the response according to the operation
    ///   - params: Optional parameter with the object User for make operations of crud
    ///   - completionBlock: Closure for retrieve the response of operation, and send to UserRepository
    func sendRequest<T: Decodable>(_ route: APIAssembleRequest, _ type: T.Type, _ params: Any?..., completionBlock: @escaping HandlerUser<T>){
        let request = self.generateRequest(route: route, body: params)
        _ = self.send(request: request) { response in
            self.handleResponse(response, type, completionBlock: completionBlock)
        }
        
    }
}
