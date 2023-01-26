//
//  APIRouter.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 21/01/23.
//

import Foundation

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case contentDisposition = "Content-Disposition"
}

enum ContentType: String {
    case json = "application/json"
    case formData = "form-data"
}


/// Enum used for assemble the parts of request for external Http API, the operations has been defined in each case of enum, and the computed variables depend of this
/// This Enum is used in ViewModel in each function and in Datasource with the cas, the computed vars are used
enum APIAssembleRequest {
    case getUsers
    case createUser
    case updateUser(_ id: Int)
    case deleteUser(_ id: Int)
    
    
    /// Computed var for get HTTP verb for d each operation in external API
    var method: HttpMethod {
        switch self {
        case .getUsers:
            return .get
        case .updateUser:
            return .put
        case .deleteUser:
            return .delete
        case .createUser:
            return .post
        }
    }
    
    
    /// Computed var for define the last part of the url request coupling the request with the external API
    /// For some of this options it's neccesary add value from View
    var path: String {
        switch self {
        case .getUsers:
            return "users"
        case .createUser:
            return "users"
        case .updateUser(let id):
            return "users/\(id)"
        case .deleteUser(let id):
            return "users/\(id)"
        }
    }
    
    
    /// Computded var for define headers of request HTTP, this depends of types of operations
    /// Default case is when is not neccesary bearer value in the request
    var headers: [HTTPHeader]? {
        switch self{
        case .createUser, .updateUser, .deleteUser:
            return [HTTPHeader(field: HTTPHeaderField.acceptType.rawValue, value: ContentType.json.rawValue),
                    HTTPHeader(field: HTTPHeaderField.contentType.rawValue, value: ContentType.json.rawValue),
                    HTTPHeader(field: HTTPHeaderField.authentication.rawValue, value: "Bearer \(accessToken)")]
        default:
            return [HTTPHeader(field: HTTPHeaderField.acceptType.rawValue, value: ContentType.json.rawValue),
                    HTTPHeader(field: HTTPHeaderField.contentType.rawValue, value: ContentType.json.rawValue)]
        }
    }
    
    func typeModel<T: Decodable>() -> T {
//        switch self {
//        case .getUsers:
//            return [UserModel].self as! T
//        case .createUser:
//            return UserModel.self  as! T
//        case .updateUser:
//            return UserModel.self  as! T
//        case .deleteUser:
//            return UserModel.self  as! T
//        }
        
        return UserModel.self as! T
    }
    
        
}


