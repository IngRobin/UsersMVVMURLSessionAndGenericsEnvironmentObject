//
//  UpdateUserView.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 19/01/23.
//

import Foundation

import SwiftUI

struct UpdateUserView: View {
    
    
    
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userViewModel : UserViewModel
    
    @State var user: UserModel

    
    var body: some View {
        VStack{
            VStack{
                Text("Nombre")
                    .foregroundColor(Color.black)
                
                TextField("Nombre", text: $user.name ?? "")
                    .frame(maxHeight: 45)
                    .border(Color.gray, width: 0.5)
                    .padding([.horizontal, .bottom, .top], 30)
            }
            VStack{
                Text("Correo")
                    .foregroundColor(Color.black)
                TextField("Correo", text: $user.email ?? "")
                    .frame(maxHeight: 45)
                    .border(Color.gray, width: 0.5)
                    .padding([.horizontal, .bottom, .top], 30)
            }
            VStack{
                Text("Genero")
                    .foregroundColor(Color.black)
                
                TextField("Genero", text: $user.genre ?? "")
                    .frame(maxHeight: 45)
                    .border(Color.gray, width: 0.5)
                    .padding([.horizontal, .bottom, .top], 30)
            }
            
            Button {
                userViewModel.updateUser(user: user)
                dismiss()
            } label: {
                Text("Actualizar")
            }
            Spacer()
        }
//        .onAppear{
//            userRequest.id = user.id
//            userRequest.name = user.name
//            userRequest.email = user.email
//            userRequest.gender = user.genre
//        }
        .alert(isPresented: $userViewModel.alertError) {
            Alert(
                title: Text("Error"),
                message: Text(userViewModel.messageError?.description ?? "Error"),
                primaryButton: .default(
                    Text("Try Again"))
                {
                    userViewModel.updateUser(user: user)
                },
                secondaryButton: .destructive(
                    Text("Cancel")
                )
            )
        }
        
    }
}

//Function for overload operator, this creates a Binding that returns the left side of the operator's value if it's not nil, otherwise it returns the default value from the right side
func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T>{
    Binding(
        get: {lhs.wrappedValue ?? rhs },
        set: {lhs.wrappedValue = $0}
    )
}

