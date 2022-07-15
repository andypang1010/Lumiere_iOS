//
//  MyListViewController.swift
//  Lumiere
//
//  Created by Andy Pang on 2022/7/10.
//

import UIKit

class MyListViewController : UIViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Background Color")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: UIColor(named: "Text Color")!]
        title = "My List"
        
        // Code goes here...
    }
}
