//
//  MovieCollectionViewCell.swift
//  WhatMovie
//
//  Created by Jose Gabriel Ferrer on 29/12/2018.
//  Copyright © 2018 Jose Gabriel Ferrer. All rights reserved.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    
    func displayContent(image: UIImage, title: String){
        movieImage.image = image
        movieTitle.text = title
    }
    
}
