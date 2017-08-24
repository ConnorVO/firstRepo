//
//  ViewController.swift
//  Crypto Widget Tutorial
//
//  Created by Connor Van Ooyen on 8/21/17.
//  Copyright © 2017 Connor Van Ooyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func btn(_ sender: Any) {
        print(market)
        print(price)
        print(change)
        print(changePct)
    }
    
    var market:String = ""
    var price:Double = 0.00
    var change:Double = 0.00
    var changePct:Double = 0.00
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Crypto.getData(from: "BTC", to:"USD") { (results:[Crypto]) in
            //loop through results with completion handler to know when data is set
            self.dataLoop(withResults: results, completion: self.printVariables)
        }
    }
    
    func dataLoop(withResults results:[Crypto], completion: () -> Void ) {
        for result in results {
            self.market = result.market
            self.price = result.price
            self.change = result.change
            self.changePct = result.changePct
            // print("\(result)\n\n")
        }
        completion()
    }
    
    func printVariables() {
        print(market)
        print(price.rounded(toPlaces: 2))
        print(change.rounded(toPlaces: 2))
        print(changePct.rounded(toPlaces: 2))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
