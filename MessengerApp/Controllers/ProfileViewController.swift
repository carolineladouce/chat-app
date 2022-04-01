//
//  ProfileViewController.swift
//  MessengerApp
//
//  Created by Caroline LaDouce on 2/9/22.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

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
        profileTableView.tableHeaderView = createTableHeader()
    }
    
    func createTableHeader() -> UIView? {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return nil
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        let fileName = safeEmail + "_profile_picture.png"
        
        let path = "images/" + fileName
        
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: self.view.width,
                                              height: 300))
        
        headerView.backgroundColor = .link
        
        let imageView = UIImageView(frame: CGRect(x: (view.width - 150) / 2,
                                                  y: 75,
                                                  width: 150,
                                                  height: 150))
        
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = true
        // Set profile imageView frame to be a circle 
        imageView.layer.cornerRadius = imageView.width / 2
        headerView.addSubview(imageView)
        
        StorageManager.shared.downloadURL(for: path, completion: { [weak self] result in
            switch result {
            case .success(let url):
                self?.downloadImage(imageView: imageView, url: url)
            case .failure(let error):
                print("FAILED to get download url: \(error)")
            }
        })
        
        return headerView
    }
    
    
    func downloadImage(imageView: UIImageView, url: URL) {
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                imageView.image = image
            }
        }).resume()
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
        
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { [weak self] _ in
            
            guard let strongSelf = self else {
                return
            }
            
            // Log out facebook
            FBSDKLoginKit.LoginManager().logOut()
            
            // Google log out
            GIDSignIn.sharedInstance.signOut()
            
            do {
                try FirebaseAuth.Auth.auth().signOut()
                
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                strongSelf.present(nav, animated: true)
                
            } catch {
                print("Failed to log out ")
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
        
        
    }
    
    
}




