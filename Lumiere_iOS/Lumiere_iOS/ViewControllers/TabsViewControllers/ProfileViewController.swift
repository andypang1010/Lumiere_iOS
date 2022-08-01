//
//  ProfileViewController.swift
//  Lumiere_iOS
//
//  Created by Andy Pang on 2022/7/15.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ProfileViewController : UIViewController {

    var emailLabel = UILabel()
    var uidLabel = UILabel()
    var logOutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Utilities.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = Utilities.backgroundColor
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: Utilities.textColor!]
        title = "Profile"
        
        emailLabel = {
            let label = UILabel()
            label.text = Auth.auth().currentUser?.email
            label.numberOfLines = 1
            label.font = Utilities.largeFont
            label.textColor = Utilities.textColor
            return label
        }()
        
        uidLabel = {
            let label = UILabel()
            label.text = "UID: \(Auth.auth().currentUser!.uid)"
            label.numberOfLines = 1
            label.font = Utilities.commentFont
            label.textColor = Utilities.textColor
            return label
        }()
        
        logOutButton = {
          let button = UIButton()
            button.setTitle("Log out", for: .normal)
            button.titleLabel?.font = Utilities.highlightTextFont
            button.setTitleColor(Utilities.textColor, for: .normal)
            button.backgroundColor = Utilities.highlightColor
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
            return button
        }()
        
        Utilities.addViews([emailLabel, uidLabel, logOutButton], view)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            uidLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            uidLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            logOutButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    // Sign out of the current user and return to the Log In view controller
    @objc func logOutButtonTapped() {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError {
            Utilities.showAlert(signOutError.localizedDescription, self)
        }
        self.navigationController?.pushViewController(LogInViewController(), animated: true)
    }
}
