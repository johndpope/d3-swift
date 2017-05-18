//
//  Logger.swift
//  d3-swift
//
//  Created by Steven Diviney on 18/05/2017.
//  Copyright © 2017 Steven Diviney. All rights reserved.
//

import UIKit

class Logger {
    
    public static var enabled = true
    
    public static func debug(_ string: String) {
        if Logger.enabled { print(string) }
    }

}
