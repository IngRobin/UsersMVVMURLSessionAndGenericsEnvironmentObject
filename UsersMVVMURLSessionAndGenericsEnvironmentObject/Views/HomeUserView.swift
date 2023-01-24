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
                List($userViewModel.users, id: \.id){
                    $user in
                    NavigationLink {
                        UpdateUserView(user: user)
                    } label: {
                        Text("\(user.name ?? "No name")")
                    }
                }
            }
            .navigationTitle("Usuarios")
        }
        .onAppear{
            userViewModel.getUsers()
        }
        .alert(isPresented: $userViewModel.alertError) {
            Alert(
                title: Text("Error"),
                message: Text(userViewModel.messageError?.description ?? "Error"),
                primaryButton: .default(
                    Text("Try Again"),
                    action: userViewModel.getUsers
                ),
                secondaryButton: .destructive(
                    Text("Cancel")
                )
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeUserView().environmentObject(UserViewModel())
    }
}
