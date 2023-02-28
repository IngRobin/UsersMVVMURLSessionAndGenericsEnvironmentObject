//
//  Queues.swift
//  UsersMVVMURLSessionAndGenericsEnvironmentObject
//
//  Created by Robinson Gonzalez on 23/02/23.
//

import Foundation


/// Protocol for make alternative DispatchQueue using dependency injection
protocol DispatchQueueType {
    func async(execute work: @escaping @convention(block) () -> Void)
}


extension DispatchQueue: DispatchQueueType {
    /// Function arranged to create a DispatchQueue
    /// - Parameter work: Action that DispatchQueue execute
    func async(execute work: @escaping @convention(block) () -> Void) {
        async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}
