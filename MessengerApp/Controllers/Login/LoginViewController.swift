//
//  LoginViewController.swift
//  MessengerApp
//
//  Created by Caroline LaDouce on 2/9/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let imageView: UIImageView = {
      let imageView = UIImageView()
//        imageView.image = UIImage(named: "logo")
        imageView.image = "😎".emojiToImage()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        title = "Log In"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        // Add subviews
        view.addSubview(imageView)
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 3
        imageView.frame = CGRect(x: (view.width - size) / 2,
                                 y: 20,
                                 width: size,
                                 height: size)
    }
    
    
    @objc private func didTapRegister(){
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
