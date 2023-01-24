//
//  UserModel.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 18/01/23.
//

import Foundation

//Example of model

//[
//    {
//        "id": 3494,
//        "name": "Vidur Gowda",
//        "email": "gowda_vidur@hartmann.net",
//        "gender": "female",
//        "status": "active"
//    },
//    {
//        "id": 3493,
//        "name": "Deb Kakkar",
//        "email": "deb_kakkar@bailey.biz",
//        "gender": "female",
//        "status": "inactive"
//    },
//    {
//        "id": 3491,
//        "name": "Sucheta Reddy",
//        "email": "reddy_sucheta@murphy.org",
//        "gender": "male",
//        "status": "inactive"
//    },
//    {
//        "id": 3490,
//        "name": "Durgeshwari Kaur",
//        "email": "durgeshwari_kaur@abshire-dach.io",
//        "gender": "female",
//        "status": "inactive"
//    },
//
//]


/// Struct for set model of User from URL
/// Only in the property gender has different name
struct UserModel: Decodable, Encodable {
    var id: Int
    var name: String?
    var email: String?
    var genre: String?
    var status: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case genre = "gender"
        case status
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
        self.genre = try container.decode(String.self, forKey: .genre)
        self.status = try container.decode(String.self, forKey: .status)
    }
}

