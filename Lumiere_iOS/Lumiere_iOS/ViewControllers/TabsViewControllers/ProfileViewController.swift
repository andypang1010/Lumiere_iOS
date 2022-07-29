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
        view.backgroundColor = UIColor(named: "Background Color")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: UIColor(named: "Text Color")!]
        title = "Profile"
        
        emailLabel = {
            let label = UILabel()
            label.text = Auth.auth().currentUser?.email
            label.numberOfLines = 1
            label.font = Utilities.highlightTextFont
            label.textColor = UIColor(named: "Text Color")
            return label
        }()
        
        uidLabel = {
            let label = UILabel()
            label.text = "UID: \(Auth.auth().currentUser!.uid)"
            label.numberOfLines = 1
            label.font = Utilities.commentFont
            label.textColor = UIColor(named: "Text Color")
            return label
        }()
        
        logOutButton = {
          let button = UIButton()
            button.setTitle("Log out", for: .normal)
            button.titleLabel?.font = Utilities.highlightTextFont
            button.setTitleColor(UIColor(named: "Text Color"), for: .normal)
            button.backgroundColor = UIColor(named: "Highlight Color")
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
            return button
        }()
        
        [emailLabel, uidLabel, logOutButton].forEach{subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
        
        setUpConstraints()
        
        // Code goes here...
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
            logOutButton.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
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
