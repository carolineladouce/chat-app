//
//  TabBarController.swift
//  MessengerApp
//
//  Created by Caroline LaDouce on 3/6/22.
//

import UIKit

class TabBarController: UITabBarController {
    
    let conversationsViewController = ConversationsViewController()
    let profileViewController = ProfileViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
                view.backgroundColor = .systemGray
                UITabBar.appearance().barTintColor = .systemGray
        UITabBar.appearance().backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        
        setupViewControllers()
        
        
    }
    
    
    func setupViewControllers() {
        viewControllers = [
            templateNavigationController(for: conversationsViewController, title: "CONVERSATIONS"),
            templateNavigationController(for: profileViewController, title: "PROFILE")
            
//            conversationsViewController,
//            profileViewController
            
        ]
    }
    
    
    func templateNavigationController(for rootViewController: UIViewController,
                                      title: String) -> UIViewController {
       let rViewController = rootViewController
//        let navigationController = UINavigationController(rootViewController: rootViewController)
//        navigationController.tabBarItem.title = title
        //        navigationController.tabBarItem.image = image
        //        navigationController.navigationBar.prefersLargeTitles = true
        //        rootViewController.navigationItem.title = title
        
        rootViewController.tabBarItem.title = title
//        return navigationController
        return rViewController
    }
    
    
}
