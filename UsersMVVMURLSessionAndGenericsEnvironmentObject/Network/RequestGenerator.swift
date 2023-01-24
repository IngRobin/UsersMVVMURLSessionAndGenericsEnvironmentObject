//
//  RequestGenerator.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 23/01/23.
//

import Foundation

protocol RequestGenerator {
    func generateRequest(route: APIAssembleRequest, params: [Any?]?) -> APIRequest
}

extension RequestGenerator{
    func generateRequest(route: APIAssembleRequest, params: [Any?]?) -> APIRequest {
        switch route {
        case .getUsers, .updateUser, .deleteUser:
            var request = APIRequest(httpMethod: route.method, path: route.path)
            request.httpHeaders = route.headers
            return request
        case .createUser:
            let userRequest = params?.first as? UserModel
            var request = APIRequest(httpMethod: route.method, path: route.path, body: userRequest)
            request.httpHeaders = route.headers
            return request
        }
    }
}
