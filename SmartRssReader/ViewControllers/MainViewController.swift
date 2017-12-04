//
//  MainViewController.swift
//  SmartRssReader
//
//  Created by Pawel Kowalczuk on 11/09/2017.
//  Copyright © 2017 appdev4everyone. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ChanelReading {
    
    enum Segues {
        static let ChanelList = "ChanelList"
    }
    
    @IBOutlet private weak var table: UITableView!
    fileprivate lazy var network: AbstractNetwork = {
        return Network()
    }()
    fileprivate var feeds = [Feed]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        table.dataSource = self
        table.rowHeight = UITableViewAutomaticDimension
        setupData()
    }
    private func setupData() {
     
        let url = URL(string: "https://news.ycombinator.com/rss")!
        let channel = RssChanel(url: url)
        
        _ = network.fetchFeeds(from: channel) { [weak self] result in
            switch result {
            case .success(let feeds):
                self?.feeds = feeds
                self?.table.reloadData()
            case .error(let error):
                print("FAILED TO DOWNLOAD FEEDS WITH ERROR: \(error.localizedDescription)")
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(FeedCell.self)")
        (cell as? FeedCell)?.load(viewModel: feeds[indexPath.row].viewModel, feedAdding: self)
        return cell!
    }
}

extension MainViewController: FeedAdding, StoreProviding {
    func add(feed: Feed) {
        store.add(feed: feed)
    }
}
