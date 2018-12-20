//
//  LongMapController.swift
//  ShanthiDesamsettiCampusWalk
//
//  Created by siva lingam on 11/19/18.
//  Copyright © 2018 Sivalingam Sundararaj Shanthi. All rights reserved.
//  This is version 1

/*
 This view controller is associated with the LongMap view which is used to display a route for all the 28 buildings.
 */

import UIKit
import MapKit
import CoreLocation

class LongMapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, MyProtocol1 {
    
    //Variable, arrays
    var testSend : Bool?
    var backArray1 = [Locations]()
    var currentArray = [Locations]()
    var coordinates = [CLLocationCoordinate2D]()
    var curLocation : CLLocation?
    var testRefresh : Bool?
    
    //Outlet for the map view
    @IBOutlet weak var longMapView: MKMapView!
    
    //Outlet for the refreshButton
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    //IBAction for the refreshButton
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        print("refresh")
        
        if(testRefresh)!{
            print("true")
            //longarray()
            
            let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.015, longitudeDelta: 0.015)
            let currentLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(curLocation!.coordinate.latitude, curLocation!.coordinate.longitude)
            let region:MKCoordinateRegion = MKCoordinateRegion.init(center: currentLocation, span: span)
            longMapView.setRegion(region, animated: true)
            
            // Display the location on the map
            self.longMapView.showsUserLocation = true
            
            //Removing the overlays from the map
            self.longMapView.removeOverlays(self.longMapView.overlays)
            
            //Getting the coordinates from the location objects in backArray1
            coordinates = backArray1.map({$0.coordinates})
            
            print("long appear " + coordinates.count.description)
            
            if(coordinates.count == 0){
                //Do nothing
            } else {
                let q0 = DispatchQueue(label: "call")
                q0.async {
                    //Function call to getClosestLocation
                    self.getClosestLocation(location: (self.curLocation?.coordinate)!, locations: self.coordinates)
                }
            }
            
            //Disabling the left navigation bar button
            self.navigationItem.leftBarButtonItem?.isEnabled = false
        } else {
            //longarray()
            
            //Setting the zoom level
            let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.015, longitudeDelta: 0.015)
            
            //Getting the coordinate
            let currentLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(curLocation!.coordinate.latitude, curLocation!.coordinate.longitude)
            
            //Setting the region
            let region:MKCoordinateRegion = MKCoordinateRegion.init(center: currentLocation, span: span)
            longMapView.setRegion(region, animated: true)
            
            // Display the location on the map
            self.longMapView.showsUserLocation = true
            
            //Remove any overlays from the map
            self.longMapView.removeOverlays(self.longMapView.overlays)
            
            //Getting the coordinates from the location objects in the currentArray
            coordinates = currentArray.map({$0.coordinates})
            
            print("long load " + coordinates.count.description)
            
            if(coordinates.count == 0){
                //Do nothing
            } else {
                let q0 = DispatchQueue(label: "call")
                q0.async {
                    //Function call to getClosestLocation
                    self.getClosestLocation(location: (self.curLocation?.coordinate)!, locations: self.coordinates)
                }
            }
            
            //Disabling the left navigation bar item
            self.navigationItem.leftBarButtonItem?.isEnabled = false
        }
    }
    
    //This function is used to recieve an array and two booleans from the LongSwitchViewController
    func setResultOfBusinessLogic1(array: [Locations], test: Bool, testR : Bool) {
        testSend = test
        backArray1 = array
        testRefresh = testR
    }
    
    //View did load function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting the navigation title for the view
        self.navigationItem.title = "NIU LONG CAMPUS TOUR"
        
        //Getting the data from the static array in the AllLocations class
        currentArray = AllLocations.allLocations
        
        //Getting the current location from static variable in the AllLocations
        curLocation = AllLocations.currentLocation
        
        testSend = false
        testRefresh = false
        
        self.longMapView.delegate = self
        
        //Setting the navigation item back button text to empty for the next activity
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
        //If the curLocation variable is not equal to nil
        if(curLocation != nil){
            //Function call to longArray
            longarray()
            
            //Set the zoom level
            let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.015, longitudeDelta: 0.015)
            
            //The current location
            let currentLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(curLocation!.coordinate.latitude, curLocation!.coordinate.longitude)
            
            //Display the map
            let region:MKCoordinateRegion = MKCoordinateRegion.init(center: currentLocation, span: span)
            longMapView.setRegion(region, animated: true)
            
            // Display the location on the map
            self.longMapView.showsUserLocation = true
            
            //Remove overlays from the map
            self.longMapView.removeOverlays(self.longMapView.overlays)
            
            //Get the coordinates from the location objects
            coordinates = currentArray.map({$0.coordinates})
            
            print("long load " + coordinates.count.description)
            
            if(coordinates.count == 0){
                //Do nothing
            } else {
                let q0 = DispatchQueue(label: "call")
                
                q0.async {
                    //Function call to getClosestLocation
                    self.getClosestLocation(location: (self.curLocation?.coordinate)!, locations: self.coordinates)
                }
            }
        }
        
        //Creating a navigation bar left button item with a selector
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(LongMapController.refreshAction(_:)))
        
        //Setting an image for the left bar item
        self.navigationItem.leftBarButtonItem?.image = UIImage(named: "refresh_24pt_1x.png")
        
