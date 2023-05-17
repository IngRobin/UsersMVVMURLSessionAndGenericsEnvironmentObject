//
//  ServerConstant.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 23/01/23.
//

import Foundation

/// Enum for choise the environment of the app
enum EnvironmentProject {
  case Development
  case Release
}

class AppEnvironment {
    #if DEVELOPMENT
        static let environment: EnvironmentProject = .Development
        static let baseURL: URL = URL(string: "https://gorest.co.in/public/v2/")!
    #elseif RELEASE
       static let environment: EnvironmentProject = .Release
       static let baseURL: URL = URL(string: "https://gorest.co.in/public/v2/")!
    #endif
    
    static let accessToken = "4dfa830ba988219d7ae75b3b267538bbeaba79d2da09afdfa9fba0eed7a59040"

}

var kBearerToken : String {
    let accessToken = AppEnvironment.accessToken
    let token =  "Bearer \(accessToken)"
    return token
}

let numberOfResultsPerPage = 20
