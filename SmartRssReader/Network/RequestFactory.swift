//
//  RequestFactory.swift
//  SmartRssReader
//
//  Created by Pawel Kowalczuk on 17/09/2017.
//  Copyright © 2017 appdev4everyone. All rights reserved.
//

import Foundation

protocol RequestFactoryType {
    func request(with channel: ChanelType) -> URLRequest
}

class RequestFactory: RequestFactoryType {
    
    func request(with channel: ChanelType) -> URLRequest {
        let request = URLRequest(url: channel.url)
        return request
    }
}
