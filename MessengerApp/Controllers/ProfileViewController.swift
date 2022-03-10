//
//  ProfileViewController.swift
//  MessengerApp
//
//  Created by Caroline LaDouce on 2/9/22.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let profileTableView = UITableView()
    var safeArea: UILayoutGuide!
    
    var sampleData = ["Log Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(profileTableView)
        profileTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileTableView.frame = view.bounds
    }
    
    func setupTableView() {
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        profileTableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        profileTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        profileTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sampleData[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Cell tapped")
        
        do {
            try FirebaseAuth.Auth.auth().signOut()
            
            
        } catch {
            
        }
    }
    
    
}




