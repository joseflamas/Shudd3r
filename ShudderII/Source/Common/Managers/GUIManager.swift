//
//  GUIManager.swift
//  ShudderII
//
//  Created by Guillermo Irigoyen on 9/29/18.
//  Copyright © 2018 Guillermo Irigoyen. All rights reserved.
//

import Foundation
import UIKit

final class GUIManager {
    
    // MARK: - Private Properties
    private var mainWindow               : UIWindow!
    private var mainViewController       : UIViewController!
    private var mainNavigationController : UINavigationController!
    
    // MARK: - Public Properties
    public var currentMainView           : UIView!
    
    // MARK: - Initializers
    init(){
        setInitalWindow()
        
    }
    
    // MARK: - Private Methods
    private func setInitalWindow() {
        mainWindow = UIWindow(frame: UIScreen.main.bounds)
        mainViewController = FeaturedViewController()
        mainViewController.title = StringsAliveMessage
        mainNavigationController = UINavigationController(rootViewController: mainViewController)
        mainNavigationController.navigationBar.barTintColor = .black
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        mainNavigationController.navigationBar.titleTextAttributes = textAttributes
        
    }
    
    
    // MARK: - Public Methods
    public func getInitialWindow() -> UIWindow {
        mainWindow.rootViewController = mainNavigationController
        return mainWindow
        
    }
    
    
    
    
    
}


// Animations
extension GUIManager {
    
    
    
    
}
