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
    
    func getMovies(page: Int, completion: @escaping () -> Void) {
        APIClient.getPopularMoviesAPI(page: page) { (json) in
            if let results = json?["results"] as? [MovieJSON] {
                self.movies = []
                for dict in results {
                    let newMovie = Movie(dictionary: dict)
                    self.movies.append(newMovie)
                }
                completion()
            }
        }
    }
}
