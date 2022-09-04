//
//  MyListViewController.swift
//  Lumiere
//
//  Created by Andy Pang on 2022/7/10.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class WatchedViewController : UIViewController {
    
    var watchedTableView = UITableView()
    var watchedList : [Watched] = []
    
    let watchedReuseIdentifier = "watchedCellReuse"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Utilities.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = Utilities.backgroundColor
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Utilities.titleFont, NSAttributedString.Key.foregroundColor: Utilities.textColor]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Utilities.highlightTextFont, NSAttributedString.Key.foregroundColor: Utilities.textColor]
        title = "Watched"
        
        // Add button on the right navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMovieButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = Utilities.highlightColor
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: Utilities.highlightTextFont], for: .normal)
        
        // Fetch all the documents in the current user's watchedList
        Utilities.usersCollectionReference.document((Auth.auth().currentUser?.email)!).collection("watchedList").addSnapshotListener { querySnapshot, err in
            if let err = err {
                if err.localizedDescription != "Missing or insufficient permissions." {
                    Utilities.showAlert(err.localizedDescription, self)
                }
            }
            else {
                self.watchedList = []
                for document in querySnapshot!.documents {
                    
                    // Convert FIRTimestamp to NSDate
                    guard let stamp = document.get("date") as? Timestamp
                    else {
                        return
                    }
                    
                    // Create Watched object and add to local watched list
                    self.watchedList.append(Watched(title: document.get("title") as! String, hasLiked: document.get("hasLiked") as! Bool, date: stamp.dateValue(), rating: document.get("rating") as! Float, id: document.get("id") as! String))
                }
            }
            
            self.watchedTableView = {
                let tableView = UITableView()
                tableView.backgroundColor = Utilities.boxColor
                tableView.layer.cornerRadius = 15
                tableView.dataSource = self
                tableView.delegate = self
                tableView.separatorColor = Utilities.backgroundColor
                tableView.showsVerticalScrollIndicator = false
                tableView.register(WatchedTableViewCell.self, forCellReuseIdentifier: self.watchedReuseIdentifier)
                return tableView
            }()
            
            Utilities.addViews([self.watchedTableView], self.view)
            self.setUpConstraints()
        }
    }
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            watchedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            watchedTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
            watchedTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15),
            watchedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
    
    //  Present the Add Watched view controller
    @objc func addMovieButtonTapped() {
        let addWatchedViewController = AddWatchedViewController()
        addWatchedViewController.title = "Add Watched"
        let navigationViewController = UINavigationController(rootViewController: addWatchedViewController)
         
        present(navigationViewController, animated: true, completion: nil)
    }
}

extension WatchedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        watchedList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = watchedTableView.dequeueReusableCell(withIdentifier: watchedReuseIdentifier) as? WatchedTableViewCell {
            cell.configure(watchedList[indexPath.row])
            cell.selectionStyle = .none
            if watchedList[indexPath.row].hasLiked == true {
                cell.backgroundColor = Utilities.highlightColor
            }
            else {
                cell.backgroundColor = Utilities.boxColor
            }
            return cell

        }
        else {
            return UITableViewCell()
        }

    }
}

extension WatchedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let watched = watchedList[indexPath.row]
        let editWatchedViewController = EditWatchedViewController()
        editWatchedViewController.title = "Edit Watched"
        
        // Store the data of Watched object in Utilities to be accessed by the Edit Watched view controller
        Utilities.selected = watched
        let navigationViewController = UINavigationController(rootViewController: editWatchedViewController)
         
        present(navigationViewController, animated: true, completion: nil)
        
    }
    
    // Trailing delete swipe action on cells
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive,
                                        title: nil) { [weak self] (action, view, completionHandler) in
            self?.deleteWatched(id: self!.watchedList[indexPath.row].id)
                                            completionHandler(true)
        }
        action.image = UIImage(systemName: "xmark")
        action.image?.withTintColor(Utilities.textColor)
        action.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func deleteWatched(id: String) {
        Utilities.usersCollectionReference.document((Auth.auth().currentUser?.email!)!).collection("watchedList").document(id).delete()
    }
}
