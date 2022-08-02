//
//  WatchedTableViewCell.swift
//  Lumiere_iOS
//
//  Created by Andy Pang on 2022/7/30.
//

import UIKit

class WatchedTableViewCell: UITableViewCell {
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = Utilities.highlightTextFont
        label.textColor = Utilities.textColor
        return label
    }()
    var ratingLabel : UILabel = {
        let label = UILabel()
        label.font = Utilities.largeFont
        label.textColor = Utilities.highlightColor
        return label
    }()
    var dateLabel : UILabel = {
        let label = UILabel()
        label.font = Utilities.commentFont
        label.textColor = Utilities.textColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        Utilities.addViews([titleLabel, ratingLabel, dateLabel], contentView)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: ratingLabel.rightAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            ratingLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            ratingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            ratingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: ratingLabel.rightAnchor, constant: 20),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dateLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    /// Configure the values of the elements inside the cell to show the Watched object
    /// - Parameter watched: A Watched object
    func configure(_ watched : Watched) {
        titleLabel.text = watched.title
        ratingLabel.text = String(round(watched.rating * 10) / 10)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        dateLabel.text = dateFormatter.string(from: watched.date)
        
        if watched.hasLiked == true {
            ratingLabel.textColor = Utilities.textColor
        }
        else {
            ratingLabel.textColor = Utilities.highlightColor
        }
    }
    
}
