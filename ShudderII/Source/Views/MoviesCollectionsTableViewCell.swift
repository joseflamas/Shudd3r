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
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing      = 8
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 120), collectionViewLayout: layout)
        collectionView?.delegate   = self
        collectionView?.dataSource = self
        collectionView?.register(MoviesCollectionsCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView?.backgroundColor = .gray
        collectionView?.showsHorizontalScrollIndicator = false
        
        self.addSubview(collectionView!)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension MoviesCollectionsTableViewCell : UICollectionViewDataSource {
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (movieColletionData?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MoviesCollectionsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! MoviesCollectionsCollectionViewCell
        
        
        if let cachedImage  = moviePosterCollectionCache.object(forKey: "icon-\(movieColletionData?[indexPath.item].id.description ?? "")" as NSString){
            print("cached version")
            cell.moviePosterImage  = cachedImage
            
        } else {
            print("new version")
            let movie           = movieColletionData?[indexPath.item]
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
                    moviePosterCollectionCache.setObject(image!, forKey: "icon-\(self.movieColletionData?[indexPath.item].id.description ?? "")" as NSString)
                    cell.movie = self.movieColletionData?[indexPath.item]
                    cell.moviePosterImage = image
                    
                }
                }.resume()
            
        }
        
        if let cachedVersion = movieCollectionCache.object(forKey: indexPath.item.description  as NSString){
            print("cached version")
            cell.movie    = cachedVersion
            cell.movieKey = indexPath.item.description as String

        } else {
            print("new version")
            let movie = movieColletionData?[indexPath.item]
            movieCollectionCache.setObject(movie!, forKey: indexPath.item.description as NSString )
            cell.movie    = movie
            cell.movieKey = indexPath.item.description as String
            
        }
        
        
        return cell

    }
    
}

extension MoviesCollectionsTableViewCell : UICollectionViewDelegate {
    
}


extension MoviesCollectionsTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 85, height: self.frame.height)
    }
    
}

