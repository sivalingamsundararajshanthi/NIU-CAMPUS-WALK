//
//  Event.swift
//  ShanthiDesamsettiCampusWalk
//
//  Created by siva lingam on 11/17/18.
//  Copyright © 2018 Sivalingam Sundararaj Shanthi. All rights reserved.
//

/*
 This view controller is not used
 */
import Foundation
import MapKit

class Event:NSObject{
    var latitude : CLLocationDegrees!
    var longitude : CLLocationDegrees!
    
    var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    override init() {
        super.init()
    }
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
