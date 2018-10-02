//
//  HeroViewCollectionViewCell.swift
//  ShudderII
//
//  Created by Guillermo Irigoyen on 10/1/18.
//  Copyright © 2018 Guillermo Irigoyen. All rights reserved.
//

import Foundation
import UIKit

class HeroViewCollectionViewCell : UICollectionViewCell {
    
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
        backgroundColor  = .black
        layer.masksToBounds = false
        layer.cornerRadius = 5
        layer.shadowOffset = CGSize(width: 2, height: 4)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.6
        
        moviePosterView = UIImageView(frame: self.bounds)
        moviePosterView?.backgroundColor = .gray
        moviePosterView?.layer.cornerRadius = 5;
        moviePosterView?.layer.masksToBounds = true;
        moviePosterView?.image = moviePosterImage
        
        contentView.addSubview(moviePosterView!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
}


