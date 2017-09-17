//
//  ChanelType.swift
//  SmartRssReader
//
//  Created by Pawel Kowalczuk on 11/09/2017.
//  Copyright © 2017 appdev4everyone. All rights reserved.
//

import Foundation

protocol ChanelType {
    var url: URL { get }
}

struct RssChanel: ChanelType {
    let url: URL
}
