//
//  RequestGenerator.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 23/01/23.
//

import Foundation


/// Protocol for define operation that build APIRequest with the parameters
protocol RequestGenerator {
    func generateRequest(route: APIAssembleRequest, body: [Any?]?) -> APIRequest
}

extension RequestGenerator{
    
    /// Function for create APIRequest with the sent parameters
    /// - Parameters:
    ///   - route:Parameter of enum type for choise the crud operation
    ///   - params: Optional parameter with the object User for make operations of crud
    /// - Returns: Objet APIRequest with the parameters for create JsonRequest
    func generateRequest(route: APIAssembleRequest, body: [Any?]?) -> APIRequest {
        switch route {
        case .getUsers:
            var request = APIRequest(httpMethod: route.method, path: route.path)
            request.queryItems = [URLQueryItem(name: "per_page", value: String(numberOfResultsPerPage)), URLQueryItem(name: "page", value: String(body?.first as? Int ?? 1))]
            request.httpHeaders = route.headers
            return request
        case .deleteUser:
            var request = APIRequest(httpMethod: route.method, path: route.path)
            request.httpHeaders = route.headers
            return request
        case .createUser, .updateUser:
            var request = APIRequest(httpMethod: route.method, path: route.path, body: body?.first as? UserModel)
            request.httpHeaders = route.headers
            return request
        }
    }
}
