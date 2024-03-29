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
        view.backgroundColor = Utilities.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = Utilities.backgroundColor
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: Utilities.textColor]
        title = "Log In"

        // Disable moving back to login/sign-up screen
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false;
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = false;
        
        // Hides the tab bar
        self.tabBarController?.tabBar.isHidden = true
        
        emailFieldLabel = {
            let label = UILabel()
            label.text = "Email"
            label.numberOfLines = 1
            label.font = Utilities.highlightTextFont
            label.textColor = Utilities.textColor
            return label
        }()
        
        emailTextField = {
            let textField = UITextField()
            textField.placeholder = "Enter your email"
            textField.autocapitalizationType = .none
            textField.font = Utilities.textFont
            textField.textColor = Utilities.textColor
            textField.delegate = self
            textField.keyboardType = UIKeyboardType.emailAddress
            textField.returnKeyType = .continue
            return textField
        }()
        
        passwordFieldLabel = {
            let label = UILabel()
            label.text = "Password"
            label.numberOfLines = 1
            label.font = Utilities.highlightTextFont
            label.textColor = Utilities.textColor
            return label
        }()
        
        passwordTextField = {
            let textField = UITextField()
            textField.placeholder = "Enter your password"
            textField.autocapitalizationType = .none
            textField.isSecureTextEntry = true
            textField.font = Utilities.textFont
            textField.textColor = Utilities.textColor
            textField.delegate = self
            textField.returnKeyType = .done
            return textField
        }()
        
        logInButton = {
            let button = UIButton()
            button.setTitle("Log in", for: .normal)
            button.titleLabel?.font = Utilities.highlightTextFont
            button.setTitleColor(Utilities.textColor, for: .normal)
            button.backgroundColor = Utilities.highlightColor
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
            return button
        }()
        
        signUpLabel = {
            let label = UILabel()
            label.text = "Don't have an account?"
            label.font = Utilities.commentFont
            label.textColor = Utilities.textColor
            return label
        }()
        
        signUpButton = {
            let button = UIButton()
            button.setTitle("Sign Up", for: .normal)
            button.titleLabel?.font = Utilities.highlightCommentFont
            button.setTitleColor(Utilities.highlightColor, for: .normal)
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
        
        Utilities.addViews([emailFieldLabel, emailTextField, passwordFieldLabel, passwordTextField, logInButton, signUpStackView], view)

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
            logInButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            signUpStackView.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 30),
            signUpStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    // Present the Sign Up view controller
    @objc func signUpButtonTapped() {
        let signUpViewController = SignUpViewController()
        signUpViewController.title = "Sign up"
        let navigationViewController = UINavigationController(rootViewController: signUpViewController)
         
        present(navigationViewController, animated: true, completion: nil)
    }
    
    @objc func logInButtonTapped() {
        
        // Sign in with the provided email and password
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (result, err) in
            if err != nil {
                Utilities.showAlert(err!.localizedDescription, self)
                print(err!.localizedDescription)
            }
            else {
                
                // Push the Tab Bar view controller
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            }
        }
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            textField.resignFirstResponder()
            logInButtonTapped()
        }
        return true
    }
}
