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
    
    // MARK: - Public Properties
    public  var currentMainView          : UIView!
    
    // MARK: - Private Properties
    private var mainWindow               : UIWindow!
    private var mainViewController       : UIViewController!
    private var mainNavigationController : UINavigationController!
    
    // MARK: - Initializers
    init(){
        setInitalWindow()
        
    }
    
    // MARK: - Public Methods
    public func getInitialWindow() -> UIWindow {
        mainWindow.rootViewController = mainNavigationController
        return mainWindow
        
    }
    
    // MARK: - Private Methods
    private func setInitalWindow() {
        mainWindow = UIWindow(frame: UIScreen.main.bounds)
        mainViewController = FeaturedViewController()
        mainViewController.title = StringsAliveMessage
        mainNavigationController = UINavigationController(rootViewController: mainViewController)
        mainNavigationController.navigationBar.barTintColor = .black
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        mainNavigationController.navigationBar.titleTextAttributes = textAttributes
        mainNavigationController.navigationBar.isTranslucent = false
        
    }
    
}


/// Mark - Animations
extension GUIManager {
    
    
}
