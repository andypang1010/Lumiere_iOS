//
//  AddWishViewController.swift
//  Lumiere_iOS
//
//  Created by Andy Pang on 2022/7/16.
//

import Foundation
import UIKit
import FirebaseAuth

class AddWishViewController: UIViewController {
    
    var titleFieldLabel = UILabel()
    var titleTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Utilities.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: Utilities.textColor!]
        title = "Add Wish"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addWishButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = Utilities.highlightColor
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: Utilities.highlightTextFont], for: .normal)
        
        titleFieldLabel = {
            let label = UILabel()
            label.text = "Title"
            label.numberOfLines = 1
            label.font = Utilities.highlightTextFont
            label.textColor = Utilities.textColor
            return label
        }()
        
        titleTextField = {
            let textField = UITextField()
            textField.placeholder = "Enter the film title"
            textField.autocapitalizationType = .none
            textField.font = Utilities.textFont
            textField.textColor = Utilities.textColor
            textField.delegate = self
            textField.returnKeyType = .done
            return textField
        }()
        
        Utilities.addViews([titleFieldLabel, titleTextField], view)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleFieldLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleFieldLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: titleFieldLabel.bottomAnchor, constant: 5),
            titleTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            titleTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30)
        ])
    }
    
    func validateTitle() -> String? {
        if (titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            return "Title can't be left empty"
        }
        
        return nil
    }
    
    @objc func addWishButtonTapped() {
        let err = validateTitle()
        
        if (err != nil) {
            Utilities.showAlert(err!, self)
        }
        else {
            
            // Get the id of the new document
            let docID = Utilities.usersCollectionReference.document((Auth.auth().currentUser?.email)!).collection("wishlist").document().documentID
            
            // Set the fields of the new document, with one of its field being its id
            Utilities.usersCollectionReference.document((Auth.auth().currentUser?.email)!).collection("wishlist").document(docID).setData(["title":titleTextField.text!, "id":docID])
            
            self.dismiss(animated: true)
        }
    }
}

extension AddWishViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        addWishButtonTapped()
        return true
    }
}
