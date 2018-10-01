//
//  Movie.swift
//  ShudderII
//
//  Created by Guillermo Irigoyen on 9/30/18.
//  Copyright © 2018 Guillermo Irigoyen. All rights reserved.
//

import Foundation


//    "date_faved": "1538328290",
//    "farm": 2,
//    "id": "29012280468",
//    "isfamily": 0,
//    "isfriend": 0,
//    "ispublic": 1,
//    "owner": "158966401@N05",
//    "secret": "7e15a452fa",
//    "server": "1804",
//    "title": "POSTER - DRAGON WARS"
//    https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_m.jpg
//    https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_z.jpg

class Movie : NSObject {
    let title    : String!
    let id       : String!
    let serverId : String!
    let farmId   : String!
    let secret   : String!
    let owner    : String!

    var thumbnailStringUrl  : String!
    var largeImageStringUrl : String!
    
    init(title: String!, id: String!, server: String!, farm: String!, secret: String!, owner: String! ) {
        self.title = title
        self.id = id
        self.serverId = server
        self.farmId = farm
        self.secret = secret
        self.owner = owner
        
        self.thumbnailStringUrl  = "https://farm\(farm ?? "000").staticflickr.com/\(server ?? "000")/\(id ?? "000")_\(secret ?? "000")_m.jpg"
        
        self.largeImageStringUrl = "https://farm\(farm ?? "000").staticflickr.com/\(server ?? "000")/\(id ?? "000")_\(secret ?? "000")_z.jpg"
        
    }
    
    
}
