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
    
    /// Collections Table
    private var collectionViewTable        : UITableView!
    
    /// Hero Collection
    private static let heroViewCellIdentifier        = "HeroCell"
    private let heroViewHeight             : CGFloat = 160 // This could be optimized with a custom header view
    private let heroViewHeaderHeight       : CGFloat = 0
    
    /// Movies Collections
    private static let collectionCellIdentifier      = "CollectionCell"
    private let collectionViewHeight       : CGFloat = 150 // This could be optimized with a custom header view
    private let collectionViewHeaderHeight : CGFloat = 25
    private var moviesDataSource           : Dictionary<String,[Movie]>!
    private var moviesSectionKeys          : [String]!
    
    
    /// Convenience initializer
    convenience init(frame: CGRect, andMovieData: Dictionary<String,[Movie]>) {
        self.init(frame: frame)
        
        /// Table Data Sources
        moviesDataSource  = andMovieData
        moviesSectionKeys = Array(andMovieData.keys)
        
        /// Create and add the Collections Table
        attachSubviews()
        
    }
    
    /// Overrides
    override init(frame: CGRect){
        super.init(frame: frame)
        guiManager.setCurrentViewStandardStyle()

    }
    
    /// Required Initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
}


/// MARK - Utility Methods
extension MoviesCollectionsView {
    
    func attachSubviews(){
        collectionViewTable                 = UITableView(frame: frame, style: .grouped)
        collectionViewTable.delegate        = self
        collectionViewTable.dataSource      = self
        collectionViewTable.backgroundColor = CommonBackgroundColor
        collectionViewTable.separatorColor  = CommonBackgroundColor
        
        self.addSubview(collectionViewTable!)
        
    }
    
}


/// MARK - Table data source
extension MoviesCollectionsView : UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return moviesDataSource.keys.count
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell
        /// In case the types of cell increases this should change to switch case
        if indexPath.section == 0 {
            /// At the top is the Hero View
            cell = HeroViewTableViewCell(style: .default,
                                         reuseIdentifier: MoviesCollectionsView.heroViewCellIdentifier,
                                         andDataSource: moviesDataSource[moviesSectionKeys.last!]!)
            
        } else {
            /// Everything else is a Moview Collection
            cell = MoviesCollectionsTableViewCell(style: .default,
                                                  reuseIdentifier: MoviesCollectionsView.collectionCellIdentifier,
                                                  andDataSource: moviesDataSource[moviesSectionKeys[indexPath.section]]!)
            
        }
        cell.selectionStyle = .none
        cell.separatorInset = .zero
        cell.layoutMargins  = .zero
        return cell
    
    }
    
    
}


/// MARK - Table data delegate
extension MoviesCollectionsView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return moviesSectionKeys[section]
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return heroViewHeaderHeight }
        return collectionViewHeaderHeight
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { return heroViewHeight }
        return collectionViewHeight
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: tableView.frame.size.width,
                                              height: tableView.frame.size.height))
        headerView.backgroundColor = .clear
        let headerLabel = UILabel(frame: CGRect(x: 8,
                                                y: 6,
                                                width: tableView.frame.size.width,
                                                height: tableView.frame.size.height))
        headerLabel.font = UIFont(name: "HelveticaNeue-CondensedBold", size: 14)
        headerLabel.textColor = .gray
        headerLabel.text = moviesSectionKeys[section]
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.zero)
    }
    
}



