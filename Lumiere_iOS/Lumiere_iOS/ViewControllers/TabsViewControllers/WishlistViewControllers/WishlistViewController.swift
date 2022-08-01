//
//  WishListViewController.swift
//  Lumiere_iOS
//
//  Created by Andy Pang on 2022/7/16.
//

import Foundation
import UIKit

class WishlistViewController: UIViewController {
    
    var wishlistTableView = UITableView()
    var imdbButton = UIButton()
    
    let wishlistReuseIdentifier = "wishlistCellReuse"
    let cellHeight: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Utilities.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = Utilities.backgroundColor
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: Utilities.textColor!]
        title = "Wishlist"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWishButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = Utilities.highlightColor
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: Utilities.highlightTextFont], for: .normal)
        
//        wishlistTableView.dataSource = self
        
        imdbButton = {
            let button = UIButton()
            button.setTitle("Discover", for: .normal)
            button.titleLabel?.font = Utilities.highlightTextFont
            button.setTitleColor(Utilities.textColor, for: .normal)
            button.backgroundColor = Utilities.highlightColor
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(imdbButtonTapped), for: .touchUpInside)
            return button
        }()
                
        Utilities.addViews([wishlistTableView, imdbButton], view)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            wishlistTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wishlistTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
            wishlistTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15),
            wishlistTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imdbButton.widthAnchor.constraint(equalToConstant: 100),
            imdbButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            imdbButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    // Present the Add Wish view controller
    @objc func addWishButtonTapped() {
        let addWishViewController = AddWishViewController()
        addWishViewController.title = "Add Movie"
        let navigationViewController = UINavigationController(rootViewController: addWishViewController)
         
        present(navigationViewController, animated: true, completion: nil)
    }
    
    // Open the IMDb Most Popular Movies page via the default browser
    @objc func imdbButtonTapped() {
        guard let imdbURL = URL(string: "https://www.imdb.com/chart/moviemeter/?ref_=nv_mv_mpm") else {
            Utilities.showAlert("Can't open IMDb", self)
            return
        }
        UIApplication.shared.open(imdbURL, options: [:], completionHandler: nil)
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
