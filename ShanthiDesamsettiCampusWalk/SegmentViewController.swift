//
//  SegmentViewController.swift
//  ShanthiDesamsettiCampusWalk
//
//  Created by siva lingam on 11/27/18.
//  Copyright © 2018 Sivalingam Sundararaj Shanthi. All rights reserved.
//This is the current copy

/*
 This view controller is used for the about author view. This view has a segmented control to show information about the
 authors of the app.
 */

import UIKit
import WebKit

class SegmentViewController: UIViewController {
    
    //Outlet for the web view
    @IBOutlet weak var webView: WKWebView!
    
    //Outlet for the segmented control
    @IBOutlet weak var segOutlet: UISegmentedControl!
    
    //IBAction for the segmented control
    @IBAction func segControl(_ sender: UISegmentedControl) {
        
        //Get the index of the segment that the user clicked
        let index = segOutlet.selectedSegmentIndex
        
        //Switch case to display the author information
        switch(index){
        case 0:
            let path = Bundle.main.path(forResource: "index1", ofType: ".html")!
            
            let data:Data = try! Data(contentsOf: URL(fileURLWithPath: path))
            
            //The "html" constant variable now has the data/content we want to load
            let html = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            
            //Load the content of the index.html file into the authorView
            webView.loadHTMLString(html! as String, baseURL: Bundle.main.bundleURL)
            
        case 1:
            let path = Bundle.main.path(forResource: "index", ofType: ".html")!
            
            let data:Data = try! Data(contentsOf: URL(fileURLWithPath: path))
            
            //The "html" constant variable now has the data/content we want to load
            let html = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            
            //Load the content of the index.html file into the authorView
            webView.loadHTMLString(html! as String, baseURL: Bundle.main.bundleURL)
            
        default:
            print("Nothing selected")
        }
    }
    
    //View did load function
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "index1", ofType: ".html")!
        
        let data:Data = try! Data(contentsOf: URL(fileURLWithPath: path))
        
        //The "html" constant variable now has the data/content we want to load
        let html = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        
        //Load the content of the index.html file into the authorView
        webView.loadHTMLString(html! as String, baseURL: Bundle.main.bundleURL)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
