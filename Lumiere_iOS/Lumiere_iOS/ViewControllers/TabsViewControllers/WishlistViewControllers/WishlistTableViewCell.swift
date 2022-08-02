//
//  WishlistTableViewCell.swift
//  Lumiere_iOS
//
//  Created by Andy Pang on 2022/8/1.
//

import UIKit
import FirebaseAuth

class WishlistTableViewCell: UITableViewCell {
    
    var id = String()
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = Utilities.highlightTextFont
        label.textColor = Utilities.textColor
        return label
    }()

    var deleteButton : UIButton = {
        let button = UIButton()
        button.tintColor = Utilities.highlightColor
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        Utilities.addViews([titleLabel, deleteButton], contentView)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ wish : Wish) {
        titleLabel.text = wish.title
        id = wish.id
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deleteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func deleteButtonTapped() {
        Utilities.usersCollectionReference.document((Auth.auth().currentUser?.email!)!).collection("wishlist").document(id).delete()
    }
}
