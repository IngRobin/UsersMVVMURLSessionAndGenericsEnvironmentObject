//
//  UsersMVVMURLSessionAndGenericsEnvironmentObjectApp.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 18/01/23.
//

import SwiftUI

@main
struct UsersMVVMURLSessionAndGenericsEnvironmentObjectApp: App {
    var body: some Scene {
        WindowGroup {
            HomeUserView().environmentObject(UserViewModel())
        }
    }
}
