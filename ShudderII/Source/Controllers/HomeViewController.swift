//
//  FeaturedViewController.swift
//  ShudderII
//
//  Created by Guillermo Irigoyen on 9/29/18.
//  Copyright © 2018 Guillermo Irigoyen. All rights reserved.
//

import Foundation
import UIKit


final class HomeViewController : UIViewController {
    
    /// Loading Spinner -- Could be moved to the Guimanager
    private var spinner         : UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    /// Movie Collections
    private var collectionsView : MoviesCollectionsView!
    
    /// Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        guiManager.setCurrentMainView(to: view)
        
        /// Data
        dataManager.delegate = self
        requestCollectionsData()
        
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}


/// MARK - Utility Methods
extension HomeViewController {
    
    /// Request Collections data
    private func requestCollectionsData(){
        /// Getting Image Data
        presentSpinner()
        requestManager.simpleRequestDataToStringfromUrl(FlickerFavsURL)
        
    }
    
    /// Create and add subviews
    private func attachSubViews(withMovieInfo: Dictionary<String,[Movie]>){
        /// Collection View
        collectionsView = MoviesCollectionsView(frame: view.bounds, andMovieData: withMovieInfo)
        collectionsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.collectionsView)

    }
    
    /// Set constraints
    private func setConstraints(){
        /// Safe area
        let guide = self.view.safeAreaLayoutGuide
        collectionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionsView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        collectionsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    /// Spinner methods
    private func presentSpinner(){
        /// Start Spinner - This could be moved to GUIManager
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    private func stopSippner(){
        /// Stop and remove Spinner - This could be moved to GUIManager
        spinner.stopAnimating()
        spinner.removeFromSuperview()
        
    }
    
}


/// MARK - Data Manager Delegate
extension HomeViewController : DataManagerDelegate {
    
    func decodedDataObtained(data: Dictionary<String,[Movie]>) {
        /// All of these are UI related - This should be moved to GUIManager
        DispatchQueue.main.async(){
            self.stopSippner()
            self.attachSubViews(withMovieInfo: data)
            self.setConstraints()
            
        }
    }
    
}
