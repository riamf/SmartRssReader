//
//  Parser.swift
//  SmartRssReader
//
//  Created by Pawel Kowalczuk on 17/09/2017.
//  Copyright © 2017 appdev4everyone. All rights reserved.
//

import Foundation
import AEXML

class FeedParser {
    
    enum Keys {
        static let channel = "channel"
        static let item = "item"
        static let title = "title"
        static let link = "link"
        static let pubdate = "pubDate"
    }
    
    func parse(data: Data) -> [Feed] {
        
        guard let xmlDocument = try? AEXMLDocument(xml: data) else { return [] }
        
        let channel = xmlDocument.root[Keys.channel]
        var feeds = [Feed]()
        for item in channel.children where item.name == Keys.item {
            
            let value = item.children.first(where: {$0.name == Keys.title})?.value
            let link = item.children.first(where: {$0.name == Keys.link})?.value
            let pubDate = item.children.first(where: {$0.name == Keys.pubdate})?.value
            
            if let feed = Feed(title: value,
                            link: link,
                            pubDate: pubDate) {
                feeds.append(feed)
            }
        }
        return feeds
    }
}
