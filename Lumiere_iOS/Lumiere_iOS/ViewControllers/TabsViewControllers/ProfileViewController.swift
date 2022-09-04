//
//  ProfileViewController.swift
//  Lumiere_iOS
//
//  Created by Andy Pang on 2022/7/15.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ProfileViewController : UIViewController {

    var photoImageView = UIImageView()
    var photoUploadButton = UIButton()
    var emailLabel = UILabel()
    var uidLabel = UILabel()
    var deleteAccountButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Utilities.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = Utilities.backgroundColor
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: Utilities.textColor]
        title = "Profile"
        
        // Exit button on the right navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(logOutButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = Utilities.highlightColor
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: Utilities.highlightTextFont], for: .normal)
        
        Utilities.usersCollectionReference.document((Auth.auth().currentUser?.email)!).addSnapshotListener { querySnapshot, err in
            if let err = err {
                if err.localizedDescription != "Missing or insufficient permissions." {
                    Utilities.showAlert(err.localizedDescription, self)
                }
            }
            else {
                self.photoImageView = {
                    let imageView = UIImageView()
                    imageView.tintColor = Utilities.boxColor
                    imageView.contentMode = .scaleToFill
                    imageView.layer.cornerRadius = 100
                    imageView.layer.borderWidth = 12
                    imageView.layer.borderColor = Utilities.boxColor?.cgColor
                    imageView.clipsToBounds = true
                    return imageView
                }()
                
                // Listen to changes in the profilePhoto field of the user document
                let profilePhotoURL = querySnapshot?.get("profilePhoto")
                
                // Set a default photo
                if profilePhotoURL == nil {
                    self.photoImageView.image = UIImage(systemName: "person.fill")
                }
                
                // Convert the URL in profilePhoto to data and present in the photoImageView
                else {
                    if let data = try? Data(contentsOf: URL(string: profilePhotoURL as! String)!) {
                        self.photoImageView.image = UIImage(data: data)
                    }
                }

                self.photoUploadButton = {
                    let button = UIButton()
                    button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
                    button.tintColor = Utilities.textColor
                    button.contentVerticalAlignment = .fill
                    button.contentHorizontalAlignment = .fill
                    button.addTarget(self, action: #selector(self.uploadButtonTapped), for: .touchUpInside)
                    return button
                }()
                
                self.emailLabel = {
                    let label = UILabel()
                    label.text = Auth.auth().currentUser?.email
                    label.numberOfLines = 1
                    label.font = Utilities.largeFont
                    label.textColor = Utilities.textColor
                    return label
                }()
                
                self.uidLabel = {
                    let label = UILabel()
                    label.text = "UID: \(Auth.auth().currentUser!.uid)"
                    label.numberOfLines = 1
                    label.font = Utilities.commentFont
                    label.textColor = Utilities.textColor
                    return label
                }()
                
                self.deleteAccountButton = {
                    let button = UIButton()
                    button.setTitle("Delete Account", for: .normal)
                    button.titleLabel?.font = Utilities.commentFont
                    button.setTitleColor(Utilities.optionalColor, for: .normal)
                    button.addTarget(self, action: #selector(self.deleteAccountButtonTapped), for: .touchUpInside)
                    return button
                }()
                
                Utilities.addViews([self.photoImageView, self.photoUploadButton, self.emailLabel, self.uidLabel, self.deleteAccountButton], self.view)
                
                self.setUpConstraints()
            }
        }
    }
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            photoImageView.widthAnchor.constraint(equalToConstant: 200),
            photoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            photoUploadButton.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -10),
            photoUploadButton.rightAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: -10),
            photoUploadButton.widthAnchor.constraint(equalToConstant: 40),
            photoUploadButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: photoUploadButton.bottomAnchor, constant: 50),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            uidLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            uidLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            deleteAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            deleteAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // Sign out of the current user and return to the Log In view controller
    @objc func logOutButtonTapped() {
        do {
            try Auth.auth().signOut()
        }
        catch let err {
            Utilities.showAlert(err.localizedDescription, self)
            
        }
        self.navigationController?.pushViewController(LogInViewController(), animated: true)
    }
    
    // Access user's photo library and allow user to pick an image
    @objc func uploadButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    // Delete the current account with all its information and go back to Log In view controller
    @objc func deleteAccountButtonTapped() {
        
        let user = Auth.auth().currentUser!
        Utilities.usersCollectionReference.document((user.email!)).delete()
        
        user.delete { error in
          if let error = error {
              Utilities.showAlert(error.localizedDescription, self)
          } else {
              self.navigationController?.pushViewController(LogInViewController(), animated: true)
          }
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            
            // Compress image to have a quality of 0.3
            guard let imageData = image.jpegData(compressionQuality: 0.3) else {
                Utilities.showAlert("Couldn't compress image", self)
                return
            }
            
            // Create an arbitrary string as the ID for the image
            let imageID = UUID().uuidString
            let imageReference = Utilities.storage.reference().child(imageID)
            
            // Store data
            imageReference.putData(imageData, metadata: nil) { (metadata, err) in
                if let err = err {
                    Utilities.showAlert(err.localizedDescription, self)
                    return
                }
                
                // Fetch the download URL of the image
                imageReference.downloadURL { url, err in
                    if let err = err {
                        Utilities.showAlert(err.localizedDescription, self)
                        return
                    }
                    
                    guard let url = url else {
                        Utilities.showAlert("Profile photo download URL is invalid", self)
                        return
                    }
                    
                    // Save download URL to the user document
                    Utilities.usersCollectionReference.document((Auth.auth().currentUser?.email)!).setData(["profilePhoto" : url.absoluteString])
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
