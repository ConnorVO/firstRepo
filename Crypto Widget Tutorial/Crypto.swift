//
//  Crypto.swift
//  Crypto Widget Tutorial
//
//  Created by Connor Van Ooyen on 8/22/17.
//  Copyright © 2017 Connor Van Ooyen. All rights reserved.
//

import Foundation

struct Crypto: Codable {
    let market: String //add ? after to allow for JSON structures that don't include one of these
    let price: Double
    let change: Double
    let changePct: Double
    
    enum SerializationError:Error {
        case missing(String)
    }
    
    init(json:[String:Any]) throws {
        guard let market = json["MARKET"] as? String else {throw SerializationError.missing("market is missing")}
        
        guard let price = json["PRICE"] as? Double else {throw SerializationError.missing("price is missing")}
        
        guard let change = json["CHANGE24HOUR"] as? Double else {throw SerializationError.missing("change is missing")}
        
        guard let changePct = json["CHANGEPCT24HOUR"] as? Double else {throw SerializationError.missing("change percent is missing")}
        
        self.market = market
        self.price = price
        self.change = change
        self.changePct = changePct
        
    }
    
    static func getData (from:String, to:String, completion: @escaping ([Crypto]) -> ()) {
        
        let url = "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=\(from)&tsyms=\(to)"
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var cryptoArray:[Crypto] = []
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let raw = json["RAW"] as? [String:Any] {
                            if let btc = raw["BTC"] as? [String:Any] {
                                if let usd = btc["USD"] as? [String:Any] {
                                    if let cryptoObject = try? Crypto(json: usd) {
                                        cryptoArray.append(cryptoObject)
                                    }
                                }
                            }
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
                completion(cryptoArray)
                
            }
        }
        task.resume()
    }
    
}
