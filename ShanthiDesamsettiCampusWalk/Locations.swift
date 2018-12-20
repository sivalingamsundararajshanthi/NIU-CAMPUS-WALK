//
//  Locations.swift
//  ShanthiDesamsettiCampusWalk
//
//  Created by siva lingam on 11/16/18.
//  Copyright © 2018 Sivalingam Sundararaj Shanthi. All rights reserved.
//

/*
 This class is the class which is used to create location objects.
 */

import UIKit
import MapKit

class Locations : NSObject, NSCopying {
    
    //This is the copy function
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Locations(Number: Number, BuildingName: BuildingName, BuildingCode: BuildingCode, City: City, State: State, Latitude: Latitude, Longitude: Longitude, BuildingImage: BuildingImage, Facts: Facts)
        return copy
    }
    
    //Class fields
    var Number : String!
    var BuildingName : String!
    var BuildingCode : String!
    var City : String!
    var State : String!
    var Latitude : Double!
    var Longitude : Double!
    var BuildingImage : String!
    var Facts : String!
    var condition : Bool!
    
    //init function
    init(Number:String, BuildingName : String, BuildingCode:String, City:String, State:String, Latitude:Double,
         Longitude : Double, BuildingImage : String, Facts:String){
        self.Number = Number
        self.BuildingName = BuildingName
        self.BuildingCode = BuildingCode
        self.City = City
        self.State = State
        self.Latitude = Latitude
        self.Longitude = Longitude
        self.BuildingImage = BuildingImage
        self.Facts = Facts
        self.condition = true
    }
    
    //This returns the coordinate of an object
    var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Latitude, longitude: Longitude)
    }
}
