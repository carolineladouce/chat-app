//
//  AppDelegate.swift
//  MessengerApp
//
//  Created by Caroline LaDouce on 2/9/22.
//

import UIKit
import Firebase
import FBSDKCoreKit
import GoogleSignIn
//import FBSDKLoginKit
//import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        FirebaseApp.configure()
//
//        ApplicationDelegate.shared.application(
//            application,
//            didFinishLaunchingWithOptions: launchOptions
//        )
        
        return true
   
    }
    
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    
//    func application(
//        _ app: UIApplication,
//        open url: URL,
//        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
//    ) -> Bool {
//        ApplicationDelegate.shared.application(
//            app,
//            open: url,
//            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
//        )
//
//        return GIDSignIn.sharedInstance.handle(url)
//    }
//
//
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        guard error == nil else {
//            if let error = error {
//                print("Failed to sign in with Google. ERROR: \(error)")
//            }
//            return
//        }
//
//        print("Did sign in with Google: \(user)")
//
//        guard let email = user.profile.email,
//              let firstName = user.profile?.givenName,
//              let lastName = user.profile?.familyName else {
//            return
//        }
//
//        DatabaseManager.shared.userExists(with: email, completion: { exists in
//            if !exists {
//                // insert user into database
//                DatabaseManager.shared.insertUser(with: ChatAppUser(firstName: firstName, lastName: lastName, emailAddress: email))
//            }
//        })
//
//        guard let authentication = user.authentication else {
//            print("Missing auth object off of google user")
//            return
//
//        }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
//
//        FirebaseAuth.Auth.auth().signIn(with: credential, completion: { AuthResult, error in
//            guard AuthResult != nil, error == nil else {
//                print("Failed to log in with Google credential")
//                return
//            }
//
//            print("Successfully signed in with Google credential")
//        })
//    }
//
//
//    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
//        print("Google user was disconnected")
//    }
//
//
}





