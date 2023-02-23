//
//  APIRequest.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 21/01/23.
//

import Foundation


/// Struct for assemble the request and response when calls external API with Json
struct APIRequest {
    let httpMethod: HttpMethod
    let path: String
    var queryItems: [URLQueryItem]?
    var httpHeaders: [HTTPHeader]?
    var body: Data?
    
    init(httpMethod: HttpMethod, path: String) {
        self.httpMethod = httpMethod
        self.path = path
    }
    
    init<Body: Codable>(httpMethod: HttpMethod, path: String, body: Body){
        self.httpMethod = httpMethod
        self.path = path
        self.body = try? JSONEncoder().encode(body)
    }
}
