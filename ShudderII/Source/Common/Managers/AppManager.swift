//
//  AppManager.swift
//  ShudderII
//
//  Created by Guillermo Irigoyen on 9/29/18.
//  Copyright © 2018 Guillermo Irigoyen. All rights reserved.
//

import Foundation

import UIKit


final class AppManager {

    // MARK: - Public Properties
    public static let sharedManager : AppManager = AppManager()
    
    // MARK: - Private Properties
    
    // MARK: - Initializers
    init(){
        initManagers()
        
    }
    
    // MARK: - SubManagers
    private func initManagers(){
        guiManager     = GUIManager()
        dataManager    = DataManager()
        requestManager = RequestManager()
        
    }
    
    
}
