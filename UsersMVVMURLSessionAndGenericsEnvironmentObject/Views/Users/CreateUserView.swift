//
//  CreateUserView.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 9/02/23.
//

import SwiftUI

struct CreateUserView: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var userModel = UserModel()
    
    var body: some View {
        VStack{
            
            VStack{
                Text("Nombre")
                TextField("Nombre", text: $userModel.name ?? "")
                    .frame(maxHeight: 45)
                    .border(Color.gray, width: 0.5)
                    .padding([.horizontal, .bottom, .top], 30)
            }
            VStack{
                Text("Correo")
                TextField("Correo", text: $userModel.email ?? "")
                    .frame(maxHeight: 45)
                    .border(Color.gray, width: 0.5)
                    .padding([.horizontal, .bottom, .top], 30)
            }
            VStack{
                Text("Genero")
                TextField("Genero", text: $userModel.genre ?? "")
                    .frame(maxHeight: 45)
                    .border(Color.gray, width: 0.5)
                    .padding([.horizontal, .bottom, .top], 30)
            }
            
            VStack{
                Text("Estado")
                TextField("Estado", text: $userModel.status ?? "")
                    .frame(maxHeight: 45)
                    .border(Color.gray, width: 0.5)
                    .padding([.horizontal, .bottom, .top], 30)
            }
            Button {
                userViewModel.createUser(user: userModel)
                dismiss()
            } label: {
                Text("Crear")
            }
            

        }
    }
}

struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView()
    }
}
