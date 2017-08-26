//
//  RefreshController.swift
//  Crypto Widget Tutorial
//
//  Created by Connor Van Ooyen on 8/26/17.
//  Copyright © 2017 Connor Van Ooyen. All rights reserved.
//

import UIKit

class RefreshController: UIViewController {
    
    let myMainTableViewController = MainTableViewController()
    
    func tableReload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func refresh(_ sender: Any) {
        viewController.tableView.reloadData()
        
        CryptoDataGetter.getCryptoData(from: myMainTableViewController.coins)
    }
    
    func endRefreshing() {
        DispatchQueue.main.async {
            viewController.refreshControl?.endRefreshing()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
