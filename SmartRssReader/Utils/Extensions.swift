//
//  Extensions.swift
//  SmartRssReader
//
//  Created by Pawel Kowalczuk on 25/09/2017.
//  Copyright © 2017 appdev4everyone. All rights reserved.
//

import UIKit
import Foundation

extension FileManager {
    static var documentDirectory: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
    }
}
