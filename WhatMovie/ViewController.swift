//
//  ViewController.swift
//  WhatMovie
//
//  Created by Jose Gabriel Ferrer on 29/12/2018.
//  Copyright © 2018 Jose Gabriel Ferrer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    let store = DataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.getMovieImages {
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        let movie = store.movies[indexPath.row]
        cell.displayContent(image: store.images[indexPath.row], title: movie.title)
        
        return cell
    }

}

