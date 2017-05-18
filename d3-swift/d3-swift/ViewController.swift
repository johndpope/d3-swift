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
        let d3 = D3()
        d3.load("test")
        
        
        let getPathFunc = d3.jsContext.objectForKeyedSubscript("getPath")!
        
        let result = getPathFunc.call(withArguments: [[10, 200, 3, 29, 4, 8, 20, 0, 4], [200, 200]])!
        print(result)
        
        var svg = AEXMLDocument()
        let svgAttr = ["width": "200px", "height": "200px", "xmlns":"http://www.w3.org/2000/svg", "version":"1.1"]
        let body = svg.addChild(name: "svg", attributes: svgAttr)
        //body.addChild(name: "rect", attributes: ["x": "0", "y":"0", "width":"100", "height":"50"])
        body.addChild(name: "path", attributes: ["d":result.toString()])
        
        
        let image = SVGKImage(data: svg.xml.data(using: .utf8))
        
        let uiImage = image?.uiImage!
        let imageView = UIImageView(image: uiImage)
        
        self.view.addSubview(imageView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

