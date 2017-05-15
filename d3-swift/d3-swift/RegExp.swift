//
//  RegExp.swift
//  d3-swift
//
//  Created by Steven Diviney on 14/05/2017.
//  Copyright © 2017 Steven Diviney. All rights reserved.
//

import Foundation

//TODO: Understand and rework this file.
public struct RegExp {
    let regExp: NSRegularExpression
    let pattern: String
   
    public init(pattern: String) {
        self.pattern = pattern
        do {
            try self.regExp = NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        } catch _ {
            self.regExp = NSRegularExpression()
        }
    }
    
    public func matches(_ input: String) -> [String] {
        let range = NSMakeRange(0, input.characters.count)
        return regExp.matches(in: input, options: .withoutAnchoringBounds, range: range)
            .map { (input as NSString).substring(with: $0.range) }
    }
    
    public func test(_ input: String) -> Bool {
        let range = NSMakeRange(0, input.characters.count)
        return self.regExp.numberOfMatches(in: input, options: .withoutAnchoringBounds, range: range) > 0
    }
    
    public func test(_ input: Character) -> Bool {
        return self.test(String(input))
    }
    
    
}

extension String {
    func regExp() -> RegExp {
        return RegExp(pattern: self)
    }
    
    func splitBy(_ token: String) -> [String] {
        return self.characters.split { String($0) == token}.map { String.init($0) }
    }
}

extension Array {
    func chunk(chunkSize: Int) -> Array<Array<Element>> {
        return stride(from: 0, to: self.count, by: chunkSize)
            .map { Array(self[$0..<$0.advanced(by: chunkSize)])}
    }
}
