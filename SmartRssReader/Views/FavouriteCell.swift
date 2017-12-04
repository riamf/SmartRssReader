//
//  FavouriteCell.swift
//  SmartRssReader
//
//  Created by Pawel Kowalczuk on 28/09/2017.
//  Copyright © 2017 appdev4everyone. All rights reserved.
//

import UIKit

final class FavouriteCell: UITableViewCell {
    
    func load(with feed: Feed) {
        textLabel?.text = feed.title
    }
    
}
