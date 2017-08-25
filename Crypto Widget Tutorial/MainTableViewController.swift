//
//  MainTableViewController.swift
//  Crypto Widget Tutorial
//
//  Created by Connor Van Ooyen on 8/22/17.
//  Copyright © 2017 Connor Van Ooyen. All rights reserved.
//

import UIKit

class MainGraphTableViewCell: UITableViewCell {
    
}

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var coinTicker: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    @IBOutlet weak var percentChange: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class MainTableViewController: UITableViewController {

    var coins = ["BTC", "ZRC", "ETH", "XRP", "BTC", "ZRC", "ETH", "XRP"]
    //var coinPrice = [2048.25, 12.53, 4.32, 245.65, 0.14, 2048.25, 12.53, 4.32, 245.65, 0.14]
    
    var market:[String] = []
    var price:[Double] = []
    var change:[Double] = []
    var changePct:[Double] = []
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Crypto.getData(from: coins, to:"USD") { (results:[Crypto]) in
            //loop through results with completion handler to know when data is set
            self.dataLoop(withResults: results, completion: self.printVariables)
        }
    }
    
    func dataLoop(withResults results:[Crypto], completion: () -> Void ) {
        print("Results: ", results)
        for result in results {
            self.market.append(result.market)
            self.price.append(result.price.rounded(toPlaces: 2))
            self.change.append(result.change.rounded(toPlaces: 2))
            self.changePct.append(result.changePct.rounded(toPlaces: 2))
        }
        completion()
    }
    
    func printVariables() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        /*for var i in 0..<market.count {
            print("Market: ", market[i])
            print("Price: ", price[i].rounded(toPlaces: 2))
            print("Change: ", change[i].rounded(toPlaces: 2))
            print("ChangePct: ", changePct[i].rounded(toPlaces: 2))
        }*/
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {return 1}
        if section == 1 {return price.count} //use price to ensure stuff is loaded
        
        return 30
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "graphCell", for: indexPath) as! MainGraphTableViewCell

            // Configure the cell...
            
            

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
            
            cell.coinTicker?.text = coins[indexPath.row]
            cell.coinPrice?.text = String(price[indexPath.row])
            cell.percentChange?.text = String(changePct[indexPath.row]) + "%"
            
             return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //if graph cell
        if(indexPath.section == 0) {
            let screenSize = UIScreen.main.bounds
            let screenHeight = screenSize.height
            
            //set height to half of screen
            return screenHeight / 2
        }
        
        //default height
        return 44
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            tableView.beginUpdates()
            
            coins.remove(at: indexPath.row)
            
            // Note that indexPath is wrapped in an array:  [indexPath]
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            tableView.endUpdates()
        }
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
