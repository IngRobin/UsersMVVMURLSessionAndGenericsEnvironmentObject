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
        
        
    }
    
    func test_GetUsers(){
        let fakeQueue = DispatchQueueFake()
        mockUserViewModel = UserViewModel(userRepository: MockUser(), dispatchQueueType: fakeQueue)
        mockUserViewModel.getUsers()
        XCTAssertEqual(mockUserViewModel.users, Bundle.getUsersJson())
    }
    
    func test_FailGetUsers(){
        let fakeQueue = DispatchQueueFake()
        mockUserViewModel = UserViewModel(userRepository:MockUserFail(), dispatchQueueType: fakeQueue)
        mockUserViewModel.getUsers()
        XCTAssertTrue(mockUserViewModel.alertError == true)
    }
    
    override func tearDownWithError() throws {
        mockUserViewModel = nil
    }
}

final class DispatchQueueFake: DispatchQueueType {
    func async(execute work: @escaping @convention(block) () -> Void) {
        work()
    }
}
