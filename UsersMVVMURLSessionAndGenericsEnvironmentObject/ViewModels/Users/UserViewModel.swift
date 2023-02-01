//
//  UserViewModel.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 18/01/23.
//

import Foundation


/// This class contains the logic of the calls to backend logic , separate the retriving of data and the current state of the UI
/// Is declarated final for more performance of the app, however, is not a good practice if it need 
/// ObservableObject is for bind the data of view and viceverse
final class UserViewModel: ObservableObject {
    
    @Published var users : [UserModel] = []
    @Published var messageError: String?
    @Published var alertError: Bool = false
    
    private let userRepository: UserRepo
    
    init(userRepository: UserRepo = UserRepository()){
        self.userRepository = userRepository
    }
    
    func getUsers(){
        userRepository.sendRequest(.getUsers, [UserModel].self) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.users = users
                case .failure(let error):
                    self?.messageError = error.errorDescription
                    self?.alertError = true
                }
            }
        }
    }
    
    func updateUser(user: UserModel){
        userRepository.sendRequest(.updateUser(user.id), UserModel.self, user) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("OK actualizacion \(String(describing: user.name))")
                case .failure(let error):
                    self?.messageError = error.errorDescription
                    self?.alertError = true
                }
            }
        }
    }
    
}
