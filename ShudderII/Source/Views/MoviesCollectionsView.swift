//
//  MoviesCollectionsTableView.swift
//  ShudderII
//
//  Created by Guillermo Irigoyen on 9/29/18.
//  Copyright © 2018 Guillermo Irigoyen. All rights reserved.
//

import Foundation
import UIKit


final class MoviesCollectionsView : UIView {
    
    let collectionCellIdentifier = "CollectionCell"
    var collectionViewTable      : UITableView?
    
    var moviesDataSource         : Dictionary<String,[Movie]>?
    var moviesSectionKeys        : [String]?
    
    
    convenience init(frame: CGRect, andMovieData: Dictionary<String,[Movie]>) {
        self.init(frame: frame)
        
        moviesDataSource  = andMovieData
        moviesSectionKeys = Array(andMovieData.keys)
        
        collectionViewTable = UITableView(frame: frame, style: .grouped)
        collectionViewTable?.delegate   = self
        collectionViewTable?.dataSource = self
        
        self.addSubview(collectionViewTable!)
        
        
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .gray

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




/// Table data source
extension MoviesCollectionsView : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return moviesDataSource?.keys.count ?? 0
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MoviesCollectionsTableViewCell(style: .default, reuseIdentifier: collectionCellIdentifier,
                                                  andDataSource: moviesDataSource![moviesSectionKeys![indexPath.section]]!)
        cell.selectionStyle = .none
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return moviesSectionKeys?[section]
        
    }
    
}


/// Table data delegate
extension MoviesCollectionsView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    
}
