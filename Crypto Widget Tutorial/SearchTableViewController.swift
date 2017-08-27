//
//  SearchTableViewController.swift
//  Crypto Widget Tutorial
//
//  Created by Connor Van Ooyen on 8/23/17.
//  Copyright © 2017 Connor Van Ooyen. All rights reserved.
//

import UIKit

protocol CustomCellDelegate {
    func cellButtonTapped(cell: SearchTableViewCell)
}

class SearchTableViewCell: UITableViewCell {
    
    var delegate: CustomCellDelegate?
    
    @IBOutlet weak var coinTicker: UILabel!
    @IBAction func addBtn(_ sender: AnyObject) {
        delegate?.cellButtonTapped(cell: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

class SearchTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, CustomCellDelegate, CustomSearchControllerDelegate {
    
    @IBOutlet weak var tblSearchResults: UITableView!
    var dataArray = DataArrayHelper.getDataArray()
    var filteredArray = [String]()
    var shouldShowSearchResults = false
    var searchController: UISearchController!
    var customSearchController: CustomSearchController!
    let myMainTableViewController = MainTableViewController()
    var coins = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        coins = StorageHelper.getFromStorage()
        
        tblSearchResults.delegate = self
        tblSearchResults.dataSource = self
        
        loadListOfCoins()
        
        configureCustomSearchController()
        
        //swipe right to go back
        let swipeRightVar: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        swipeRightVar.direction = .right
        self.view!.addGestureRecognizer(swipeRightVar)
        
    }
    
    //swipe right to go back
    @objc func swipeRight(sender: UIGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func cellButtonTapped(cell: SearchTableViewCell) {
        
        let indexPath = self.tableView.indexPathForRow(at: cell.center)!
        var selectedItem:String = ""
        
        if shouldShowSearchResults {
             selectedItem = filteredArray[indexPath.row]
        } else {
             selectedItem = dataArray[indexPath.row]
        }
        
        coins.append(selectedItem)
        StorageHelper.setCoinStorage(array: coins)
        
        loadListOfCoins()
        
        self.tableView.reloadData()
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
            return dataArray.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as! SearchTableViewCell
        
        cell.delegate = self
        
        //Configure the cell
        if shouldShowSearchResults {
            cell.coinTicker.text = filteredArray[indexPath.row]
        }
        else {
            cell.coinTicker.text = dataArray[indexPath.row]
        }

        return cell
    }
    
    func loadListOfCoins() {
        
        compareArrays(array1: coins, array2: &dataArray)
        
        // Reload the tableview.
        tblSearchResults.reloadData()
        
    }
    
    func compareArrays(array1: [String], array2: inout [String]) { //inout makes mutable
        
        for element in array1 {
            if array2.contains(element) {
                if let itemToRemoveIndex = array2.index(of: element) {
                    array2.remove(at: itemToRemoveIndex)
                }
            }
        }
    }
    
    func configureCustomSearchController() {
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRect(x: 0.0, y: 0.0, width: tblSearchResults.frame.size.width, height: 50.0), searchBarFont: UIFont(name: "Futura", size: 16.0)!, searchBarTextColor: UIColor.orange, searchBarTintColor: UIColor.black)
        
        customSearchController.customSearchBar.placeholder = "Enter Coin Ticker"
        tblSearchResults.tableHeaderView = customSearchController.customSearchBar
        
        customSearchController.customDelegate = self
    }
    
    // MARK: UISearchBarDelegate functions
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tblSearchResults.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tblSearchResults.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tblSearchResults.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    // MARK: UISearchResultsUpdating delegate function
    
    @available(iOS 8.0, *)
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {
            return
        }
        
        // Filter the data array and get only those coins that match the search text.
        filteredArray = dataArray.filter({ (coin) -> Bool in
            let coinText:NSString = coin as NSString
            
            return (coinText.range(of: searchString, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        // Reload the tableview.
        tblSearchResults.reloadData()
    }
    
    // MARK: CustomSearchControllerDelegate functions
    
    func didStartSearching() {
        shouldShowSearchResults = true
        tblSearchResults.reloadData()
    }
    
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tblSearchResults.reloadData()
        }
    }
    
    //click cancel to go back
    func didTapOnCancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func didChangeSearchText(searchText: String) {
        // Filter the data array and get only those countries that match the search text.
        filteredArray = dataArray.filter({ (coin) -> Bool in
            let coinText: NSString = coin as NSString
            
            return (coinText.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        // Reload the tableview.
        tblSearchResults.reloadData()
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
    
}
