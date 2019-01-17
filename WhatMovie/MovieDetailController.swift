//
//  MovieDetailController.swift
//  WhatMovie
//
//  Created by Jose Gabriel Ferrer on 12/01/2019.
//  Copyright © 2019 Jose Gabriel Ferrer. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class MovieDetailController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieOverview: UILabel!
    
    var selectedMovie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = (!(selectedMovie!.poster_path ?? "").isEmpty ?
            URL(string: "https://image.tmdb.org/t/p/w185" + selectedMovie!.poster_path!) :
            URL(string: ""))
        
        let defaultImage = UIImage(named: "no-image")
        movieImage.kf.setImage(with: url, placeholder: defaultImage)
        
        lblMovieTitle.text = (selectedMovie?.title)! + " (\(selectedMovie?.release_date.subString(from: 0, to: 3) ?? "--"))"
        lblMovieOverview.text = selectedMovie?.overview
        
    }
    
    
    @IBAction func closeDetail(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension String {
    func subString(from: Int, to: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex...endIndex])
    }
}
