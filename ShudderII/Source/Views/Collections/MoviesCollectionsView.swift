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
    
    /// Hero
    private var heroSize : CGFloat?
    private let heroViewCellIdentifier   = "HeroCell"
    
    /// Collections
    private let collectionCellIdentifier = "CollectionCell"
    private var collectionViewTable      : UITableView?
    
    private var moviesDataSource         : Dictionary<String,[Movie]>?
    private var moviesSectionKeys        : [String]?
    
    
    convenience init(frame: CGRect, andMovieData: Dictionary<String,[Movie]>) {
        self.init(frame: frame)
        
        moviesDataSource  = andMovieData
        moviesSectionKeys = Array(andMovieData.keys)
        
        heroSize = 150
        attachSubviews()
        
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .black

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
        if indexPath.section == 0 {
            let heroCell = HeroViewTableViewCell(style: .default, reuseIdentifier: heroViewCellIdentifier, andDataSource: moviesDataSource![moviesSectionKeys![indexPath.section]]!)
            heroCell.selectionStyle = .none
            return heroCell
            
        }
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
        if section == 0 {
            return 0
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return heroSize!
        }
        return 120
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    
}


extension MoviesCollectionsView {
    
    func attachSubviews(){
        
        collectionViewTable = UITableView(frame: frame, style: .grouped)
        collectionViewTable?.backgroundColor = .black
        collectionViewTable?.delegate   = self
        collectionViewTable?.dataSource = self
        collectionViewTable?.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        self.addSubview(collectionViewTable!)
    
    }
    
}
