//
//  UserDetailView.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 16/05/23.
//

import SwiftUI

struct UserDetailView: View {
    
    var user: UserModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(String(user.id ?? 0))
                .font(.headline)
            Text(user.email ?? "")
                .font(.subheadline)
            NavigationLink {
                UpdateUserView(user: user)
            } label: {
                Text("\(user.name ?? "No name")")
            }
        }
        
        .padding()
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: UserModel())
    }
}
