//
//  svg.swift
//  d3-swift
//
//  Created by Steven Diviney on 14/05/2017.
//  Copyright © 2017 Steven Diviney. All rights reserved.
//

import UIKit

public enum SVG {
    public struct Command {
        let code: String
        let args: [Double]
        
        public init(code: String, args: String) {
            self.code = code
            self.args = args.splitBy(",").map { Double($0)! }
        }
    
        public static func pathToCommands(path: String) -> [Command] {
            let tokens = "([a-m])|(([0-9\\.]+,?)+)".regExp().matches(path)
            return tokens.chunk(chunkSize: 2).map { Command(code: $0[0], args: $0[1]) }
        }
        
        public var op: (_ bezierPath: UIBezierPath) -> Void {
            get {
                let args = self.args
                switch code {
                    case "M":
                        return { $0.move(to: CGPoint(x: args[0], y: args[1])) }
                    case "L":
                        return { $0.addLine(to: CGPoint(x: args[0], y: args[1])) }
                    case "C":
                        return { $0.addCurve(to: CGPoint(x: args[4], y: args[5]),
                                             controlPoint1: CGPoint(x: args[0], y: args[1]),
                                             controlPoint2: CGPoint(x: args[2], y: args[3])) }
                default:
                    return { _ in }
                }
            }   
        }
    }
    
    static func getPathFromCommands(commands: [Command]) -> UIBezierPath {
        let path = UIBezierPath()
        for c in commands {
            c.op(path)
        }
        
        return path
    }
}
