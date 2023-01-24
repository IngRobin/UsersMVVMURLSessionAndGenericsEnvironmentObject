//
//  UserRequestModel.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 19/01/23.
//

import Foundation

struct UserRequestModel : Codable {
    var id : Int?
    var name : String?
    var gender : String?
    var email : String?
    var status : String?

    init(id : Int? = nil, name : String? = nil, gender : String? = nil, email : String? = nil, status : String? = nil) {
        self.id = id
        self.name = name
        self.gender = gender
        self.email = email
        self.status = status
    }
}
