//
//  IMDbViewController.swift
//  Lumiere_iOS
//
//  Created by Andy Pang on 2022/7/15.
//

import UIKit

class IMDbViewController : UIViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Background Color")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: UIColor(named: "Text Color")!]
        title = "IMDb"
        
        // Code goes here...
    }
}
