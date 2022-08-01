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
        tabBarViewController.tabBar.tintColor = Utilities.highlightColor
        UITabBarItem.appearance().setTitleTextAttributes([.font: Utilities.tabBarFont], for: .normal)
        
        let watchedListViewController = UINavigationController(rootViewController: WatchedViewController())
        watchedListViewController.title = "Watched"
        
        let wishlistViewController = UINavigationController(rootViewController: WishlistViewController())
        wishlistViewController.title = "Wishlist"
        
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        profileViewController.title = "Profile"
        
        tabBarViewController.setViewControllers([watchedListViewController, wishlistViewController, profileViewController], animated: false)
        tabBarViewController.modalPresentationStyle = .fullScreen
        
        guard let icons = tabBarViewController.tabBar.items else {
            return
        }

        // Set the image of each tab bar icon
        let iconsImage = ["list.bullet.circle", "star.circle", "person.circle"]
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
