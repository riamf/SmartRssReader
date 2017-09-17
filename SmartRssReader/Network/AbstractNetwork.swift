//
//  AbstractNetwork.swift
//  SmartRssReader
//
//  Created by Pawel Kowalczuk on 16/09/2017.
//  Copyright © 2017 appdev4everyone. All rights reserved.
//

import Foundation

typealias FetchFeedsCompletion = ((Result<[Feed], NetworkError>) -> ())

protocol AbstractNetwork {
    
    func fetchFeeds(from: ChanelType, completion: @escaping FetchFeedsCompletion) -> URLSessionTask
}

class Network: AbstractNetwork {
    
    private lazy var session: URLSession = {
        return URLSession(configuration: URLSessionConfiguration.default)
    }()
    
    private lazy var requestFactory: RequestFactoryType = {
       return RequestFactory()
    }()
    
    @discardableResult
    func fetchFeeds(from: ChanelType, completion: @escaping FetchFeedsCompletion) -> URLSessionTask {
        
        let request = requestFactory.request(with: from)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.error(.httpCode(error.localizedDescription)))
                return
            } else if let data = data {
                completion(.success([]))
                return
            }
            
            completion(.error(.unknown))
        }
        
        task.resume()
        
        return task
    }
}
