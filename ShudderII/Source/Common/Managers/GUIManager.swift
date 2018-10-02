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
    private var currentMainView          : UIView!
    
    // MARK: - Initializers
    init(){
        setInitalWindow()
        
    }
    
    // MARK: - UIWindows
    public func getInitialWindow() -> UIWindow {
        mainWindow.rootViewController = mainNavigationController
        return mainWindow
        
    }
    
    public func getmainWindow() -> UIWindow {
        return mainWindow
    }
    
    
    private func setInitalWindow() {
        mainWindow               = UIWindow(frame: UIScreen.main.bounds)
        mainViewController       = HomeViewController()
        mainViewController.title = StringsAliveMessage
        mainNavigationController = UINavigationController(rootViewController: mainViewController)
        setNavigationConrolletStyle()
        
    }
    
    // MARK: - Navigation controller
    public func setNavigationConrolletStyle(){
        mainNavigationController.navigationBar.barTintColor = .black
        let textAttributes       = [NSAttributedString.Key.foregroundColor:UIColor.red]
        mainNavigationController.navigationBar.titleTextAttributes = textAttributes
        //        mainNavigationController.navigationBar.isTranslucent = false
        
    }
    
    // MARK: - UIViews
    public func setCurrentMainView(to view: UIView){
        currentMainView = view
        setCurrentViewStandardStyle()
        
    }
    
    public func getCurrentMainview() -> UIView {
        return currentMainView
        
    }
    
    public func setCurrentViewStandardStyle(){
        currentMainView.backgroundColor = CommonBackgroundColor
        
    }
    
}

