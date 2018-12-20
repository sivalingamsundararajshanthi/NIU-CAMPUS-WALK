//
//  FirstViewController.swift
//  ShanthiDesamsettiCampusWalk
//
//  Created by siva lingam on 11/24/18.
//  Copyright © 2018 Sivalingam Sundararaj Shanthi. All rights reserved.
//

/*
 This view controller is not used
 */

import UIKit
import MapKit

class FirstViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetchJSON()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchJSON(){
        guard let api_url = URL(string: "http://faculty.cs.niu.edu/~krush/f18/niucampus-json") else {
            return
        }
        
        let urlRequest = URLRequest(url: api_url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let content = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: content) as? [[String:[Any]]]
                    
                    for i in json! {
                        if let weather = i["NIU Partial Campus"] as? [[String: String]] {
                            
                            for location in weather{
                                
                                if let number = location["Number"], let name = location["BuildingName"],
                                    let code = location["BuildingCode"], let city = location["City"], let state = location["State"], let lat = location["Latitude"], let long = location["Longitude"], let image = location["BuildingImage"], let fact = location["Facts"] {
                                    
                                    AllLocations.allLocations.append(Locations(Number: number, BuildingName: name, BuildingCode: code, City: city, State: state, Latitude: Double(lat)!, Longitude: Double(long)!, BuildingImage: image, Facts: fact))
                                }
                            }
                        }
                    }
                }
                catch {
                    print(error)
                }
            }
        }
        task.resume()
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
