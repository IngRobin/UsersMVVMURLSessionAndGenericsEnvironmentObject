//
//  Alerts.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 23/02/23.
//
import SwiftUI
import Foundation

enum AlertType{
    case success
    case error
}

extension View{
    func getAlert(alertType: AlertType?, action: @escaping () -> Void) -> Alert{
        switch alertType{
        case .success:
            return Alert(title: Text("Operación realizada"))
        case .error:
            return Alert(title: Text("Error en la operación"), dismissButton: .default(Text("Reintentar"), action: action))
        case .none:
            return Alert(title: Text("Error desconocido"))
        }
    }
}
