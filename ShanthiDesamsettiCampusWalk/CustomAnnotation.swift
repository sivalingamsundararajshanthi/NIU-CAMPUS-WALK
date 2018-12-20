//
//  CustomAnnotation.swift
//  ShanthiDesamsettiCampusWalk
//
//  Created by siva lingam on 11/16/18.
//  Copyright © 2018 Sivalingam Sundararaj Shanthi. All rights reserved.
//

/*
 This view controller is not used
 */

import UIKit
import MapKit

class CustomAnnotation : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate : CLLocationCoordinate2D, title : String, subtitle : String){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
