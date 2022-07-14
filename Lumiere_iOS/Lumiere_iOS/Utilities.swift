//
//  Utilities.swift
//  Lumiere
//
//  Created by Andy Pang on 2022/7/12.
//

import UIKit
import Foundation

class Utilities {
    
    /// Checks if the password complies with the specified Regex
    /// - Parameter userPassword: The password that the user passed to the text field
    /// - Returns: Returns true if the password has a length of at least 8, contains at least 1 big letter, 1 small letter, and 1 number; Returns false otherwise
    static func isPasswordValid(_ userPassword : String) -> Bool {
        let password = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
        return password.evaluate(with: userPassword)
    }
    
    static func showAlert(_ errorMessage: String, _ viewController: UIViewController) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
