//
//  WishListViewController.swift
//  Lumiere_iOS
//
//  Created by Andy Pang on 2022/7/16.
//

import Foundation
import UIKit
import FirebaseAuth

class WishlistViewController: UIViewController {
    
    var wishlistTableView = UITableView()
    var imdbButton = UIButton()
    var wishlist = [Wish]()
    
    let wishlistReuseIdentifier = "wishlistCellReuse"
    let cellHeight: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Utilities.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = Utilities.backgroundColor
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: Utilities.textColor]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Utilities.highlightTextFont, NSAttributedString.Key.foregroundColor: Utilities.textColor]
        title = "Wishlist"
        
        // Add button that presents the Add Wish view controller when tapped
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWishButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = Utilities.highlightColor
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: Utilities.highlightTextFont], for: .normal)
        
        // Fetch all the documents in the current user's watchedList
        Utilities.usersCollectionReference.document((Auth.auth().currentUser?.email)!).collection("wishlist").addSnapshotListener { querySnapshot, err in
            if let err = err {
                if err.localizedDescription != "Missing or insufficient permissions." {
                    Utilities.showAlert(err.localizedDescription, self)
                }
            }
            else {
                self.wishlist = []
                for document in querySnapshot!.documents {
                    
                    // Create Wish object and add to local wishlist
                    self.wishlist.append(Wish(title: document.get("title") as! String, id: document.get("id") as! String))
                }
            }
        
            self.wishlistTableView = {
                let tableView = UITableView()
                tableView.backgroundColor = Utilities.boxColor
                tableView.layer.cornerRadius = 15
                tableView.dataSource = self
                tableView.delegate = self
                tableView.separatorColor = Utilities.backgroundColor
                tableView.showsVerticalScrollIndicator = false
                tableView.register(WishlistTableViewCell.self, forCellReuseIdentifier: self.wishlistReuseIdentifier)
                return tableView
            }()
            
            self.imdbButton = {
                let button = UIButton()
                button.setTitle("Discover", for: .normal)
                button.titleLabel?.font = Utilities.highlightTextFont
                button.setTitleColor(Utilities.textColor, for: .normal)
                button.backgroundColor = Utilities.highlightColor
                button.layer.cornerRadius = 10
                button.addTarget(self, action: #selector(self.imdbButtonTapped), for: .touchUpInside)
                return button
            }()
                    
            Utilities.addViews([self.wishlistTableView, self.imdbButton], self.view)
            
            self.setUpConstraints()
        }
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            wishlistTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wishlistTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
            wishlistTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15),
            wishlistTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
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

extension WishlistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wishlist.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = wishlistTableView.dequeueReusableCell(withIdentifier: wishlistReuseIdentifier) as? WishlistTableViewCell {
            cell.configure(wishlist[indexPath.row])
            cell.selectionStyle = .none
            cell.backgroundColor = Utilities.boxColor

            return cell
        }
        else {
            return UITableViewCell()
        }
    }
}

extension WishlistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive,
                                        title: nil) { [weak self] (action, view, completionHandler) in
            self?.deleteWish(id: self!.wishlist[indexPath.row].id)
                                            completionHandler(true)
        }
        
        action.image = UIImage(systemName: "xmark")
        action.image?.withTintColor(Utilities.textColor)
        action.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func deleteWish(id: String) {
        Utilities.usersCollectionReference.document((Auth.auth().currentUser?.email!)!).collection("wishlist").document(id).delete()
    }
}
