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
        DispatchQueue.main.async {
            let fakeQueue = DispatchQueueFake()
            self.mockUserViewModel = UserViewModel(userRepository: MockUser(), dispatchQueueType: fakeQueue)
            self.mockUserViewModel.getUsers()
            XCTAssertEqual(self.mockUserViewModel.users, Bundle.getUsersJson())
        }
    }
    
    func test_FailGetUsers(){
        DispatchQueue.main.async {
            let fakeQueue = DispatchQueueFake()
            self.mockUserViewModel = UserViewModel(userRepository:MockUserFail(), dispatchQueueType: fakeQueue)
            self.mockUserViewModel.getUsers()
            XCTAssertTrue(self.mockUserViewModel.alertError == true)
        }
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
