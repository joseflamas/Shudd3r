//
//  MoviesCollectionsCollectionViewCell.swift
//  ShudderII
//
//  Created by Guillermo Irigoyen on 9/30/18.
//  Copyright © 2018 Guillermo Irigoyen. All rights reserved.
//

import Foundation
import UIKit

class MoviesCollectionsCollectionViewCell: UICollectionViewCell {
    
    var movie : Movie?
    var movieKey : String?
    var moviePosterView  : UIImageView?
    var moviePosterImage : UIImage! {
        didSet{
            guard let poster = self.moviePosterImage else { return }
            moviePosterView?.image = poster
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor  = .white
        
        moviePosterView = UIImageView(frame: self.bounds)
        moviePosterView?.backgroundColor = .gray
        moviePosterView?.image = moviePosterImage
        
        contentView.addSubview(moviePosterView!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

}



