//
//  MoviesCollectionsTableViewCell.swift
//  ShudderII
//
//  Created by Guillermo Irigoyen on 9/29/18.
//  Copyright © 2018 Guillermo Irigoyen. All rights reserved.
//

import Foundation
import UIKit

class MoviesCollectionsTableViewCell : UITableViewCell {
    
    var movieColletionData : [Movie]?
    var collectionView : UICollectionView?
    
    convenience init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, andDataSource: [Movie]){
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        
        movieColletionData = andDataSource
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.minimumLineSpacing  = 4
        
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 150), collectionViewLayout: layout)
        collectionView?.delegate   = self
        collectionView?.dataSource = self
        collectionView?.register(MoviesCollectionsCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView?.backgroundColor = .clear
        collectionView?.showsHorizontalScrollIndicator = false
        
        self.addSubview(collectionView!)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

/// MARK - UICollectionViewDataSource
extension MoviesCollectionsTableViewCell : UICollectionViewDataSource {
   
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (movieColletionData?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MoviesCollectionsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! MoviesCollectionsCollectionViewCell
        
        
        if let cachedImage  = moviePosterCollectionCache.object(forKey: "icon-\(movieColletionData?[indexPath.item].id.description ?? "")" as NSString){
            cell.moviePosterImage  = cachedImage
            
        } else {
            let movie           = movieColletionData?[indexPath.item]
            
            /// Move to Request Manager
            URLSession.shared.dataTask(with: URL(string: movie!.thumbnailStringUrl)!) { (data, response, error) in
                if error != nil {
                    print("Failed fetching image:")
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("Not a proper HTTPURLResponse or statusCode")
                    return
                }
                DispatchQueue.main.async {
                    let image = UIImage(data: data!)
                    
                    /// Move to Data Manager
                    moviePosterCollectionCache.setObject(image!, forKey: "icon-\(self.movieColletionData?[indexPath.item].id.description ?? "")" as NSString)
                    cell.movie = self.movieColletionData?[indexPath.item]
                    cell.moviePosterImage = image
                    
                }
                }.resume()
            
        }
        
        /// Move to Data Manager
        if let cachedVersion = movieCollectionCache.object(forKey: indexPath.item.description  as NSString){
            cell.movie    = cachedVersion
            cell.movieKey = indexPath.item.description as String

        } else {
            let movie = movieColletionData?[indexPath.item]
            movieCollectionCache.setObject(movie!, forKey: indexPath.item.description as NSString )
            cell.movie    = movie
            cell.movieKey = indexPath.item.description as String
            
        }
        
        return cell

    }
    
}

/// MARK - UICollectionViewDelegate
extension MoviesCollectionsTableViewCell : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movieColletionData?[indexPath.item]
        print(movie?.title ?? "" )
        print(movie?.largeImageStringUrl ?? "")
        
        let moviDetail = MoviesDetailView(frame: guiManager.getCurrentMainview().bounds, andMovieData: movie!)
        moviDetail.movie = movie
        
        guiManager.getmainWindow().addSubview(moviDetail)
    }
    
}

/// MARK - UICollectionViewDelegateFlowLayout
extension MoviesCollectionsTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 85, height: self.frame.height-10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
}

