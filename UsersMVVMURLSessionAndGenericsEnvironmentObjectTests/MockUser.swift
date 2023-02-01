//
//  MockUser.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObjectTests
//
//  Created by Robinson Gonzalez on 31/01/23.
//

import Foundation
@testable import UsersMVVMURLSessionAndGenericsEnvironmentObject


final class MockUser: UserRepo {
    
    func sendRequest<T>(_ route: UsersMVVMURLSessionAndGenericsEnvironmentObject.APIAssembleRequest, _ type: T.Type, _ params: Any?..., completionBlock: @escaping (Result<T, UsersMVVMURLSessionAndGenericsEnvironmentObject.NetworkError>) -> Void) where T : Decodable {
        completionBlock(.success(decodeData(route: route)))
    }
    
    func decodeData<T:Decodable>(route: APIAssembleRequest) -> T{
        let bundlePath = Bundle.main.path(forResource: "Stub", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        switch route {
        case .getUsers:
            return bundle!.decode([UserModel].self, from: "Users.json") as! T
        default:
            return bundle!.decode(UserModel.self, from: "Users.json") as! T
        }
        
    }
}

final class MockUserFail: UserRepo {
    func sendRequest<T>(_ route: UsersMVVMURLSessionAndGenericsEnvironmentObject.APIAssembleRequest, _ type: T.Type, _ params: Any?..., completionBlock: @escaping (Result<T, UsersMVVMURLSessionAndGenericsEnvironmentObject.NetworkError>) -> Void) where T : Decodable {
        completionBlock(.failure(.encodingError))
    }
}
