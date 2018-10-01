//
//  RequestManager.swift
//  ShudderII
//
//  Created by Guillermo Irigoyen on 9/29/18.
//  Copyright © 2018 Guillermo Irigoyen. All rights reserved.
//

import Foundation



class RequestManager : NSObject {
    /// Static Properties
    public  static  let sharedManager           : RequestManager            = RequestManager()
    
    /// Init
    override init(){
        super.init()
        print("Initializing Request Manager ...")
        
    }
    
    /// URL Loading Simple Path
    public func simpleRequestDataToStringfromUrl(_ url: URL?)->(){
        let sessionWithoutADelegate = URLSession(configuration: URLSessionConfiguration.default)
        if let tUrl : URL = url {
            (sessionWithoutADelegate.dataTask(with: tUrl) { (data, response, error) in
                if let error = error {
                    dataManager?.handleError(error: error)
                    
                } else if let response = response,
                    let data     = data {
                    dataManager?.handleResponse(response: response)
                    dataManager?.handleData(data: data)
                    
                }
            }).resume()
        }
    }
    
    ///
    func callHome()->(){
        simpleRequestDataToStringfromUrl( URL(string:"https://www.shudder.com") )
        
    }
    
}



