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

    var scrollView = UIScrollView()
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
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: Utilities.textColor]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Utilities.highlightTextFont, NSAttributedString.Key.foregroundColor: Utilities.textColor]
        title = "Sign Up"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(signUpButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = Utilities.highlightColor
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: Utilities.highlightTextFont], for: .normal)
        
        scrollView = {
            let scrollView = UIScrollView()
            scrollView.isScrollEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.isDirectionalLockEnabled = true
            scrollView.scrollsToTop = true
            scrollView.bounces = true
            return scrollView
        }()
        
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

        Utilities.addViews([emailFieldLabel, emailTextField, passwordFieldLabel, passwordTextField, confirmPasswordFieldLabel, confirmPasswordTextField, passwordConstraintsLabel, passwordConstraintsTextView], scrollView)
        Utilities.addViews([scrollView], view)
        
        setUpConstraints()
        
    }
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            emailFieldLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            emailFieldLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            emailFieldLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: emailFieldLabel.bottomAnchor, constant: 10),
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            passwordFieldLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50),
            passwordFieldLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            passwordFieldLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordFieldLabel.bottomAnchor, constant: 10),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            confirmPasswordFieldLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            confirmPasswordFieldLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            confirmPasswordFieldLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordFieldLabel.bottomAnchor, constant: 10),
            confirmPasswordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            confirmPasswordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            passwordConstraintsLabel.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 40),
            passwordConstraintsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            passwordConstraintsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            passwordConstraintsTextView.topAnchor.constraint(equalTo: passwordConstraintsLabel.bottomAnchor, constant: 10),
            passwordConstraintsTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            passwordConstraintsTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            passwordConstraintsTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30)
        ])
        

    }
    
    @objc func signUpButtonTapped() {
        
        // Validate fields
        let err = validateFields()
        
        if (err != nil) {
            Utilities.showAlert(err!.debugDescription, self)
        }
        else {
            
            // Create user
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, err) in

                // Check for errs
                if (err != nil) {
                    Utilities.showAlert(err!.localizedDescription, self)
                }

                // Store user's UID in database
                else {
                    Utilities.usersCollectionReference.document(self.emailTextField.text!).setData([:]) { err in
                        if err != nil {
                            Utilities.showAlert(err!.localizedDescription, self)
                        }
                        else {
                            // Dismiss sign-up screen
                            self.dismiss(animated: true)
                        }
                    }
                }
            }
        }
    }
    
    func validateFields() -> String? {
        var errMessage = ""
        
        // Check if every field is filled in
        [emailTextField, passwordTextField, confirmPasswordTextField].forEach{textField in
            if (textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            errMessage = "Please fill in all the fields"
        }}
        
        // Check if the password is not just space
        let cleanedPassword = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if (Utilities.isPasswordValid(cleanedPassword ?? "") == false) {
            errMessage = "Password must contain at least one big letter, one small letter, one number, and is minimum eight characters long"
        }
        
        // Check if password and confirm password are the same
        else if (confirmPasswordTextField.text != passwordTextField.text) {
            errMessage = "Password and confirm password does not match"
        }
        
        if (errMessage != "") {
            return errMessage
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
