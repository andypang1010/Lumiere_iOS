//
//  Watched.swift
//  Lumiere_iOS
//
//  Created by Andy Pang on 2022/7/30.
//

import Foundation

class Watched {
    var title: String
    var hasLiked: Bool
    var date: Date
    var rating: Float
    var id: String
    
    init(title: String, hasLiked: Bool, date: Date, rating: Float, id: String) {
        self.title = title
        self.hasLiked = hasLiked
        self.date = date
        self.rating = rating
        self.id = id
    }
}
