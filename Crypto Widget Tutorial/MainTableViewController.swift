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

    var coins = ["BTC", "KRX", "ZRC", "ETH", "XRP", "BTC", "KRX", "ZRC", "ETH", "XRP"]
    var coinPrice = [2048.25, 12.53, 4.32, 245.65, 0.14, 2048.25, 12.53, 4.32, 245.65, 0.14]
    
    //var searchBar:UISearchBar = UISearchBar()

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {return 1}
        if section == 1 {return coins.count}
        
        return 30
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setup()
    }*/
    
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
            cell.coinPrice?.text = String(coinPrice[indexPath.row])
            cell.percentChange?.text = "+0.14%"
            
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
    
   /* func setup() {
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(down))
        swipeDown.direction = .down
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(up))
        swipeUp.direction = .up
        
        self.view.addGestureRecognizer(swipeDown)
        self.view.addGestureRecognizer(swipeUp)
        
        searchBar = UISearchBar(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: 40.0))
        
        searchBar.backgroundColor = UIColor.red
        self.view.addSubview(searchBar)
        
        
    }*/
    
    /* @objc func down(sender: UIGestureRecognizer) {
        print("down")
        //show bar
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.searchBar.frame = CGRect(x: 0.0, y: 64.0, width: self.view.frame.width, height: 40.0)
        }, completion: { (Bool) -> Void in
        })
    }
    
    @objc func up(sender: UIGestureRecognizer) {
        print("up")
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.searchBar.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 40.0)
        }, completion: { (Bool) -> Void in
        })
    } */
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
