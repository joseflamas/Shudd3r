//
//  Managers.swift
//  ShudderII
//
//  Created by Guillermo Irigoyen on 9/29/18.
//  Copyright © 2018 Guillermo Irigoyen. All rights reserved.
//

import Foundation

/// MANAGERS
// - comment: there is only one instance of each through App LifeCycle

var appManager     :  AppManager!       // <-- Init in AppDelegate
var guiManager     :  GUIManager!       // <--- From here all are initialize in the app manager
var dataManager    :  DataManager!
var requestManager :  RequestManager!
