//
//  LogInViewController.swift
//  Lumiere
//
//  Created by Andy Pang on 2022/7/8.
//

import UIKit

class LogInViewController: UIViewController {
    
    let titleFont = UIFont(name: "Avenir Black", size: 40)!
    let textFont = UIFont(name: "Avenir Next", size: 20)!
    let commentFont = UIFont(name: "Avenir Next", size: 10)!
    
    var emailFieldLabel = UILabel()
    var emailTextField = UITextField()
    var passwordFieldLabel = UILabel()
    var passwordTextField = UITextField()
    var loginButton = UIButton()
    var signUpLabel = UILabel()
    var signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background Color")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: titleFont, NSAttributedString.Key.foregroundColor: UIColor(named: "Highlight Color")!]
        title = "Log in"

        
        emailFieldLabel = {
            let label = UILabel()
            label.text = "Email"
            label.numberOfLines = 1
            label.font = textFont
            label.textColor = UIColor(named: "Text Color")
            return label
        }()
        
        emailTextField = {
            let textField = UITextField()
            textField.placeholder = "example@example.com"
            textField.font = textFont
            textField.textColor = UIColor(named: "Text Color")
            return textField
        }()
        
        passwordFieldLabel = {
            let label = UILabel()
            label.text = "Password"
            label.numberOfLines = 1
            label.font = textFont
            label.textColor = UIColor(named: "Text Color")
            return label
        }()
        
        passwordTextField = {
            let textField = UITextField()
            textField.placeholder = "password"
            textField.isSecureTextEntry = true
            textField.font = textFont
            textField.textColor = UIColor(named: "Text Color")
            return textField
        }()
        
        loginButton = {
            let button = UIButton()
            button.setTitle("Log in", for: .normal)
            button.titleLabel?.font = textFont
            button.setTitleColor(UIColor(named: "Text Color"), for: .normal)
            button.backgroundColor = UIColor(named: "Box Color")
            button.layer.cornerRadius = 10
            return button
        }()
        
        signUpLabel = {
            let label = UILabel()
            label.text = "Don't have an account?"
            label.font = textFont
            label.textColor = UIColor(named: "Text Color")
            return label
        }()
        
        signUpButton = {
            let button = UIButton()
            button.setTitle("Sign Up", for: .normal)
            button.titleLabel?.font = textFont
            button.titleLabel?.textColor = UIColor(named: "Highlight Color")
            button.addTarget(self, action: #selector(presentSignUpViewController), for: .touchUpInside)
            return button
        }()
        
        [emailFieldLabel, emailTextField, passwordFieldLabel, passwordTextField, loginButton, signUpLabel, signUpButton].forEach{subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }

        setUpConstraints()
        
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            emailFieldLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            emailFieldLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: emailFieldLabel.bottomAnchor, constant: 10),
            emailTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            emailTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            passwordFieldLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50),
            passwordFieldLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordFieldLabel.bottomAnchor, constant: 10),
            passwordTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            passwordTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            loginButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
        ])
    }

    @objc func presentSignUpViewController() {
        present(SignUpViewController(), animated: true, completion: nil)
    }
}

