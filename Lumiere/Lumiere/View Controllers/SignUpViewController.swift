//
//  SignUpViewController.swift
//  Lumiere
//
//  Created by Andy Pang on 2022/7/9.
//

import UIKit

class SignUpViewController : UIViewController {
    
    let titleFont = UIFont(name: "Avenir Black", size: 40)!
    let textFont = UIFont(name: "Avenir Next", size: 20)!
    let highlightTextFont = UIFont(name: "Avenir Black", size: 20)!
    let commentFont = UIFont(name: "Avenir Next", size: 15)!
    let highlightCommentFont = UIFont(name: "Avenir Black", size: 15)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background Color")
        navigationController?.navigationBar.prefersLargeTitles = true

        title = "Sign up"

        // Code goes here...

        setUpConstraints()
        
    }
    
    func setUpConstraints() {
        
    }
}
