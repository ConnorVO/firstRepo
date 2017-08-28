//
//  DataArrayHelper.swift
//  Crypto Widget Tutorial
//
//  Created by Connor Van Ooyen on 8/26/17.
//  Copyright © 2017 Connor Van Ooyen. All rights reserved.
//

import Foundation

//array of coins currently available in the app
class DataArrayHelper {
    
    static let dataArray = ["XVC", "XMR", "LSK", "DCR", "DASH", "ZEC", "XPM", "REP", "PPC", "STR", "VIA", "NMC", "SC", "STEEM", "EXP", "FCT", "FLO", "MAID", "ARDR", "GRC", "VRC", "CLAM", "SYS", "STRAT", "BTS", "BCY", "GNO", "LBC", "FLDC", "BURST", "HUC", "PASC", "DGB", "RIC", "XBC", "XCP", "BLK", "BELA", "XEM", "BCN", "PINK", "NXT", "ETC", "GAME", "SJCX", "GNT", "LTC", "NAV", "AMP", "BCH", "ETH", "BTCD", "NOTE", "XRP", "SBD", "NEOS", "DOGE", "VTC", "NXC", "RADS", "BTM", "EMC2", "ZRX", "POT", "NAUT", "OMNI", "ZEC", "BCH", "LSK", "GNT", "REP", "ETC", "GNO", "STEEM", "LTC", "DASH", "ZEC", "NXT", "BLK", "BTCD", "BCN", "MAID", "BTC", "XMR", "ETH", "BCH", "XRP", "ZEC", "DASH", "LTC", "ETC", "NXT", "REP", "STR"]
    
    static func getDataArray() -> [String] {
        return dataArray
    }
}
