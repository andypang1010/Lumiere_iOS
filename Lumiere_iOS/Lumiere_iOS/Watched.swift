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
    
    init(title: String, hasLiked: Bool, date: Date, rating: Float) {
        self.title = title
        self.hasLiked = hasLiked
        self.date = date
        self.rating = rating
    }
    
    func toString() -> String {
        return "[\(title), \(hasLiked), \(date), \(rating)]"
    }
}
