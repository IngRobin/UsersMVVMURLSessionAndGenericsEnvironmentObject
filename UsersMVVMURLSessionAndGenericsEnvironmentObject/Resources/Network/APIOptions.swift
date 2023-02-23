//
//  APIOptions.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 21/01/23.
//

import Foundation


/// Enum declared with operation in external API with JSON, used in APIRequest for assemble request and response
enum HttpMethod: String {
    case get = "GET"
    case head = "HEAD"
    case delete = "DELETE"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case trace = "TRACE"
}


/// This enum contains the field and value if the request of APIRequest needs send Headers
struct HTTPHeader {
    let field: String
    let value: String
}
