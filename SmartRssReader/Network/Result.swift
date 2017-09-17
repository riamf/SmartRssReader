//
//  Result.swift
//  SmartRssReader
//
//  Created by Pawel Kowalczuk on 17/09/2017.
//  Copyright © 2017 appdev4everyone. All rights reserved.
//

import Foundation


enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case error(Error)
    
    init(value: Value) {
        self = .success(value)
    }
    
    init(error: Error) {
        self = .error(error)
    }
}

enum NetworkError: Swift.Error {
    case noData(String)
    case parse(String)
    case connection(String)
    case httpCode(String)
    case unknown
}

