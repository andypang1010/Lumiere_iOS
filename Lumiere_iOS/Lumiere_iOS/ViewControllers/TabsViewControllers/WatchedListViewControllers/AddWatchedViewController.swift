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
    var dateWatchedPickerLabel = UILabel()
    var date = ""
    var dateWatchedPicker = UIDatePicker()
    var addButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background Color")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: UIColor(named: "Text Color")!]
        title = "Add Watched"
        
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
        
        ratingSliderLabel = {
            let label = UILabel()
            label.text = "Rating: 0.0"
            label.numberOfLines = 1
            label.font = Utilities.highlightTextFont
            label.textColor = UIColor(named: "Text Color")
            return label
        }()
        
        ratingSlider = {
            let slider = UISlider()
            slider.minimumValue = 0
            slider.maximumValue = 10
            slider.isContinuous = true
            slider.thumbTintColor = UIColor(named: "Text Color")
            slider.tintColor = UIColor(named: "Highlight Color")
            slider.setValue(0, animated: false)
            slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
            return slider
        }()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(likedMovieButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "Highlight Color")
        
        dateWatchedPickerLabel = {
            let label = UILabel()
            label.text = "Date watched"
            label.numberOfLines = 1
            label.font = Utilities.highlightTextFont
            label.textColor = UIColor(named: "Text Color")
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
        
        [titleFieldLabel, titleTextField, ratingSliderLabel, ratingSlider, dateWatchedPickerLabel, dateWatchedPicker, addButton].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
        
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
        
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            addButton.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    @objc func sliderChanged(_ sender: UISlider) {
        let sliderValue = round(ratingSlider.value * 10) / 10
        ratingSliderLabel.text = "Rating: \(sliderValue)"
    }
    
    @objc func likedMovieButtonTapped() {
        likedMovie = !likedMovie
        if (likedMovie == true) {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
        }
        else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
        }
    }
    
    @objc func datePickerToggled(_ datePicker: UIDatePicker) {
        date = formatDate(datePicker.date)
    }
    
    @objc func addButtonTapped() {
        let error = validateTitle()
        
        if (error != nil) {
            Utilities.showAlert(error!, self)
        }
        else {
            Utilities.userDocReference.collection("watchedList").addDocument(data: ["title":titleTextField.text!, "rating":round(ratingSlider.value * 10) / 10, "hasLiked":likedMovie, "date":dateWatchedPicker.date])
            
            self.dismiss(animated: true)
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy"
        return dateFormatter.string(from: date)
    }
}
