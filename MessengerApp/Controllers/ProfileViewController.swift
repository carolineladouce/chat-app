//
//  ProfileViewController.swift
//  MessengerApp
//
//  Created by Caroline LaDouce on 2/9/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileTableView = UITableView()
    var safeArea: UILayoutGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
//        title = "PROFILE"
        
        safeArea = view.layoutMarginsGuide
        
        setupTableView()
    }
    
    
    func setupTableView() {
        view.addSubview(profileTableView)
        
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        profileTableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        profileTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        profileTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
}
