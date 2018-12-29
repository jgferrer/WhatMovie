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
    var images: [UIImage] = []
    
    func getMovies(completion: @escaping () -> Void) {
        
        APIClient.getPopularMoviesAPI { (json) in
            //let feed = json?["feed"] as? MovieJSON
            if let results = json?["results"] as? [MovieJSON] {
                for dict in results {
                    let newMovie = Movie(dictionary: dict)
                    self.movies.append(newMovie)
                }
                completion()
            }
        }
    }
    
    func getMovieImages(completion: @escaping () -> Void) {
        getMovies {
            for movie in self.movies {
                let url = URL(string: "https://image.tmdb.org/t/p/w370_and_h556_bestv2" + movie.poster_path)
                let data = try? Data(contentsOf: url!)
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self.images.append(image!)
                }
            }
            OperationQueue.main.addOperation {
                completion()
            }
        }
    }
}
