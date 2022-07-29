//
//  SignUpViewController.swift
//  Lumiere
//
//  Created by Andy Pang on 2022/7/9.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController : UIViewController {

    var emailFieldLabel = UILabel()
    var emailTextField = UITextField()
    var passwordFieldLabel = UILabel()
    var passwordTextField = UITextField()
    var confirmPasswordFieldLabel = UILabel()
    var confirmPasswordTextField = UITextField()
    var passwordRulesTextView = UILabel()
    var signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background Color")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: UIColor(named: "Text Color")!]
        title = "Sign Up"
        
        emailFieldLabel = {
            let label = UILabel()
            label.text = "Email"
            label.numberOfLines = 1
            label.font = Utilities.highlightTextFont
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
            label.font = Utilities.highlightTextFont
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
        
        confirmPasswordFieldLabel = {
            let label = UILabel()
            label.text = "Confirm password"
            label.numberOfLines = 1
            label.font = Utilities.highlightTextFont
            label.textColor = UIColor(named: "Text Color")
            return label
        }()
        
        confirmPasswordTextField = {
            let textField = UITextField()
            textField.placeholder = "confirm password"
            textField.autocapitalizationType = .none
            textField.isSecureTextEntry = true
            textField.font = Utilities.textFont
            textField.textColor = UIColor(named: "Text Color")
            return textField
        }()
        
        passwordRulesTextView = {
           let label = UILabel()
            label.text = "1. Password must have at least eight characters \n2. Password must contain a big letter \n3. Password must contain a small letter \n4. Password must contain a number"
            label.font = Utilities.commentFont
            label.textColor = UIColor(named: "Text Color")
            
            label.numberOfLines = 4
            return label
        }()
        
        signUpButton = {
            let button = UIButton()
            button.setTitle("Sign up", for: .normal)
            button.titleLabel?.font = Utilities.highlightTextFont
            button.setTitleColor(UIColor(named: "Text Color"), for: .normal)
            button.backgroundColor = UIColor(named: "Highlight Color")
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
            return button
        }()

        [emailFieldLabel, emailTextField, passwordFieldLabel, passwordTextField, confirmPasswordFieldLabel, confirmPasswordTextField, passwordRulesTextView, signUpButton].forEach{subView in
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
            confirmPasswordFieldLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            confirmPasswordFieldLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordFieldLabel.bottomAnchor, constant: 10),
            confirmPasswordTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            confirmPasswordTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            passwordRulesTextView.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 50),
            passwordRulesTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            passwordRulesTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            signUpButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func signUpButtonTapped() {
        
        // Validate fields
        let error = validateFields()
        
        if (error != nil) {
            Utilities.showAlert(error!, self)
        }
        else {
            // Create user
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in

                // Check for errors
                if (error != nil) {
                    Utilities.showAlert(error!.localizedDescription, self)
                }

                // Store user's UID in database
                else {
                    Utilities.database.collection("users").document(self.emailTextField.text!).setData(["uid": result!.user.uid]) { err in
                        if err != nil {
                            Utilities.showAlert(err!.localizedDescription, self)
                        }
                    }
                }
            }
            
            // Dismiss sign-up screen
            dismiss(animated: true)
        }
    }
    
    
    /// Read all the fields in the view controller and check if they are filled in and follow the required rules
    /// - Returns: Returns nil if the fields are filled and comply to the rules, returns an error message if the fields are unfilled
    func validateFields() -> String? {
        var errorMessage = ""
        [emailTextField, passwordTextField, confirmPasswordTextField].forEach{textField in
            if (textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            errorMessage = "Please fill in all the fields"
        }}
        
        let cleanedPassword = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (Utilities.isPasswordValid(cleanedPassword ?? "") == false) {
            errorMessage = "Password must contain at least one big letter, one small letter, one number, and is minimum eight characters long"
        }
        
        else if (confirmPasswordTextField.text != passwordTextField.text) {
            errorMessage = "Password and confirm password does not match"
        }
        
        if (errorMessage != "") {
            return errorMessage
        }
        
        return nil
    }
}
