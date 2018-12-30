//
//  DataStore.swift
//  WhatMovie
//
//  Created by Jose Gabriel Ferrer on 29/12/2018.
//  Copyright © 2018 Jose Gabriel Ferrer. All rights reserved.
//

import Foundation
import UIKit

final class DataStore {
    
    static let sharedInstance = DataStore()
    fileprivate init() {}
    
    var movies: [Movie] = []
    
    func getMovies(movieOption: String, page: Int, completion: @escaping () -> Void) {
        APIClient.getMoviesAPI(movieOption: movieOption, page: page) { (json) in
            if let results = json?["results"] as? [MovieJSON] {
                if page == 1 { self.movies = [] }
                for dict in results {
                    let newMovie = Movie(dictionary: dict)
                    self.movies.append(newMovie)
                }
                completion()
            }
        }
    }
}
