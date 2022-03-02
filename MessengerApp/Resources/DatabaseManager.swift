//
//  DatabaseManager.swift
//  MessengerApp
//
//  Created by Caroline LaDouce on 2/26/22.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}


// MARK: - Account Management

extension DatabaseManager {
    
    /// Validates whether or not  user with email already exists in database
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
    }
    
    /// Inserts new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.emailAddress).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}


struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    // Not adding a password key-value pair because it is not good practice to store passwords unencrypted
    //        let profilePictureUrl: String
}
