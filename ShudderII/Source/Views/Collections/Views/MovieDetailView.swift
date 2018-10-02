//
//  MovieDetailView.swift
//  ShudderII
//
//  Created by Guillermo Irigoyen on 10/1/18.
//  Copyright © 2018 Guillermo Irigoyen. All rights reserved.
//

import Foundation
import UIKit

class MoviesDetailView : UIView {
    
    var movie : Movie?
    var moviePosterView : UIImageView?
    var moviePosterImage : UIImage! {
        didSet{
            guard let poster = self.moviePosterImage else { return }
            moviePosterView?.image = poster
            
        }
    }
    
    
    convenience init(frame: CGRect, andMovieData: Movie) {
        self.init(frame: frame)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
        
        moviePosterView = UIImageView(frame: self.bounds)
        moviePosterView?.backgroundColor = .clear
        addSubview(moviePosterView!)
        
        setConstraints()
        
        /// Move to request Manager
        DispatchQueue.global().async {
            let poster = try? Data(contentsOf: URL(string: (self.movie?.largeImageStringUrl)!)!)
            DispatchQueue.main.async {
                self.moviePosterImage = UIImage(data: poster!)
                self.moviePosterView?.image = self.moviePosterImage
            }
        }
        
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension MoviesDetailView {
    
    /// Set constraints
    private func setConstraints(){
        /// Safe area
        let guide = safeAreaLayoutGuide
        moviePosterView?.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        moviePosterView?.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        moviePosterView?.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        moviePosterView?.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        
    }
    
    @objc
    func handleTap(_ sender:Any){
        self.removeFromSuperview()
        
    }
    
    
}
