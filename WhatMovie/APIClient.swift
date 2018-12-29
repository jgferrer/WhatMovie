//
//  APIClient.swift
//  WhatMovie
//
//  Created by Jose Gabriel Ferrer on 29/12/2018.
//  Copyright © 2018 Jose Gabriel Ferrer. All rights reserved.
//

import Foundation

typealias MovieJSON = [String: Any]

struct APIClient {
    static func getPopularMoviesAPI(page: Int, completion: @escaping (MovieJSON?) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?page=\(page)&language=es-ES&api_key=" + Constants.TMDBAPIKey)
        let session = URLSession.shared
        guard let unwrappedURL = url else { print("Error unwrapping URL"); return }
        let dataTask = session.dataTask(with: unwrappedURL) { (data, response, error) in
            guard let unwrappedData = data else { print("Error unwrapping data"); return }
            do {
                let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as? MovieJSON
                completion(responseJSON)
            } catch {
                print("Could not get API data. \(error), \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}
