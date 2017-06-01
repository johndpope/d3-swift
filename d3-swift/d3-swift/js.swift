//
//  Loader.swift
//  d3-swift
//
//  Created by Steven Diviney on 14/05/2017.
//  Copyright © 2017 Steven Diviney. All rights reserved.
//

import UIKit
import JavaScriptCore

//TODO: Rename this as JavaScript environment or loader or somthing generic
// Move the d3 shit elsewhere
struct js {
    
    let jsContext: JSContext
    
    init() {
        jsContext = JSContext()
        jsContext.exceptionHandler = { context, exception in
            Logger.debug("JS Error: \(String(describing: exception?.description))")
        }
        
        //TODO: Put this else where
        load("d3.v4.min")
    }
    
    // Load a java script file the context
    @discardableResult public func load(_ file: String) -> JSValue? {
        guard let script = js.readJS(file: file) else {
            Logger.debug("\(file) could not be loaded")
            return nil
        }
        return jsContext.evaluateScript(script)
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
