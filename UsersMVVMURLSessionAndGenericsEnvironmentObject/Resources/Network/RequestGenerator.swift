//
//  RequestGenerator.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 23/01/23.
//

import Foundation


/// Protocol for define operation that build APIRequest with the parameters
protocol RequestGenerator {
    func generateRequest(route: APIAssembleRequest, params: [Any?]?) -> APIRequest
}

extension RequestGenerator{
    
    /// Function for create APIRequest with the sent parameters
    /// - Parameters:
    ///   - route:Parameter of enum type for choise the crud operation
    ///   - params: Optional parameter with the object User for make operations of crud
    /// - Returns: Objet APIRequest with the parameters for create JsonRequest
    func generateRequest(route: APIAssembleRequest, params: [Any?]?) -> APIRequest {
        switch route {
        case .getUsers, .deleteUser:
            var request = APIRequest(httpMethod: route.method, path: route.path)
            request.httpHeaders = route.headers
            return request
        case .createUser, .updateUser:
            let userRequest = params?.first as? UserModel
            var request = APIRequest(httpMethod: route.method, path: route.path, body: userRequest)
            request.httpHeaders = route.headers
            return request
        }
    }
}
