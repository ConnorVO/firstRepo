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

    var coins:[String] = [String]()
    //var coinPrice = [2048.25, 12.53, 4.32, 245.65, 0.14, 2048.25, 12.53, 4.32, 245.65, 0.14]
    
    var market:[String] = [String]()
    var price:[Double] = [Double]()
    var change:[Double] = [Double]()
    var changePct:[Double] = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Load: ", coins)
        CryptoDataGetter.getCryptoData(from: coins)
        setDataVariables()
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CryptoDataGetter.getCryptoData(from: coins) //in here for coming back from SearchTable
        setDataVariables()
        self.tableView.reloadData()
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func refresh(_ sender: Any) {
        CryptoDataGetter.getCryptoData(from: coins)
        self.tableView.reloadData()
    }
    
    func endRefreshing() {
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
        }
    }
    
    func setDataVariables() {
        coins = StorageHelper.getFromStorage()
        market = CryptoDataGetter.getMarketArray()
        price = CryptoDataGetter.getPriceArray()
        change = CryptoDataGetter.getChangeArray()
        changePct = CryptoDataGetter.getChangePctArray()
        print("Price: ", market.count)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {return 1}
        if section == 1 {
            
            if(CryptoDataGetter.getDataIsRetrieved()) {
                 setDataVariables()
                 return coins.count
            } else {
                return 0
            }
            
        }
        
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
        
        setDataVariables() //have to call here because variables not being set properly?
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "graphCell", for: indexPath) as! MainGraphTableViewCell

            // Configure the cell...
            
            

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
            cell.coinTicker?.text = coins[indexPath.row]
            cell.coinPrice?.text = String(price[indexPath.row])
            cell.percentChange?.text = String(changePct[indexPath.row]) + "%"
            
            endRefreshing()
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
            price.remove(at: indexPath.row)
            change.remove(at: indexPath.row)
            market.remove(at: indexPath.row)
            changePct.remove(at: indexPath.row)
            
            StorageHelper.setCoinStorage(array: coins)
            
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
