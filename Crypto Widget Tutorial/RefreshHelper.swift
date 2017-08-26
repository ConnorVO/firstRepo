//
//  RefreshHelper.swift
//  Crypto Widget Tutorial
//
//  Created by Connor Van Ooyen on 8/26/17.
//  Copyright © 2017 Connor Van Ooyen. All rights reserved.
//

import Foundation
import UIKit

class RefreshHelper {
    
    static let myMainTableViewController = MainTableViewController()
    
    static func sideThreadReload(viewController: TableViewController) {
        DispatchQueue.main.async {
            viewController.tableView.reloadData()
        }
    }
    
    @objc static func refresh(_ sender: Any, viewController: TableViewController) {
        viewController.tableView.reloadData()
        
        CryptoDataGetter.getCryptoData(from: myMainTableViewController.coins)
    }
    
    static func endRefreshing(viewController: TableViewController) {
        DispatchQueue.main.async {
            viewController.refreshControl?.endRefreshing()
        }
    }
}
