//
//  ViewController.swift
//  d3-swift
//
//  Created by Steven Diviney on 13/05/2017.
//  Copyright © 2017 Steven Diviney. All rights reserved.
//

import UIKit
import JavaScriptCore
import SVGKit
import AEXML

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let jsCode = Loader.readJS(file: "test")
        let d3Code = Loader.readJS(file: "d3.v4.min")
        
        let jc = JSContext()!
        jc.exceptionHandler = { context, exception in
            print("JS Error: \(exception?.description)")
        }
        jc.evaluateScript(d3Code!)
        jc.evaluateScript(jsCode!)
        
        let getPathFunc = jc.objectForKeyedSubscript("getPath")!
        
        let result = getPathFunc.call(withArguments: [[10, 200, 3, 29, 4, 8, 20, 0, 4], [200, 200]])!
        print(result)
        
        
        let rect = CGRect(x: 0, y: 0, width: 200, height: 200)
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.red.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.backgroundColor = UIColor.white.cgColor
        
        layer.path = SVG.getPathFromCommands(commands: SVG.Command.pathToCommands(path: result.toString())).cgPath
        
        let view = UIView(frame: rect)
        view.backgroundColor = UIColor.white
        view.layer.addSublayer(layer)
    
        self.view.addSubview(view)
       
        var svg = AEXMLDocument()
        let svgAttr = ["width": "200px", "height": "200px", "xmlns":"http://www.w3.org/2000/svg", "version":"1.1"]
        let body = svg.addChild(name: "svg", attributes: svgAttr)
        //body.addChild(name: "rect", attributes: ["x": "0", "y":"0", "width":"100", "height":"50"])
        body.addChild(name: "path", attributes: ["d":result.toString()])
        
        
        let image = SVGKImage(data: svg.xml.data(using: .utf8))
        
        let uiImage = image?.uiImage!
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

