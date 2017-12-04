//
//  FeedType.swift
//  SmartRssReader
//
//  Created by Pawel Kowalczuk on 16/09/2017.
//  Copyright © 2017 appdev4everyone. All rights reserved.
//

import Foundation

struct Feed {
    let title: String
    let link: String
    let pubDate: String
    
    init(title: String, link: String, pubDate: String) {
        
        self.title = title
        self.link = link
        self.pubDate = pubDate
    }
    
    init?(title: String?, link: String?, pubDate: String?) {
        guard let title = title,
              let link = link,
              let pubDate = pubDate else { return nil }
        
        self.title = title
        self.link = link
        self.pubDate = pubDate
    }
}

extension Feed {
    var viewModel: FeedCellViewModel {
        return FeedCellViewModel(title: title, description: link, feed: self)
    }
}
