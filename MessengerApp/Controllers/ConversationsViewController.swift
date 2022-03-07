//
//  ViewController.swift
//  MessengerApp
//
//  Created by Caroline LaDouce on 2/9/22.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemCyan
        
//        title = "CONVERSATIONS"
        
        
//        
//        let navigationBarAppearance = UINavigationBarAppearance()
//        navigationBarAppearance.configureWithDefaultBackground()
//        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
//        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
//        
//        title = "Log In"
//        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile",
//                                                            style: .done,
//                                                            target: self,
//                                                            action: #selector(didTapProfileButton))
//        
//        loginButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
//            label.center = CGPoint(x: 160, y: 285)
//            label.textAlignment = .center
//            label.text = "I'm a test label"
//
//            self.view.addSubview(label)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateAuth()
    }
    
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
        
    }
    
    
//    @objc func didTapProfileButton() {
//        let vc = ProfileViewController()
//        vc.title = "PROFILE"
//        navigationController?.pushViewController(vc, animated: true)
//    }
//
    
    
}

