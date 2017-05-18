//
//  Loader.swift
//  d3-swift
//
//  Created by Steven Diviney on 14/05/2017.
//  Copyright © 2017 Steven Diviney. All rights reserved.
//

import UIKit
import JavaScriptCore

struct D3 {
    
    let jsContext: JSContext
    
    init() {
        jsContext = JSContext()
        jsContext.exceptionHandler = { _, exception in
            Logger.debug("JS Error: \(String(describing: exception?.description))")
        }
        
        load("d3.v4.min")
    }
    
    // Load a java script file the context
    public func load(_ file: String) {
        guard let script = D3.readJS(file: file) else {
            Logger.debug("\(file) could not be loaded")
            return
        }
        jsContext.evaluateScript(script)
    }
    
    private static func readJS(file: String) -> String? {
        if
            let path = Bundle.main.path(forResource: file, ofType: "js"),
            let data = try? String(contentsOfFile: path, encoding: .utf8) {
                return data
        }
        
        return nil
    }
   
}
