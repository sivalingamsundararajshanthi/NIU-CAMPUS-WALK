//
//  ViewController2.swift
//  ShanthiDesamsettiCampusWalk
//
//  Created by siva lingam on 11/26/18.
//  Copyright © 2018 Sivalingam Sundararaj Shanthi. All rights reserved.
//

import UIKit
import WebKit

class ViewController2: UIViewController {

    @IBOutlet var harshithWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create a path to fetch the content/data of the index.html file as part of project app bundle
        let path = Bundle.main.path(forResource: "index", ofType: ".html")!
        
        let data:Data = try! Data(contentsOf: URL(fileURLWithPath: path))
        
        //The "html" constant variable now has the data/content we want to load
        let html = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        
        //Load the content of the index.html file into the authorView
        harshithWebView.loadHTMLString(html! as String, baseURL: Bundle.main.bundleURL)

        // Do any additional setup after loading the view.
    }
}
