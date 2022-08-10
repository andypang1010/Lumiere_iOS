//
//  WishlistTableViewCell.swift
//  Lumiere_iOS
//
//  Created by Andy Pang on 2022/8/1.
//

import UIKit
import FirebaseAuth

class WishlistTableViewCell: UITableViewCell {
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = Utilities.highlightTextFont
        label.textColor = Utilities.textColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        Utilities.addViews([titleLabel], contentView)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configure the values of the elements inside the cell to show the Wish object
    func configure(_ wish : Wish) {
        titleLabel.text = wish.title
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
    }
}
