//
//  DictionaryExtensions.swift
//  ShudderII
//
//  Created by Guillermo Irigoyen on 9/30/18.
//  Copyright © 2018 Guillermo Irigoyen. All rights reserved.
//

import Foundation

extension Dictionary {
    func fromArrays(keys: [Key], values: [Value]) {        
        for (key, value) in zip(keys, values) {
            self[key] = value
        }
    }
}
