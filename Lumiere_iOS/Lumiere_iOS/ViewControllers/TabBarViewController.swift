//
//  TabBarViewController.swift
//  Lumiere_iOS
//
//  Created by Andy Pang on 2022/7/14.
//

import Foundation
import UIKit

class TabBarViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarViewController = UITabBarController()
        tabBarViewController.tabBar.tintColor = UIColor(named: "Highlight Color")
        tabBarViewController.tabBarItem.setTitleTextAttributes([.font: Utilities.commentFont], for: .normal)
        
        let myListViewController = UINavigationController(rootViewController: MyListViewController())
        myListViewController.title = "My List"
        
        let IMDbViewController = UINavigationController(rootViewController: IMDbViewController())
        IMDbViewController.title = "IMDb"
        
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        profileViewController.title = "Profile"
        
        tabBarViewController.setViewControllers([myListViewController, IMDbViewController, profileViewController], animated: false)
        tabBarViewController.modalPresentationStyle = .fullScreen
        
        guard let icons = tabBarViewController.tabBar.items else {
            return
        }

        let iconsImage = ["list.bullet.circle", "film.circle", "person.circle"]

        for i in 0..<icons.count {
            icons[i].image = UIImage(systemName: iconsImage[i])
        }
        
        present(tabBarViewController, animated: false)
        
        // Disable moving back to login/sign-up screen
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false;
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = false;
        
    }
    
}
