//
//  HomeViewController.swift
//  Lumiere
//
//  Created by Andy Pang on 2022/7/10.
//

import UIKit

class HomeViewController : UIViewController {
    
    let titleFont = UIFont(name: "Avenir Black", size: 40)!
    let textFont = UIFont(name: "Avenir Next", size: 20)!
    let highlightTextFont = UIFont(name: "Avenir Black", size: 20)!
    let commentFont = UIFont(name: "Avenir Next", size: 15)!
    let highlightCommentFont = UIFont(name: "Avenir Black", size: 15)!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Background Color")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: titleFont, NSAttributedString.Key.foregroundColor: UIColor(named: "Text Color")!]
        title = "Home"
        
        // Disable moving back to login/sign-up screen
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false;
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = false;
        
        // Code goes here...
    }
}
