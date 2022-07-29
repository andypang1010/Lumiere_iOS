//
//  AddWishViewController.swift
//  Lumiere_iOS
//
//  Created by Andy Pang on 2022/7/16.
//

import Foundation
import UIKit

class AddWishViewController: UIViewController {
    
    var titleFieldLabel = UILabel()
    var titleTextField = UITextField()
    var addButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background Color")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: UIColor(named: "Text Color")!]
        title = "Add Wish"
        
        titleFieldLabel = {
            let label = UILabel()
            label.text = "Title"
            label.numberOfLines = 1
            label.font = Utilities.highlightTextFont
            label.textColor = UIColor(named: "Text Color")
            return label
        }()
        
        titleTextField = {
            let textField = UITextField()
            textField.placeholder = "\"Jurassic Park\""
            textField.autocapitalizationType = .none
            textField.font = Utilities.textFont
            textField.textColor = UIColor(named: "Text Color")
            return textField
        }()
        
        addButton = {
            let button = UIButton()
            button.setTitle("Add", for: .normal)
            button.titleLabel?.font = Utilities.highlightTextFont
            button.setTitleColor(UIColor(named: "Text Color"), for: .normal)
            button.backgroundColor = UIColor(named: "Highlight Color")
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            return button
        }()
        
        [titleFieldLabel, titleTextField, addButton].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
        
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
        
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            addButton.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func validateTitle() -> String? {
        if (titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            return "Title can't be left empty"
        }
        
        return nil
    }
    
    @objc func addButtonTapped() {
        let error = validateTitle()
        
        if (error != nil) {
            Utilities.showAlert(error!, self)
        }
        else {
            Utilities.userDocReference.collection("wishlist").addDocument(data: ["title":titleTextField.text!])
            
            self.dismiss(animated: true)
        }
        
    }
}
