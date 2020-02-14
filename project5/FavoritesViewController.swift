//
//  FavoritesViewController.swift
//  project5
//
//  Created by Wenzhe Liu on 2/11/20.
//  Copyright © 2020 Wenzhe Liu. All rights reserved.
//

import UIKit

class FavoritesViewController: UITableViewController {
    weak var delegate: PlacesFavoritesDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        delegate?.favoritePlace(name: "delegate call")

        
    }

    // MARK: - Table view data source

    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedInstance.favourites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pictures", for : indexPath)
        cell.textLabel?.text = DataManager.sharedInstance.favourites[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(DataManager.sharedInstance.listFavorites()[indexPath.row].name!)
        delegate?.favoritePlace(name: DataManager.sharedInstance.listFavorites()[indexPath.row].name!)
        self.dismiss(animated: true, completion: nil)
    }

}

