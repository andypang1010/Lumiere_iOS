//
//  Movie.swift
//  Lumiere_iOS
//
//  Created by Andy Pang on 2022/7/16.
//

import Foundation

class Movie {
    var name: String
    var rating: Float
    var hasLiked: Bool
    var dateWatched: Date
    
    init(name: String, rating: Float, hasLiked: Bool, dateWatched: Date) {
        self.name = name
        self.rating = rating
        self.hasLiked = hasLiked
        self.dateWatched = dateWatched
    }
}
