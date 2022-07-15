//
//  LogInViewController.swift
//  Lumiere
//
//  Created by Andy Pang on 2022/7/8.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    var emailFieldLabel = UILabel()
    var emailTextField = UITextField()
    var passwordFieldLabel = UILabel()
    var passwordTextField = UITextField()
    var logInButton = UIButton()
    var signUpStackView = UIStackView()
    var signUpLabel = UILabel()
    var signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background Color")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: UIColor(named: "Text Color")!]
        title = "Log in"

        emailFieldLabel = {
            let label = UILabel()
            label.text = "Email"
            label.numberOfLines = 1
            label.font = Utilities.textFont
            label.textColor = UIColor(named: "Text Color")
            return label
        }()
        
        emailTextField = {
            let textField = UITextField()
            textField.placeholder = "example@example.com"
            textField.autocapitalizationType = .none
            textField.font = Utilities.textFont
            textField.textColor = UIColor(named: "Text Color")
            return textField
        }()
        
        passwordFieldLabel = {
            let label = UILabel()
            label.text = "Password"
            label.numberOfLines = 1
            label.font = Utilities.textFont
            label.textColor = UIColor(named: "Text Color")
            return label
        }()
        
        passwordTextField = {
            let textField = UITextField()
            textField.placeholder = "password"
            textField.autocapitalizationType = .none
            textField.isSecureTextEntry = true
            textField.font = Utilities.textFont
            textField.textColor = UIColor(named: "Text Color")
            return textField
        }()
        
        logInButton = {
            let button = UIButton()
            button.setTitle("Log in", for: .normal)
            button.titleLabel?.font = Utilities.highlightTextFont
            button.setTitleColor(UIColor(named: "Text Color"), for: .normal)
            button.backgroundColor = UIColor(named: "Highlight Color")
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(loginInButtonTapped), for: .touchUpInside)
            return button
        }()
        
        signUpLabel = {
            let label = UILabel()
            label.text = "Don't have an account?"
            label.font = Utilities.commentFont
            label.textColor = UIColor(named: "Text Color")
            return label
        }()
        
        signUpButton = {
            let button = UIButton()
            button.setTitle("Sign Up", for: .normal)
            button.titleLabel?.font = Utilities.highlightCommentFont
            button.setTitleColor(UIColor(named: "Highlight Color"), for: .normal)
            button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
            return button
        }()
        
        signUpStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 5
            return stackView
        }()
        
        signUpStackView.addArrangedSubview(signUpLabel)
        signUpStackView.addArrangedSubview(signUpButton)
        
        [emailFieldLabel, emailTextField, passwordFieldLabel, passwordTextField, logInButton, signUpStackView].forEach{subView in
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
            emailTextField.topAnchor.constraint(equalTo: emailFieldLabel.bottomAnchor, constant: 5),
            emailTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            emailTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            passwordFieldLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50),
            passwordFieldLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordFieldLabel.bottomAnchor, constant: 10),
            passwordTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            passwordTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            logInButton.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            signUpStackView.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 30),
            signUpStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc func signUpButtonTapped() {
        let signUpViewController = SignUpViewController()
        signUpViewController.title = "Sign up"
        let navigationViewController = UINavigationController(rootViewController: signUpViewController)
         
        present(navigationViewController, animated: true, completion: nil)
    }
    
    @objc func loginInButtonTapped() {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (result, error) in
            if (error != nil) {
                Utilities.showAlert(error!.localizedDescription, self)
            }
            else {
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            }
        }
    }
}
