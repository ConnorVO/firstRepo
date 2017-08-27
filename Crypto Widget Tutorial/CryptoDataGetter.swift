//
//  CryptoDataGetter.swift
//  Crypto Widget Tutorial
//
//  Created by Connor Van Ooyen on 8/26/17.
//  Copyright © 2017 Connor Van Ooyen. All rights reserved.
//

import Foundation

class CryptoDataGetter {
    
    static private let myMainTableViewController = MainTableViewController()
    static private var marketArray: [String] = [String]()
    static private var priceArray: [Double] = [Double]()
    static private var changeArray: [Double] = [Double]()
    static private var changePctArray: [Double] = [Double]()
    
    static private var dataIsRetrieved = false
    
    static func getCryptoData(from: [String]) {

        Crypto.getData(from: from, to:"USD") { (results:[Crypto]) in
            //loop through results with completion handler to know when data is set
            //will only work if called from myMainTableViewController because of using myMainTableViewController in completion handler
            self.dataLoop(withResults: results, completion: myMainTableViewController.reloadTable)
        }
    }
    
    static func dataLoop(withResults results:[Crypto], completion: () -> Void ) {
        print("Data market: ", marketArray.count)
        print("Data Coins: ", StorageHelper.getFromStorage().count)
        for result in results {
            if(marketArray.count < StorageHelper.getFromStorage().count) {
                self.marketArray.append(result.market)
                self.priceArray.append(result.price.rounded(toPlaces: 2))
                self.changeArray.append(result.change.rounded(toPlaces: 2))
                self.changePctArray.append(result.changePct.rounded(toPlaces: 2))
            }
        }
        
        dataIsRetrieved = true
        completion()
    }
    
    static func getMarketArray() -> [String] {
        print("Data Market Array: ", marketArray.count)
        return marketArray
    }
    
    static func getPriceArray() -> [Double] {
        return priceArray
    }
    
    static func getChangeArray() -> [Double] {
        return changeArray
    }
    
    static func getChangePctArray() -> [Double] {
        return changePctArray
    }
    
    static func getDataIsRetrieved() -> Bool {
        return dataIsRetrieved
    }
}
