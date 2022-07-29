//
//  WishListViewController.swift
//  Lumiere_iOS
//
//  Created by Andy Pang on 2022/7/16.
//

import Foundation
import UIKit

class WishlistViewController: UIViewController {
    var tableView = UITableView()
    
    let reuseIdentifier = "wishlistCellReuse"
    let cellHeight: CGFloat = 50
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Background Color")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: UIColor(named: "Text Color")!]
        title = "Wishlist"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWishButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "Highlight Color")
        
//        tableView.dataSource = self
        
        [tableView].forEach{subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func addWishButtonTapped() {
        let addWishViewController = AddWishViewController()
        addWishViewController.title = "Add Movie"
        let navigationViewController = UINavigationController(rootViewController: addWishViewController)
         
        present(navigationViewController, animated: true, completion: nil)
    }
}

//extension WishlistViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}

//}
