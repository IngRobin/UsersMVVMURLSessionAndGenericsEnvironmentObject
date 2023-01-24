//
//  UserRepository.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 18/01/23.
//

import Foundation


/// This class is for handle operations, provide clear distinctions between how app retrieves data and how displays data
/// Is declarated final for more performance of the app, however, is not a good practice if it need  
final class UserRepository {
    
    private let userDatasource: UserDatasource
    
    init (userDatasource: UserDatasource = UserDatasource()){
        self.userDatasource = userDatasource
    }
    
    func sendRequest<T: Decodable>(_ route: APIAssembleRequest, _ type: T.Type, _ params: Any?..., completionBlock: @escaping (Result<T, NetworkError>) -> Void){
        userDatasource.sendRequest(route, type, params, completionBlock: completionBlock)
    }
}
