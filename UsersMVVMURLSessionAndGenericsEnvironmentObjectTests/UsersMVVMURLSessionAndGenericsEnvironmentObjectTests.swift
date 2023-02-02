//
//  UsersMVVMURLSessionAndGenericsEnvironmentObjectTests.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObjectTests
//
//  Created by Robinson Gonzalez on 26/01/23.
//

import XCTest
@testable import UsersMVVMURLSessionAndGenericsEnvironmentObject

final class UsersMVVMURLSessionAndGenericsEnvironmentObjectTests: XCTestCase {
    
    var mockUserViewModel: UserViewModel!
    
    override func setUpWithError() throws{
        mockUserViewModel = UserViewModel(userRepository: MockUser())
        
    }
    
    func test_GetUsers(){
        mockUserViewModel.getUsers()
        XCTAssertEqual(mockUserViewModel.users, Bundle.getUsersJson())
    }
    
//    func test_FailGetUsers(){
//        mockUserViewModel = UserViewModel(userRepository:MockUserFail())
//        mockUserViewModel.getUsers()
//        XCTAssertTrue(mockUserViewModel.alertError == false)
//    }
    
    override func tearDownWithError() throws {
        mockUserViewModel = nil
    }
}
