//
//  AddMovieViewController.swift
//  Lumiere_iOS
//
//  Created by Andy Pang on 2022/7/16.
//

import Foundation
import UIKit
import FirebaseAuth

class AddWatchedViewController: UIViewController {
    
    var titleFieldLabel = UILabel()
    var titleTextField = UITextField()
    var ratingSliderLabel = UILabel()
    var ratingSlider = UISlider()
    var likedMovie = false
    var hasLikedButton = UIButton()
    var date = String()
    var dateWatchedPickerLabel = UILabel()
    var dateWatchedPicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Utilities.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: Utilities.textColor!]
        title = "Add Watched"
        
        // Like button
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(likedMovieButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = Utilities.highlightColor
        
        // Add button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addWatchedButtonTapped))
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
            textField.placeholder = "\"Jurassic Park\""
            textField.autocapitalizationType = .none
            textField.font = Utilities.textFont
            textField.textColor = Utilities.textColor
            textField.delegate = self
            textField.returnKeyType = .continue
            return textField
        }()
        
        ratingSliderLabel = {
            let label = UILabel()
            label.text = "Rating: 0.0"
            label.numberOfLines = 1
            label.font = Utilities.highlightTextFont
            label.textColor = Utilities.textColor
            return label
        }()
        
        ratingSlider = {
            let slider = UISlider()
            slider.minimumValue = 0
            slider.maximumValue = 10
            slider.isContinuous = true
            slider.thumbTintColor = Utilities.textColor
            slider.tintColor = Utilities.highlightColor
            slider.setValue(0, animated: false)
            slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
            return slider
        }()
        
        dateWatchedPickerLabel = {
            let label = UILabel()
            label.text = "Date watched"
            label.numberOfLines = 1
            label.font = Utilities.highlightTextFont
            label.textColor = Utilities.textColor
            return label
        }()
        
        dateWatchedPicker = {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.maximumDate = Date()
            datePicker.addTarget(self, action: #selector(datePickerToggled), for: .valueChanged)
            return datePicker
        }()
        
        Utilities.addViews([titleFieldLabel, titleTextField, ratingSliderLabel, ratingSlider, dateWatchedPickerLabel, dateWatchedPicker], view)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleFieldLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleFieldLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: titleFieldLabel.bottomAnchor, constant: 5),
            titleTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            titleTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            ratingSliderLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 50),
            ratingSliderLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            ratingSlider.topAnchor.constraint(equalTo: ratingSliderLabel.bottomAnchor, constant: 10),
            ratingSlider.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            ratingSlider.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            dateWatchedPickerLabel.topAnchor.constraint(equalTo: ratingSlider.bottomAnchor, constant: 50),
            dateWatchedPickerLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            dateWatchedPicker.topAnchor.constraint(equalTo: dateWatchedPickerLabel.bottomAnchor, constant: 10),
            dateWatchedPicker.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            dateWatchedPicker.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30)
        ])
    }
    
    // Display the numeric value of the slider rounded to 1 decimal point
    @objc func sliderChanged(_ sender: UISlider) {
        let sliderValue = round(ratingSlider.value * 10) / 10
        ratingSliderLabel.text = "Rating: \(sliderValue)"
    }
    
    // Negate the current likedMovie state
    @objc func likedMovieButtonTapped() {
        likedMovie = !likedMovie
        if (likedMovie == true) {
            navigationItem.leftBarButtonItem?.image = UIImage(systemName: "heart.fill")
        }
        else {
            navigationItem.leftBarButtonItem?.image = UIImage(systemName: "heart")
        }
    }
    
    
    /// Format the date by MMMM DD YYYY
    /// - Parameter datePicker: A UIDatePicker object
    @objc func datePickerToggled(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy"
        date = dateFormatter.string(from: datePicker.date)
    }
    
    
    // Create a document with the provided title, rating, date, and state of hasLiked
    @objc func addWatchedButtonTapped() {
        let error = validateTitle()
        
        if (error != nil) {
            Utilities.showAlert(error!, self)
        }
        else {
            Utilities.usersCollectionReference.document((Auth.auth().currentUser?.email)!).collection("watchedList").addDocument(data: ["title":titleTextField.text!, "rating":round(ratingSlider.value * 10) / 10, "hasLiked":likedMovie, "date":dateWatchedPicker.date])
            
            self.dismiss(animated: true)
        }
    }
    
    func validateTitle() -> String? {
        if (titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            return "Title can't be left empty"
        }
        
        return nil
    }
}

extension AddWatchedViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
