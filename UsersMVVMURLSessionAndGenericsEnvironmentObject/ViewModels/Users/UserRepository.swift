//
//  UserRepository.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 18/01/23.
//

import Foundation


/// Protocol for define the operations of UserRepository for being used in class, this is a good practice with POP
protocol UserRepo {
    func sendRequest<T: Decodable>(_ route: APIAssembleRequest, _ type: T.Type, _ params: Any?..., completionBlock: @escaping (Result<T, NetworkError>) -> Void)
}


/// This class is for handle operations, provide clear distinctions between how app retrieves data and how displays data
/// Is declarated final for more performance of the app
/// Have only one generic operation that handles getUser, updateUser, deleteUser, and createUser from ViewModel
/// It's connected with userDatasourse through protocol userData
final class UserRepository: UserRepo {
    
    private let userDatasource: UserData
    
    init (userDatasource: UserData = UserDatasource()){
        self.userDatasource = userDatasource
    }
    
    
    /// Function for handle CRUD operations from User ViewModel  through generics
    /// It's designed for call operation of UserDatasource, and send the response to ViewModel
    /// - Parameters:
    ///   - route:Parameter of enum type for choise the crud operation
    ///   - type: It's neccesary for the business logic for handle the response according to the operation
    ///   - params: Optional parameter with the object User for make operations of crud
    ///   - completionBlock: Closure for retrieve the response of operation, and send to ViewModel
    func sendRequest<T: Decodable>(_ route: APIAssembleRequest, _ type: T.Type, _ params: Any?..., completionBlock: @escaping (Result<T, NetworkError>) -> Void){
        userDatasource.sendRequest(route, type, params, completionBlock: completionBlock)
    }
}
