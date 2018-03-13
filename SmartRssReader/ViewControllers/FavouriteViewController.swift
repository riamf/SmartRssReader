//
//  FavouriteViewController.swift
//  SmartRssReader
//
//  Created by Pawel Kowalczuk on 27/09/2017.
//  Copyright © 2017 appdev4everyone. All rights reserved.
//

import UIKit

class FavouriteViewController : UIViewController, StoreProviding {
    
    @IBOutlet private var tableView: UITableView!
    fileprivate var feeds: [Feed] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        feeds = store.getAllFeeds()
        tableView.reloadData()
    }
}

extension FavouriteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavouriteCell.self)") as! FavouriteCell
        cell.load(with: feeds[indexPath.row])
        return cell
    }
}
