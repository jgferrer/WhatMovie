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
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var popularButton: UIBarButtonItem!
    @IBOutlet weak var topratedButton: UIBarButtonItem!
    @IBOutlet weak var upcomingButton: UIBarButtonItem!
    
    
    let store = DataStore.sharedInstance
    var pageNumber: Int = 1
    var movieOption: String = "popular"
    var isWating: Bool = false
    
    let selectedItemColor = UIColor(red: 0, green: 0.1216, blue: 0.9294, alpha: 1.0)
    let unselectedItemColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tintButtons()
        
        store.getMovies(movieOption: movieOption, page: 1) {
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }
    
    private func doPaging(goToTop: Bool) {
        tintButtons()
        store.getMovies(movieOption: movieOption, page: self.pageNumber) {
            DispatchQueue.main.async {
                UIView.performWithoutAnimation {
                    self.moviesCollectionView.reloadSections(IndexSet(integer: 0))
                }
                if (goToTop) {
                    self.moviesCollectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
                }
                self.isWating = false
            }
        }
    }
    
    private func tintButtons() {
        popularButton.tintColor = (movieOption == "popular") ? selectedItemColor : unselectedItemColor
        topratedButton.tintColor = (movieOption == "top_rated") ? selectedItemColor : unselectedItemColor
        upcomingButton.tintColor = (movieOption == "upcoming") ? selectedItemColor : unselectedItemColor
    }
    
    // MARK: - ToolBar Actions
    
    @IBAction func showPopularMovies(_ sender: Any) {
        navigationBar.topItem?.title = "WhatMovie - Popular"
        pageNumber = 1
        movieOption = "popular"
        isWating = true
        doPaging(goToTop: true)
    }
    
    @IBAction func showTopRatedMovies(_ sender: Any) {
        navigationBar.topItem?.title = "WhatMovie - Top rated"
        pageNumber = 1
        movieOption = "top_rated"
        isWating = true
        doPaging(goToTop: true)
    }
    
    @IBAction func showUpcomingMovies(_ sender: Any) {
        navigationBar.topItem?.title = "WhatMovie - Upcoming"
        pageNumber = 1
        movieOption = "upcoming"
        isWating = true
        doPaging(goToTop: true)
    }
    
    
    // MARK: - Collection view data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        let movie = store.movies[indexPath.row]
        let url = (!(movie.poster_path ?? "").isEmpty ?
            URL(string: "https://image.tmdb.org/t/p/w185" + movie.poster_path!) :
            URL(string: ""))
        
        cell.movieTitle.text = movie.title
        let defaultImage = UIImage(named: "no-image")
        cell.movieImage.kf.setImage(with: url, placeholder: defaultImage)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == store.movies.count - 4 && !isWating {
            isWating = true
            self.pageNumber += 1
            self.doPaging(goToTop: false)
        }
    }
}

