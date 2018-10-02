//
//  DataManager.swift
//  ShudderII
//
//  Created by Guillermo Irigoyen on 9/29/18.
//  Copyright © 2018 Guillermo Irigoyen. All rights reserved.
//

import Foundation

protocol DataManagerDelegate {
    func decodedDataObtained(data:Dictionary<String,[Movie]>)
    
}


class DataManager {
    
    /// Static Properties
    public  static  let sharedManager  : DataManager  = DataManager()
    var delegate : DataManagerDelegate?
    
    public  var moviesCollections : Dictionary<String,[Movie]>?
    private var movies : [Movie]?
    
    /// Init
    init(){
        print("Initializing Data Manager ...")
        moviesCollections = Dictionary<String,[Movie]>()
        movies = [Movie]()
        
    }
    
    /// Data
    public func handleData( data: Data )->(){
        let data = data
        decodeDataToStrig(data:data)
        
    }
    
    /// Response
    public func handleResponse( response : URLResponse )->(){

    }
    
    // Decode and Format
    public func decodeDataToStrig(data: Data ) -> (){

        let string = String(data: data, encoding: .utf8)
        
        /// Solves a particular issue with flicker api json response
        var cleanString = string?.replacingOccurrences(of:"jsonFlickrApi(", with:"")
        cleanString?.removeLast()
        let cleanData : Data! = cleanString?.data(using: .utf8)
        
        do {
            if let jsonDict = try JSONSerialization.jsonObject(with: cleanData, options: .mutableContainers ) as? [String:Any]
            {
                let collection : Dictionary = jsonDict["photos"] as! Dictionary<String,Any>
                let photos : Array = collection["photo"] as! Array<Dictionary<String,Any>>
                for photo in photos {
                    let movie = Movie(title: (photo["title"] as! String),
                                      id: (photo["id"] as! String),
                                      server: (photo["server"] as! String),
                                      farm: (photo["farm"] as! NSNumber).stringValue,
                                      secret: (photo["secret"] as! String),
                                      owner: (photo["owner"] as! String))
                    movies?.append(movie)
                }

            } else {
                print("bad json")
            }
            
        } catch let error as NSError {
           handleError( error:error )
        }
        
        moviesCollections = createMoviegroups(fromMovies: movies ?? [Movie]())
        delegate?.decodedDataObtained(data: moviesCollections ?? Dictionary<String,[Movie]>() )
        
    }
    
    /// Errors
    public func handleError( error:Error )->(){
        print( error )
        
    }
}


extension DataManager {
    /// Utitlities
    private func createMoviegroups(fromMovies:[Movie]) -> [String:[Movie]] {
        
        let sections = ["Newly Added", "Curator's Choice", "Best Soundtracks", "Get Rad", "Vengeance is Hers", "Black Magick", "Haunts", "Binge This"]
        let movies = fromMovies.splitBy(sections.count)
        let movieSections = Dictionary(zip(sections, movies), uniquingKeysWith: { (first, _) in first })
        
        return movieSections
    }
    
    
}
