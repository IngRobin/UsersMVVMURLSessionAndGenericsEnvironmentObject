//
//  HomeView.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 18/01/23.
//

import SwiftUI

struct HomeUserView: View {
    
    @EnvironmentObject var userViewModel : UserViewModel
    
    var body: some View {
        NavigationView{
            VStack{
                //                List($userViewModel.users, id: \.id){
                //                    $user in
                //                    NavigationLink {
                //                        UpdateUserView(user: user)
                //                    } label: {
                //                        Text("\(user.name ?? "No name")")
                //                    }
                //                }
                
                List(userViewModel.users) { user in
                    UserDetailView(user: user)
                        .onAppear {
                            userViewModel.getUsers(user)
                        }
                }
                
            }
            .navigationTitle("Usuarios")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        NavigationLink(destination: CreateUserView()) {
                            Image(systemName: "plus")
                            
                        }
                    }
                    
                }
                
            }
        }
        //        .onAppear{
        //            userViewModel.getUsers()
        //        }
        .alert(isPresented: $userViewModel.alertError) {
            getAlert(alertType: userViewModel.alertType) {
                userViewModel.getUsers()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeUserView().environmentObject(UserViewModel())
    }
}
