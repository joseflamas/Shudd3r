//
//  Common.swift
//  ShudderII
//
//  Created by Guillermo Irigoyen on 9/29/18.
//  Copyright © 2018 Guillermo Irigoyen. All rights reserved.
//

import Foundation


import Foundation
import UIKit

var  CommonNetworkState          : NetworkState?
enum NetworkState                : String {
    case NoConnectivity          = "No Bueno"
    case ConnectedOverWifi       = "Over Wifi"
    case ConnectedOverData       = "Over Data"
    
}

/// PERSISTENT STORAGE
var CommonUserDefaults           : UserDefaults   = UserDefaults.standard
var CommonFileManager            : FileManager    = FileManager.default

/// URLS
let CommonDocumentsDirectoryURL  : URL      = CommonFileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
let CommonCacheDirectoryURL      : URL      = CommonFileManager.urls(for: .cachesDirectory,   in: .userDomainMask).first!
let CommonCachePathKEY           : String   = "COMMON-CACHE"
let CommonCachePath              : String   = CommonCacheDirectoryURL.path + CommonCachePathKEY

/// CACHE
var CacheMemoryCapacity          : Int      = 250000000  // ~ 250 MB
var CacheDiskCapacity            : Int      = 250000000  // ~ 250 MB
let CommonCache                  : URLCache = URLCache(memoryCapacity: CacheMemoryCapacity,
                                                       diskCapacity: CacheDiskCapacity,
                                                       diskPath: CommonCachePath)
let movieCollectionCache         = NSCache<NSString,Movie>()
let moviePosterCollectionCache   = NSCache<NSString,UIImage>()

/// FLICKR API
let FlickerEndPoint              : String   = "https://api.flickr.com/services/rest/?"
let FlickerKey                   : String   = "92a1b6ca3019c1870efe028ca9c55c12"
let FlickerUserId                : String   = "156837020@N07"
let FlickerFavMethod             : String   = "flickr.favorites.getList"
let FlickerFormat                : String   = "json"
let FlickerAPIKeykey             : String   = "&api_key="
let FlickerUserIdkey             : String   = "&user_id="
let FlickerFavMethodkey          : String   = "&method="
let FlickerFormatkey             : String   = "&format="

let FlickerFavsURL               : URL!     = URL(string: "\(FlickerEndPoint)\(FlickerAPIKeykey+FlickerKey)\(FlickerUserIdkey+FlickerUserId)\(FlickerFavMethodkey+FlickerFavMethod)\(FlickerFormatkey+FlickerFormat)")
