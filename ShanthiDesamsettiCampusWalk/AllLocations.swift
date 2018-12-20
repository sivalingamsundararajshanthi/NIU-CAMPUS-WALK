//
//  AllLocations.swift
//  ShanthiDesamsettiCampusWalk
//
//  Created by siva lingam on 11/24/18.
//  Copyright © 2018 Sivalingam Sundararaj Shanthi. All rights reserved.
//

/*
 This is a class which has static fields which are used through out the app.
 */

import Foundation
import UIKit
import MapKit

class AllLocations : NSObject, NSCopying{
    
    //This is the copy function
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = AllLocations()
        return copy
    }
    
    //totalSteps to keep count of the steps taken
    static var totalSteps : Int = 0
    
    //allLocations is used to store Locations objects
    static var allLocations : [Locations] = []
    
    //This is a CLLocation object
    static var currentLocation : CLLocation?
}
