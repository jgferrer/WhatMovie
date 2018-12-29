//
//  ViewController.swift
//  WhatMovie
//
//  Created by Jose Gabriel Ferrer on 29/12/2018.
//  Copyright © 2018 Jose Gabriel Ferrer. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var btnBackPage: UIButton!
    @IBOutlet weak var btnNextPage: UIButton!
    @IBOutlet weak var txtPageNumber: UITextField!
    
    let store = DataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.getMovies(page: 1) {
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }

    @IBAction func btnNext(_ sender: UIButton) {
        txtPageNumber.text = String(Int(txtPageNumber.text!)! + 1)
        store.getMovies(page: Int(txtPageNumber.text!)!) {
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        if (txtPageNumber.text != "1"){
            txtPageNumber.text = String(Int(txtPageNumber.text!)! - 1)
            store.getMovies(page: Int(txtPageNumber.text!)!) {
                DispatchQueue.main.async {
                    self.moviesCollectionView.reloadSections(IndexSet(integer: 0))
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        let movie = store.movies[indexPath.row]
        let url = URL(string: "https://image.tmdb.org/t/p/w370_and_h556_bestv2" + movie.poster_path)
        cell.movieTitle.text = movie.title
        cell.movieImage.kf.setImage(with: url)

        return cell
    }
    
}

