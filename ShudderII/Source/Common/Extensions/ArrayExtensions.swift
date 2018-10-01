//
//  ArrayExtensions.swift
//  ShudderII
//
//  Created by Guillermo Irigoyen on 9/30/18.
//  Copyright © 2018 Guillermo Irigoyen. All rights reserved.
//

import Foundation

extension Array {
    func splitBy(_ size: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, self.count)])
        }
    }
}
