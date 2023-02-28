//
//  UserViewModel.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 18/01/23.
//

import Foundation


/// This class contains the logic of the calls to backend logic in functions, separate the retriving of data and the current state of the UI
/// Is declarated final for more performance of the app, however, is not a good practice if it's used for herency
/// ObservableObject is for bind the data of view and viceverse
final class UserViewModel: ObservableObject {
    
    @Published var users : [UserModel] = []
    @Published var messageError: String?
    @Published var alertError: Bool = false
    @Published var alertType : AlertType? = nil
    
    private let userRepository: UserRepo
    private let dispatchQueueType: DispatchQueueType
    
    init(userRepository: UserRepo = UserRepository(), dispatchQueueType: DispatchQueueType = DispatchQueue.main){
        self.userRepository = userRepository
        self.dispatchQueueType = dispatchQueueType
    }
    
    
    /// Function for get users from external API, it's designed for connect with User Repository with the request and handles the response of closure for show the list of users or show alert with error
    func getUsers(){
        userRepository.sendRequest(.getUsers, [UserModel].self) {[weak self] result in
            self?.dispatchQueueType.async {
                switch result {
                case .success(let users):
                    self?.users = users
                case .failure(let error):
                    self?.messageError = error.errorDescription
                    self?.alertError = true
                    self?.alertType = .error
                }
            }
        }
    }
    
    
    /// Function for update one user in external API, it's designed for connect with User Repository with the request  that contains the object of user and handles the response of closure for show updated user or show alert with error
    /// - Parameter user: Object with the updated information for make the request to external API
    func updateUser(user: UserModel){
        userRepository.sendRequest(.updateUser(user.id!), UserModel.self, user) {[weak self] result in
            switch result {
            case .success(let user):
                print("OK actualizacion \(String(describing: user.name))")
            case .failure(let error):
                self?.messageError = error.errorDescription
                self?.alertError = true
                self?.alertType = .error
            }
        }
    }
    
    
    /// Function for create one user in external API, it's designed for connect with User Repository with the request  that contains the object of user and handles the response of closure for show created user or show alert with error
    /// - Parameter user: Object with the new information for make the request to external API
    func createUser(user: UserModel){
        userRepository.sendRequest(.createUser, UserModel.self, user) { [weak self] result in
            switch result {
            case .success(let user):
                print("OK creacion \(String(describing: user.id))")
            case .failure(let error):
                self?.messageError = error.errorDescription
                self?.alertError = true
                self?.alertType = .error
            }
        }
    }
    
    
    /// Function for delete one user in external API, it's designed for connect with User Repository with the request  that contains the object of user and handles the response of closure for show done work or show alert with error
    /// - Parameter user: Object with the information to delete for make the request to external API
    func deleteUser(user: UserModel){
        userRepository.sendRequest(.deleteUser(user.id!), UserModel.self) { [weak self] result in
            switch result {
            case .success(let user):
                print("OK eliminacion \(String(describing: user.name))")
            case .failure(let error):
                self?.messageError = error.errorDescription
                self?.alertError = true
                self?.alertType = .error
            }
        }
    }
}
