//
//  UserRepository.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 18/01/23.
//

import Foundation


protocol UserRepo {
    func sendRequest<T: Decodable>(_ route: APIAssembleRequest, _ type: T.Type, _ params: Any?..., completionBlock: @escaping (Result<T, NetworkError>) -> Void)
}


/// This class is for handle operations, provide clear distinctions between how app retrieves data and how displays data
/// Is declarated final for more performance of the app, however, is not a good practice if it need  
final class UserRepository: UserRepo {
    
    private let userDatasource: UserData
    
    init (userDatasource: UserData = UserDatasource()){
        self.userDatasource = userDatasource
    }
    
    func sendRequest<T: Decodable>(_ route: APIAssembleRequest, _ type: T.Type, _ params: Any?..., completionBlock: @escaping (Result<T, NetworkError>) -> Void){
        userDatasource.sendRequest(route, type, params, completionBlock: completionBlock)
    }
}
