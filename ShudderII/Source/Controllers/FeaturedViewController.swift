//
//  FeaturedViewController.swift
//  ShudderII
//
//  Created by Guillermo Irigoyen on 9/29/18.
//  Copyright © 2018 Guillermo Irigoyen. All rights reserved.
//

import Foundation
import UIKit


final class FeaturedViewController : UIViewController {
    
    /// MARK - Private properties
    private var spinner  = UIActivityIndicatorView(style: .whiteLarge)
    
    /// Hero
    private var heroSize : CGFloat?
    private var heroView : HeroView!
    
    /// Collections
    private var collectionsView : MoviesCollectionsView!
    
    /// Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
       
        heroSize = 150
        dataManager.delegate = self
        requestCollectionsData()
        
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}



extension FeaturedViewController {
    
    /// MARK - Private methods
    private func requestCollectionsData(){
        
        /// Start Spinner - This should be moved to GUIManager
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        /// Getting Image Data
        requestManager.simpleRequestDataToStringfromUrl(FlickerFavsURL)
    }
    
    /// Create and add subviews
    private func attachSubViews(withMovieInfo: Dictionary<String,[Movie]>){

        /// Hero View
        heroView = HeroView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.frame.size.width,
                                          height: heroSize ?? 0))
        heroView.translatesAutoresizingMaskIntoConstraints = false
        
        /// Collection View
        collectionsView = MoviesCollectionsView(frame: CGRect(x: 0,
                                                              y: 0,
                                                              width: view.frame.size.width,
                                                              height: (view.frame.size.height - (heroSize ?? 0))),
                                                andMovieData: withMovieInfo)
        collectionsView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(self.heroView)
        view.addSubview(self.collectionsView)

    }
    
    
    /// set constraints
    private func setConstraints(){
        let guide = self.view.safeAreaLayoutGuide
        
        /// Hero
        heroView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        heroView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        heroView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        heroView.heightAnchor.constraint(equalToConstant: (self.heroSize ?? 0)).isActive = true
        
        /// Collections
        collectionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionsView.topAnchor.constraint(equalTo: heroView.bottomAnchor).isActive = true
        collectionsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
}


/// MARK - Data Manager Delegate
extension FeaturedViewController : DataManagerDelegate {
    
    func decodedDataObtained(data: Dictionary<String,[Movie]>) {
        
        /// All of these are UI related - This should be moved to GUIManager
        DispatchQueue.main.async(){
            self.spinner.stopAnimating()
            self.spinner.removeFromSuperview()
            
            self.attachSubViews(withMovieInfo: data)
            self.setConstraints()
            
        }
    }
    
}
