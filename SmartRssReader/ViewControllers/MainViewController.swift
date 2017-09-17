//
//  MainViewController.swift
//  SmartRssReader
//
//  Created by Pawel Kowalczuk on 11/09/2017.
//  Copyright © 2017 appdev4everyone. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ChanelReading {
    
    enum Segues {
        static let ChanelList = "ChanelList"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if provider.activeChanels().isEmpty {
//            self.performSegue(withIdentifier: Segues.ChanelList, sender: self);
//        }
    }
}
