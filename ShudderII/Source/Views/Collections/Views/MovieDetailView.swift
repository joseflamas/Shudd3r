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
    
    convenience init(frame: CGRect, andMovieData: Dictionary<String,[Movie]>) {
        self.init(frame: frame)
        
        
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .black
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
