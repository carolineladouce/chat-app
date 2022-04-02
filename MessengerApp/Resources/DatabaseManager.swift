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
    
    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
}


// MARK: - Account Management

extension DatabaseManager {
    
    /// Validates whether or not  user with email already exists in database
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        //        safeEmail = safeEmail.replacingOccurrences(of: "#", with: "-")
        //        safeEmail = safeEmail.replacingOccurrences(of: "[", with: "-")
        //        safeEmail = safeEmail.replacingOccurrences(of: "]", with: "-")
        //
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
    }
    
    
    
    /// Inserts new user to database
    public func insertUser(with user: ChatAppUser, completion: @escaping (Bool) -> Void) {
        // When we insert a new user, we make the root entry:
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ], withCompletionBlock: { error, _ in
            guard error == nil else {
                print("FAILED to write to database")
                completion(false)
                return
            }

            /*
             
             We want to create a users array.
             We will store multiple entries for each user
             which will contain their "name" and "safe_email"
             Every time we add a new user, we will create a new entry
             This whole array of users will have one root child pointer
             called "users"
             The reason we are doing this is because
             when the user tries to start a new conversation we can pull out
             all of these users with one request, which will save database costs
             and is considered more "clean"
             
             users => [
             [
             "name":
             "safe_email":
             ],
             [
             "name":
             "safe_email":
             ]
             ]
             
             */
            
            
            /*
             Next, we want to add the entry info we want to add it to our array of users.
             We need to check if the collection exists.
             If it doesn't, we need to create the collection.
             If it does, then we can append the entry
             Once the append is done, we need to call the completion because
             the completion for the whole func of insertUser is NOT finished until
             both of the operations below succeed.
             */
            self.database.child("users").observeSingleEvent(of: .value, with: { snapshot in
                /* We are setting usersCollection to var rather than let because
                 var makes usersCollection mutable so that we can append more contents into
                 */
                if var usersCollection = snapshot.value as? [[String: String]] {
                    // Append to users array
                    let newElement = [
                        "name": user.firstName + " " + user.lastName,
                        "email": user.safeEmail
                    ]
                    usersCollection.append(newElement)
                    
                    self.database.child("users").setValue(usersCollection, withCompletionBlock: { error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        
                        completion(true)
                    })
                    
                    
                } else {
                    // Create the that users array
                    let newCollection: [[String: String]] = [
                        [
                            "name": user.firstName + " " + user.lastName,
                            "email": user.safeEmail
                        ]
                    ] // Close array
                    
                    self.database.child("users").setValue(newCollection, withCompletionBlock: { error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        
                        completion(true)
                    })
                }
            })
            
//            completion(true)
        })
    }
    
    
    public func getAllUsers(completion: @escaping (Result<[[String: String]], Error>) -> Void) {
            self.database.child("users").observeSingleEvent(of: .value, with: { snapshot in
                guard let value = snapshot.value as? [[String: String]] else {
                    completion(.failure(DatabaseError.failedToFetch))
                    return
                }

                completion(.success(value))
            })
        }
        
        enum DatabaseError: Error {
            case failedToFetch
        }
    
    
}


struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    // Not adding a password key-value pair because it is not good practice to store passwords unencrypted
    //        let profilePictureUrl: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    var profilePictureFileName: String {
        // Aiming to return a string that looks like:
        // afraz9-gmail-com_profile_picture.png
        return "\(safeEmail)_profile_picture.png"
    }
}
