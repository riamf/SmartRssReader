//
//  FeedCell.swift
//  SmartRssReader
//
//  Created by Pawel Kowalczuk on 18/09/2017.
//  Copyright © 2017 appdev4everyone. All rights reserved.
//

import UIKit

protocol FeedAdding: class {
    func add(feed: Feed)
}

final class FeedCell: UITableViewCell {
    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var desc: UILabel!
    private var feed: Feed?
    private weak var delegate: FeedAdding?
    
    func load(viewModel: FeedCellViewModel, feedAdding: FeedAdding?) {
        delegate = feedAdding
        feed = viewModel.feed
        title.text = viewModel.title
        desc.text = viewModel.description
    }
    
    @IBAction private func addItem() {
        guard let feed = feed else { return }
        delegate?.add(feed: feed)
    }
}

struct FeedCellViewModel {
    let title: String
    let description: String
    let feed: Feed
}
