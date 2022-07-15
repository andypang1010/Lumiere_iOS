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
    
    let db = Firestore.firestore()

    var nameFieldLabel = UILabel()
    var nameTextField = UITextField()
    var emailFieldLabel = UILabel()
    var emailTextField = UITextField()
    var passwordFieldLabel = UILabel()
    var passwordTextField = UITextField()
    var confirmPasswordFieldLabel = UILabel()
    var confirmPasswordTextField = UITextField()
    var signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background Color")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: UIColor(named: "Text Color")!]

        nameFieldLabel = {
            let label = UILabel()
            label.text = "Full name"
            label.numberOfLines = 1
            label.font = Utilities.textFont
            label.textColor = UIColor(named: "Text Color")
            return label
        }()
        
        nameTextField = {
            let textField = UITextField()
            textField.placeholder = "John Appleseed"
            textField.autocapitalizationType = .words
            textField.font = Utilities.textFont
            textField.textColor = UIColor(named: "Text Color")
            return textField
        }()
        
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
            textField.placeholder = "must have at least 8 characters"
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
            label.font = Utilities.textFont
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

        [nameFieldLabel, nameTextField, emailFieldLabel, emailTextField, passwordFieldLabel, passwordTextField, confirmPasswordFieldLabel, confirmPasswordTextField, signUpButton].forEach{subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
        
        setUpConstraints()
        
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            nameFieldLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            nameFieldLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameFieldLabel.bottomAnchor, constant: 5),
            nameTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            nameTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            emailFieldLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 50),
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
                    Utilities.showAlert("Error creating user", self)
                }

                // Store user's full name in database
                else {
                    self.db.collection("users").addDocument(data: ["fullName": self.nameTextField.text!, "uid": result!.user.uid]) { error in
                        if error != nil {
                            Utilities.showAlert("Error saving user data", self)
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
        [nameTextField, emailTextField, passwordTextField, confirmPasswordTextField].forEach{textField in
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
