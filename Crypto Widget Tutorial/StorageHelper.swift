//
//  StorageHelper.swift
//  Crypto Widget Tutorial
//
//  Created by Connor Van Ooyen on 8/26/17.
//  Copyright © 2017 Connor Van Ooyen. All rights reserved.
//

import Foundation

struct defaultsKeys {
    static let coinArrayStorage = "coinArrayStorage"
    static let timesOpened = "timesOpened"
}

class StorageHelper {
    
    static let defaults = UserDefaults.standard
    
    static func setCoinStorage(array: [String]) {
        //if empty populate with BTC and ETH
        if defaults.stringArray(forKey: defaultsKeys.coinArrayStorage)?.count == 0 || array.count == 0 {
            defaults.set(["BTC", "ETH"], forKey: defaultsKeys.coinArrayStorage)
        } else {
            defaults.set(array, forKey: defaultsKeys.coinArrayStorage)
        }
    }
    
    static func getFromStorage() -> [String] {
        
        if let array = defaults.stringArray(forKey: defaultsKeys.coinArrayStorage) {
            return array
        } else {
            return ["BTC", "ETH"]
        }
    }
    
}
