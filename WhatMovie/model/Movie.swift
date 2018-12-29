//
//  Movie.swift
//  WhatMovie
//
//  Created by Jose Gabriel Ferrer on 29/12/2018.
//  Copyright © 2018 Jose Gabriel Ferrer. All rights reserved.
//

import Foundation

struct Movie {
    let vote_count: Int
    let id: Int
    let video: Bool
    let vote_average: NSNumber
    let title: String
    let popularity: NSNumber
    let poster_path: String
    let original_language: String
    let original_title: String
    let genre_ids: [Int]
    let backdrop_path: String?
    let adult: Bool
    let overview: String
    let release_date: String
    
    init(dictionary: MovieJSON) {
        self.vote_count = dictionary["vote_count"] as! Int
        self.id = dictionary["id"] as! Int
        self.video = dictionary["video"] as! Bool
        self.vote_average = dictionary["vote_average"] as! NSNumber
        self.title = dictionary["title"] as! String
        self.popularity = dictionary["popularity"] as! NSNumber
        self.poster_path = dictionary["poster_path"] as! String
        self.original_language = dictionary["original_language"] as! String
        self.original_title = dictionary["original_title"] as! String
        self.genre_ids = dictionary["genre_ids"] as! [Int]
        self.backdrop_path = dictionary["backdrop_path"] as? String
        self.adult = dictionary["adult"] as! Bool
        self.overview = dictionary["overview"] as! String
        self.release_date = dictionary["release_date"] as! String

    }
    
}
