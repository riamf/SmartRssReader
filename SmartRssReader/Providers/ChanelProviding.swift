//
//  ChanelProviding.swift
//  SmartRssReader
//
//  Created by Pawel Kowalczuk on 11/09/2017.
//  Copyright © 2017 appdev4everyone. All rights reserved.
//

import Foundation

protocol ChanelReading {
    var provider: ChanelProviding { get }
}

extension ChanelReading {
    var provider: ChanelProviding { return ChanelProvider() }
}

protocol ChanelProviding {
    func activeChanels() -> [ChanelType]
}

class ChanelProvider: ChanelProviding {
    func activeChanels() -> [ChanelType] {
        //TODO: logic to load chanels.
        return []
    }
}
