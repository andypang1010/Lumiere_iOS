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
    var passwordConstraintsLabel = UILabel()
    var passwordConstraintsTextView = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Utilities.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = Utilities.backgroundColor
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: Utilities.textColor!]
        title = "Sign Up"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(signUpButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = Utilities.highlightColor
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: Utilities.highlightTextFont], for: .normal)
        
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
            textField.returnKeyType = .continue
            return textField
        }()
        
        confirmPasswordFieldLabel = {
            let label = UILabel()
            label.text = "Confirm password"
            label.numberOfLines = 1
            label.font = Utilities.highlightTextFont
            label.textColor = Utilities.textColor
            return label
        }()
        
        confirmPasswordTextField = {
            let textField = UITextField()
            textField.placeholder = "Enter your password again"
            textField.autocapitalizationType = .none
            textField.isSecureTextEntry = true
            textField.font = Utilities.textFont
            textField.textColor = Utilities.textColor
            textField.delegate = self
            textField.returnKeyType = .done
            return textField
        }()
        
        passwordConstraintsLabel = {
            let label = UILabel()
            label.text = "Password Constraints:"
            label.numberOfLines = 1
            label.font = Utilities.highlightCommentFont
            label.textColor = Utilities.textColor
            return label
        }()
        
        passwordConstraintsTextView = {
           let label = UILabel()
            label.text = "1. Password must have at least eight characters \n2. Password must contain a big letter \n3. Password must contain a small letter \n4. Password must contain a number"
            label.font = Utilities.commentFont
            label.textColor = Utilities.textColor
            label.numberOfLines = 4
            return label
        }()

        Utilities.addViews([emailFieldLabel, emailTextField, passwordFieldLabel, passwordTextField, confirmPasswordFieldLabel, confirmPasswordTextField, passwordConstraintsLabel, passwordConstraintsTextView], view)
        
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
            passwordConstraintsLabel.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 40),
            passwordConstraintsLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            passwordConstraintsTextView.topAnchor.constraint(equalTo: passwordConstraintsLabel.bottomAnchor, constant: 10),
            passwordConstraintsTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            passwordConstraintsTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30)
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
                    Utilities.database.collection("users").document(self.emailTextField.text!).setData([:]) { err in
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

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            textField.resignFirstResponder()
            confirmPasswordTextField.becomeFirstResponder()
        }
        else if textField == confirmPasswordTextField {
            textField.resignFirstResponder()
            signUpButtonTapped()
        }
        return true
    }
}
