//
//  Loader.swift
//  d3-swift
//
//  Created by Steven Diviney on 14/05/2017.
//  Copyright © 2017 Steven Diviney. All rights reserved.
//

import UIKit

struct Loader {
    
    static func readJS(file: String) -> String? {
        if
            let path = Bundle.main.path(forResource: file, ofType: "js"),
            let data = try? String(contentsOfFile: path, encoding: .utf8) {
                return data
        }
        
        return nil
    }
    
}
