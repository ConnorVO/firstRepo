//
//  MainTableView.swift
//  Crypto Widget Tutorial
//
//  Created by Connor Van Ooyen on 8/22/17.
//  Copyright © 2017 Connor Van Ooyen. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coinTicker: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    @IBOutlet weak var percentChange: UILabel!
    
}


class MainTableView: UITableView {

    var coins = ["BTC", "KRX", "ZRC", "ETH", "XRP"]
    var coinPrice = [2048.25, 12.53, 4.32, 245.65, 0.14]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CarTableViewCell
        
        // Configure the cell...
        cell.coinTicker?.text = coins[indexPath.row]
        cell.coinPrice?.text = String(coinPrice[indexPath.row])
        cell.percentChange?.text = "+0.14%"
        
        return cell
    }

}
