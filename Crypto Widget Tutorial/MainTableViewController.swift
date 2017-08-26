//
//  MainTableViewController.swift
//  Crypto Widget Tutorial
//
//  Created by Connor Van Ooyen on 8/22/17.
//  Copyright © 2017 Connor Van Ooyen. All rights reserved.
//

import UIKit

let defaults = UserDefaults.standard

struct defaultsKeys {
    static let coinArrayStorage = "coinArrayStorage"
    static let timesOpened = "timesOpened"
}

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

    var coins:[String] = []
    //var coinPrice = [2048.25, 12.53, 4.32, 245.65, 0.14, 2048.25, 12.53, 4.32, 245.65, 0.14]
    
    var market:[String] = []
    var price:[Double] = []
    var change:[Double] = []
    var changePct:[Double] = []
    
    /*@IBAction func toSearchTable(_ sender: Any) {
        setStorage()
        
        let viewController = SearchTableViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
           getFromStorage()
           getCryptoData()
    }
    
    func getCryptoData() {
        Crypto.getData(from: coins, to:"USD") { (results:[Crypto]) in
            //loop through results with completion handler to know when data is set
            self.dataLoop(withResults: results, completion: self.reloadTable)
        }
    }
    
    func dataLoop(withResults results:[Crypto], completion: () -> Void ) {
        for result in results {
            self.market.append(result.market)
            self.price.append(result.price.rounded(toPlaces: 2))
            self.change.append(result.change.rounded(toPlaces: 2))
            self.changePct.append(result.changePct.rounded(toPlaces: 2))
        }
        completion()
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func refresh(_ sender: Any) {
        self.tableView.reloadData()
        Crypto.getData(from: coins, to:"USD") { (results:[Crypto]) in
            //loop through results with completion handler to know when data is set
            self.dataLoop(withResults: results, completion: self.endRefreshing)
        }
    }
    
    func endRefreshing() {
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
        }
    }
    
    func getFromStorage() {
        coins = defaults.stringArray(forKey: defaultsKeys.coinArrayStorage)!
    }
    
    func setStorage() {
         if defaults.stringArray(forKey: defaultsKeys.coinArrayStorage)?.count == 0 || coins.count == 0 {
            defaults.set(["BTC", "ETH"], forKey: defaultsKeys.coinArrayStorage)
         } else {
            defaults.set(coins, forKey: defaultsKeys.coinArrayStorage)
         }
    }
    
    func getCoinArray() -> [String]{
        return coins
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {return 1}
        if section == 1 {return coins.count} //use price to ensure stuff is loaded
        
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