//        self.navigationItem.leftBarButtonItem?.accessibilityFrame = CGRect(x: 0.0, y: 0.0, width: 20, height: 10)
        
        //Disabling the left bar item
        self.navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    //This is the viewWillAppear function which is called just after the viewDidLoad
    override func viewWillAppear(_ animated: Bool) {
        
        //If testSend is true
        if(testSend)!{
            
            //Function call to the longArray
            longarray()
            
            //Zoom level
            let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.015, longitudeDelta: 0.015)
            
            //Coordinate to mark user's position
            let currentLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(curLocation!.coordinate.latitude, curLocation!.coordinate.longitude)
            
            //Setting the region
            let region:MKCoordinateRegion = MKCoordinateRegion.init(center: currentLocation, span: span)
            longMapView.setRegion(region, animated: true)
            
            // Display the location on the map
            self.longMapView.showsUserLocation = true
            
            //Remove any overlays
            self.longMapView.removeOverlays(self.longMapView.overlays)
            
            //Getting the coordinates from the backArray1 array
            coordinates = backArray1.map({$0.coordinates})
            
            print("long appear " + coordinates.count.description)
            
            if(coordinates.count == 0){
                //Do nothin
            } else {
                let q0 = DispatchQueue(label: "call")
                q0.async {
                    //Function call to getClosestLocation
                    self.getClosestLocation(location: (self.curLocation?.coordinate)!, locations: self.coordinates)
                }
            }
            
            testSend = false
        } else {
            
            if(currentArray.count == 0){

            } else {

            }
        }
    }
    
    /*
     This factory method is used to customize the polyline which is drawn as a route between various coordinates
     */
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        //Color for the route
        renderer.strokeColor = UIColor.red
        
        //Thickness level for the route
        renderer.lineWidth = 5.0
        
        return renderer
    }
    
    /*
     NAME: getDirections
     INPUT PARAMETERS : two location coordinates
     This function is used to plot a route between the two input coordinates.
     */
    private func getDirections(fromLocationCoord: CLLocationCoordinate2D, toLocationCoord: CLLocationCoordinate2D)
    {
        //Place mark for the source and destination
        let source = MKPlacemark(coordinate: fromLocationCoord)
        let destination = MKPlacemark(coordinate: toLocationCoord)
        
        //Map item for the source and destination
        let sourceItem = MKMapItem(placemark: source)
        let destinationItem = MKMapItem(placemark: destination)
        
        //Creating an object of the MKDirectionsRequest class and giving source and destionation
        //Also giving the transport type
        let direction = MKDirections.Request()
        direction.source = sourceItem
        direction.destination = destinationItem
        direction.requestsAlternateRoutes = true;
        direction.transportType = .walking
        
        DispatchQueue.global().async {
            //Call to the MKDirections to get the route
            let directions = MKDirections(request: direction)
            directions.calculate(completionHandler: {response, Error in
                guard let response = response else {
                    if let Error = Error {
                        print("no directions " + Error.localizedDescription)
                        
                        //When error occurs we activate the left bar button
                        self.navigationItem.leftBarButtonItem?.isEnabled = true
                    }
                    return
                }

                //get the route
                let route = response.routes[0]

                DispatchQueue.main.async {
                    //Plot the route on to the map
                    self.longMapView.addOverlay(route.polyline, level: .aboveRoads)
                }
            })
        }
    }
    
    /*
     NAME: getClosestLocation
     INPUT PARAMETERS : CLLocationCoordinate2D and array of CLLocationCoordinate2D
     This function is used to determine the next closest location in an array of coordinates from the location input
     */
    private func getClosestLocation(location: CLLocationCoordinate2D, locations: [CLLocationCoordinate2D])
    {
        //Check if the location array is empty or just has one element
        if(locations.count == 0 || locations.count == 1)
        {
            //If it's empty do nothing
            if(locations.count == 0){
                return
            } else if(locations.count == 1){
                //Function call to getDirections to draw the route
                getDirections(fromLocationCoord: location, toLocationCoord: locations[0])
                return
            }
        }
        
        var closestLocation: (distance: CLLocationDistance, coordinates: CLLocationCoordinate2D)?
        
        var cl :CLLocationCoordinate2D? = nil
        
        var num : Int = 0
        
        for loc in locations
        {
            //This calculates the closest coordinate to the location coordinate
            let distance = round(location.location1.distance(from: loc.location)) as CLLocationDistance
            
            if closestLocation == nil
            {
                //For the first time the first variable is validated
                closestLocation = (distance,loc)
                cl = loc
                num = locations.index(where: {$0.latitude == loc.latitude})!
            }
            else
            {
                //If current distance is less than the previous smallest distance update the smallest distance
                if distance < closestLocation!.distance
                {
                    closestLocation = (distance,loc)
                    cl = loc
                    num = locations.index(where: {$0.latitude == loc.latitude})!
                    
                }
            }
        }
        
        let q0 = DispatchQueue(label: "call")
        
        q0.async {
            //Function call to the getDirections function to draw the route
            self.getDirections(fromLocationCoord: location, toLocationCoord: cl!)
        }
        
        var locationSecond = [CLLocationCoordinate2D]()
        
        locationSecond = locations
        
        //remove element from the array
        locationSecond.remove(at: num)
        
        //Call recursively
        getClosestLocation(location: cl!, locations: locationSecond)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     This function is used to drop the annotations markers on to the map
     */
    func longarray(){
        
        //If testSend is true
        if(testSend)!{
            print("true long")
            
            //Remove any previous annotations
            let allAnnotations = self.longMapView.annotations
            self.longMapView.removeAnnotations(allAnnotations)
            
            DispatchQueue.main.async {
                
                //Run a for loop to drop the annotatio markers from the backArray1 array
                for loc in self.backArray1 {
                    let annotation = MKPointAnnotation()
                    annotation.title = loc.BuildingName
                    annotation.subtitle = loc.BuildingCode
                    annotation.coordinate = CLLocationCoordinate2D(latitude: loc.Latitude, longitude: loc.Longitude)
                    
                    self.longMapView.addAnnotation(annotation)
                }
            }
        } else {
            print("false long")
            DispatchQueue.main.async {
//                for loc in self.currentArray {
//                    if(Int(loc.Number) == 1 || Int(loc.Number) == 2 || Int(loc.Number) == 3 || Int(loc.Number) == 5 || Int(loc.Number) == 7 || Int(loc.Number) == 8 || Int(loc.Number) == 9 || Int(loc.Number) == 12 || Int(loc.Number) == 13 || Int(loc.Number) == 14 || Int(loc.Number) == 15 || Int(loc.Number) == 16 || Int(loc.Number) == 17 || Int(loc.Number) == 18 || Int(loc.Number) == 19 ||
//                        Int(loc.Number) == 21 || Int(loc.Number) == 22 || Int(loc.Number) == 23 || Int(loc.Number) == 27 || Int(loc.Number) == 28){
//                        loc.condition = true
//
//                        let annotation = MKPointAnnotation()
//                        annotation.title = loc.BuildingName
//                        annotation.subtitle = loc.BuildingCode
//                        annotation.coordinate = CLLocationCoordinate2D(latitude: loc.Latitude, longitude: loc.Longitude)
//
//                        self.longMapView.addAnnotation(annotation)
//                    } else {
//                        loc.condition = false
//                    }
//                }
                
                //Run a for loop to drop the annotatio markers from the currentArray1 array
                for loc in self.currentArray {
                    let annotation = MKPointAnnotation()
                    annotation.title = loc.BuildingName
                    annotation.subtitle = loc.BuildingCode
                    annotation.coordinate = CLLocationCoordinate2D(latitude: loc.Latitude, longitude: loc.Longitude)
                    
                    self.longMapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    /*
     This function is used to customize the annotation pins
     */
    func mapView(_ mapView:MKMapView, viewFor annotation:MKAnnotation) -> MKAnnotationView?
    {
        if annotation is MKUserLocation
        {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotationView.canShowCallout = true
        
        //Setting the image for the annotation pin
        let pinImage = UIImage(named: "huskiepaws")
        
        annotationView.image = pinImage
        
        //Adding a button to the annotation
        let btn = UIButton(type: .detailDisclosure)
        annotationView.rightCalloutAccessoryView = btn
        
        return annotationView
    }
    
    /*
     This function is used to specify the action that will be performed when the annotation of the pin is clicked
     */
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        let annView = view.annotation
        
        //Variables which are used to store values
        var image_url = ""
        var facts = ""
        var title = ""
        
        //For loop to find out which annotation was clicked
        for locations in currentArray
        {
            if(annView?.coordinate.latitude == locations.Latitude && annView?.coordinate.longitude==locations.Longitude)
            {
                //getting the image URL, facts and title
                image_url = locations.BuildingImage
                facts = locations.Facts
                title = locations.BuildingName
            }
        }
        
        //Making the transition from the current view controller to the DetailViewController
        let storyBoard = UIStoryboard(name:"Main", bundle:nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        
        //Sending the facts and the image URL
        detailVC.facts = facts
        detailVC.imageURL = image_url
        
        //Setting the navigation title for the destination view controller
        detailVC.navigationItem.title = title
        
        //Making the transition
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //This segue is used to open the table view controller
        if(segue.identifier == "LONGSEGUE"){
            //print("inside here " + locations.count.description)
            let destVc = segue.destination as! LongSwitchViewController
            
            //Send the currentPath to the table view controller
            destVc.longArray = currentArray
            
            destVc.delegate1 = self
        }
    }
    
    /*
     This function is called when the user shakes the phone. This function fires up the PedometerViewController
     */
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        //The motion type is shake
        if event?.subtype == UIEvent.EventSubtype.motionShake{
            
            //Making the transition to PedometerViewController
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            
            let detailVc = storyBoard.instantiateViewController(withIdentifier: "TRACKSTEPS") as! PedometerViewController
            
            self.navigationController?.pushViewController(detailVc, animated: true)
            
        }
    }
}

//This extension is used to get the latitude and longitude of each location coordinate
extension CLLocationCoordinate2D {
    var location1: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}

