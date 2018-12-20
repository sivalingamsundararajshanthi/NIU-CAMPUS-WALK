//
//  ShortMapController.swift
//  ShanthiDesamsettiCampusWalk
//
//  Created by siva lingam on 11/15/18.
//  Copyright © 2018 Sivalingam Sundararaj Shanthi. All rights reserved.
// This is version 1
//This is the correct copy commented and referenced

/*
 NAME       : SIVALINGAM SUNDARARAJ SHANTHI Z1829451
              HARSHITH DESAMSETTI Z1829024
 SUBJECT    : CSCI 521 IOS MOBILE DEVICE PROGRAMMING
 ASSIGNMENT : CAMPUS WALK
 */

/*
 This view controller is associated with the short route map view. This parses a web API and converts them into location
 objects. This view also gets the users location and plots a route for the short route.
 */
import UIKit
import MapKit
import CoreLocation

class ShortMapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, MyProtocol {
    
    //Variables, array
    var testUpdate : Bool?
    var testForRefresh : Bool?
    var locationObjects = [Locations]()
    var shortPath = [Locations]()
    var coordinates = [CLLocationCoordinate2D]()
    var backArray = [Locations]()
    
    let locationManager = CLLocationManager()
    
    var l : CLLocation? = nil
    
    //This function is used to recieve an array and two booleans from the SwitchViewController
    func setResultOfBusinessLogic(array: [Locations], test : Bool, testR: Bool) {
        self.backArray = array
        testUpdate = test
        testForRefresh = testR
    }
    
    //Outlet for the refreshButton
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    //IBAction for the refresh button
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        
        //If testForRefresh is true
        if(testForRefresh!){
            //Zoom level for the user's location
            let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.015, longitudeDelta: 0.015)
            
            //Marker for the current location
            let currentLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(l!.coordinate.latitude, l!.coordinate.longitude)
            
            //Setting the region
            let region:MKCoordinateRegion = MKCoordinateRegion.init(center: currentLocation, span: span)
            mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
            
            //Removing any overlays from the map
            self.mapView.removeOverlays(self.mapView.overlays)
            
            //Getting the coordinates from the backArray
            coordinates = backArray.map({$0.coordinates})
            if(coordinates.count == 0){
                //Do nothing if coordinates are empty
            } else {
                //Call to the getClosestLocation function
                getClosestLocation(location: (l?.coordinate)!, locations: coordinates)
            }
            self.navigationItem.leftBarButtonItem?.isEnabled = false
        } else {
            //Zoom level for the user's location
            let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.015, longitudeDelta: 0.015)
            
            //Marker for the current location
            let currentLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(l!.coordinate.latitude, l!.coordinate.longitude)
            
            //Setting the region
            let region:MKCoordinateRegion = MKCoordinateRegion.init(center: currentLocation, span: span)
            mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
            
            //Removing any overlays from the map
            self.mapView.removeOverlays(self.mapView.overlays)
            
            //Getting the coordinates from the backArray
            coordinates = shortPath.map({$0.coordinates})
            print("short Appear " + coordinates.count.description)
            if(coordinates.count == 0){
                //Do nothing if the coordinates are empty
            } else {
                //Call to the getClosestLocation function
                getClosestLocation(location: (l?.coordinate)!, locations: coordinates)
            }
            
            //Disabling the left bar button item
            self.navigationItem.leftBarButtonItem?.isEnabled = false
        }
    }
    
    //Outlet for the map view
    @IBOutlet weak var mapView: MKMapView!
    
    /*
     Name : fetchJSON
     This function is used to access the JSON API, parse it and convert it into location objects.
     */
    func fetchJSON(){
        //This is the API
        guard let api_url = URL(string: "http://faculty.cs.niu.edu/~krush/f18/niucampus-json") else {
            return
        }
        
        //Create a URL Request with the API address
        let urlRequest = URLRequest(url: api_url)
        
        //Submit a request to get the JSON data
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            //If there is any error print the error and do not continue
            if error != nil {
                print(error!)
                return
            }
            
            if let content = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: content) as? [[String:[Any]]]
                    
                    for i in json! {
                        if let l = i["NIU Partial Campus"] as? [[String: String]] {
                            
                            //Fetch the location articles
                            for location in l{
                                
                                if let number = location["Number"], let name = location["BuildingName"],
                                    let code = location["BuildingCode"], let city = location["City"], let state = location["State"], let lat = location["Latitude"], let long = location["Longitude"], let image = location["BuildingImage"], let fact = location["Facts"] {
                                    
                                    //Appending the location Objects on to the locationObjects array
                                    self.locationObjects.append(Locations(Number: number, BuildingName: name, BuildingCode: code, City: city, State: state, Latitude: Double(lat)!, Longitude: Double(long)!, BuildingImage: image, Facts: fact))
                                }
                            }
                        }
                    }
                    
                    //Call location manager
                }
                catch {
                    print(error)
                }
                
                
            }
        }
        task.resume()
        
        print("done parsing")
    }
    
    /*
     This function is called after the view did load function
     */
    override func viewWillAppear(_ animated: Bool) {
        
        //If testUpdate is true
        if(testUpdate)!{
            //Call to short array get the array
            shortarray()
            //Zoom level
            let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.015, longitudeDelta: 0.015)
            
            //The users location
            let currentLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(l!.coordinate.latitude, l!.coordinate.longitude)
            
            //Setting the region for the map
            let region:MKCoordinateRegion = MKCoordinateRegion.init(center: currentLocation, span: span)
            mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true

            //Remoe any overlays in the map
            self.mapView.removeOverlays(self.mapView.overlays)

            //Getting the coordinates from the backArray array
            coordinates = backArray.map({$0.coordinates})
            
            print("short Appear " + coordinates.count.description)

            if(coordinates.count == 0){
                //If coordinates array is empty do nothing
            } else {
                //Function call to getClosestLocation function
                getClosestLocation(location: (l?.coordinate)!, locations: coordinates)
            }
            testUpdate = false

        } else {
            
        }
    }
    
    /*
     This function is used to determine the the user's permission for the app to access location information
     */
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status : CLAuthorizationStatus){
        switch status{
        case .denied, .restricted:
            print("No Authorization")

        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()

        default:
            locationManager.startUpdatingLocation()
        }
    }
    
    //View did load function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetchJSON is run in the background thread and after it is done the location managers are called in the main thread
        DispatchQueue.global().async {
            self.fetchJSON()
            
            DispatchQueue.main.sync {
                self.mapView.delegate = self
                
                self.locationManager.delegate = self
                
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                
                self.locationManager.requestWhenInUseAuthorization()
            }
        }
        
        //self.mapView.reloadInputViews()
        
        testUpdate = false
        testForRefresh = false
        
        //setting the navigation item title
        self.navigationItem.title = "NIU SHORT CAMPUS TOUR"
        
        //Setting the back button text for the next screen to be blank
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
        //Adding a navigation left navigation bar button and also adding a selector to perform an action when it is
        //clicked
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(ShortMapController.refreshAction(_:)))
        
        //Setting the image for the left navigation bar button
        self.navigationItem.leftBarButtonItem?.image = UIImage(named: "refresh_24pt_1x.png")

        //Initially disabling it
        self.navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    /*
     This function is used to get the user's current location initially
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        
        //Checking if testUpdate is true or false
        if(testUpdate)!{
            //If it is true we just get the user location and store it in l.
            l = locations[0]
        } else {
            
            print("location manager")
            if(locationObjects.count == 0){
                print("Error occured")
            } else {
                print(locationObjects.count)
                //When the activity is loaded for the first time the user location is zoomed in
                //Storing the current location in the variable new location
                let newLocation = locations[0]
                
                //Setting the zoom level
                let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.015, longitudeDelta: 0.015)
                
                //Creating the CLLocationCoordinate2D
                let currentLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)
                
                //Setting the region on the map
                let region:MKCoordinateRegion = MKCoordinateRegion.init(center: currentLocation, span: span)
                mapView.setRegion(region, animated: true)
                self.mapView.showsUserLocation = true
                
                //Removing any overlays on the map
                self.mapView.removeOverlays(self.mapView.overlays)
                
                //Function call to short array to construct the short array of coordinates for short route
                shortarray()
                
                //Getting the coordinates from and storing them in coordinates array
                coordinates = shortPath.map({$0.coordinates})
                
                print("location short " + coordinates.count.description)
                
                if(coordinates.count == 0){
                    //If coordinates is empty do nothing
                } else {
                    //Function call toget closest location to print the route on to the map
                    getClosestLocation(location: locations[0].coordinate, locations: coordinates)
                }
                
                //Storing the user location on to variable l
                l = locations[0]
                
                //Appending the location objects in the array locationObjects in to the static array allLocations
                //in the class AllLocations
                AllLocations.allLocations = locationObjects.map{$0.copy()} as! [Locations]
                
                //Storing the user's current location in currentLocation which is a static variable in the class AllLocations
                AllLocations.currentLocation = locations[0]
            }
        }
    }
   
    /*
     NAME: getDirections
     INPUT PARAMETERS : two location coordinates
     This function is used to plot a route between the two input coordinates.
     */
    private func getDirections(fromLocationCoord: CLLocationCoordinate2D, toLocationCoord: CLLocationCoordinate2D) {
        
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
                    self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                }
            })
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
     NAME: getClosestLocation
     INPUT PARAMETERS : CLLocationCoordinate2D and array of CLLocationCoordinate2D
     This function is used to determine the next closest location in an array of coordinates from the location input
     */
    private func getClosestLocation(location: CLLocationCoordinate2D, locations: [CLLocationCoordinate2D]) {
        
        //Check if the location array is empty or just has one element
        if(locations.count == 0 || locations.count == 1){
            
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

        var cl : CLLocationCoordinate2D? = nil
        var num : Int = 0

        for loc in locations {
            //This calculates the closest coordinate to the location coordinate
            let distance = round(location.location.distance(from: loc.location)) as CLLocationDistance
            if closestLocation == nil {
                //For the first time the first variable is validated
                closestLocation = (distance, loc)
                cl = loc
                num = locations.index(where: {$0.latitude == loc.latitude})!
            } else {
                //If current distance is less than the previous smallest distance update the smallest distance
                if distance < closestLocation!.distance {
                    closestLocation = (distance, loc)
                    cl = loc
                    num = locations.index(where: {$0.latitude == loc.latitude})!
                }
            }
        }

        let q0 = DispatchQueue(label: "fetch")
        
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
     This function is used to construct the short array from the location Objects array and also to drop the markers
     on to the map
     */
    func shortarray(){
        //If testUpdate is true just drop the pins for the locations in the backArray
        if(testUpdate)!{
            let allAnnotations = self.mapView.annotations
            self.mapView.removeAnnotations(allAnnotations)
            
            //For loop to drop annotations on the map
            for locations in backArray {
                
                let annotation = MKPointAnnotation()
                
                //Setting the title and subtitle for the annotation
                annotation.title = locations.BuildingName
                annotation.subtitle = locations.BuildingCode
                
                //Coordinate for the annotation
                annotation.coordinate = CLLocationCoordinate2D(latitude: locations.Latitude, longitude: locations.Longitude)
                
                mapView.addAnnotation(annotation)
            }
            
        } else {
            
            //For loop to construct the short array which will be coordinates for the short route
            for location in locationObjects {
                if(Int(location.Number) == 14 || Int(location.Number) == 12 || Int(location.Number) == 10 || Int(location.Number) == 13 || Int(location.Number) == 2 ||
                    Int(location.Number) == 22 || Int(location.Number) == 23 || Int(location.Number) == 28 || Int(location.Number) == 17 || Int(location.Number) == 16){
                    //Append to the short array
                    shortPath.append(location)
                }
            }
            DispatchQueue.main.async {
                //For loop to drop the pins on to the map
                for locations in self.shortPath {
                    
                    let annotation = MKPointAnnotation()
                    
                    //Setting the title and the subtitle to the annotation
                    annotation.title = locations.BuildingName
                    annotation.subtitle = locations.BuildingCode
                    
                    //Coordinate to the annotation
                    annotation.coordinate = CLLocationCoordinate2D(latitude: locations.Latitude, longitude: locations.Longitude)
                    
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    /*
     This function is used to customize the annotation pins
     */
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation{
            return nil
        }

        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotationView.canShowCallout = true
        //annotationView.animatesDrop = true
        //annotationView.pinTintColor = UIColor.darkGray
        
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
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let annView = view.annotation
        
        //Variables which are used to store values
        var image_url = ""
        var facts = ""
        var title = ""
        
        //For loop to find out which annotation was clicked
        for locations in shortPath {
            if(annView?.coordinate.latitude == locations.Latitude && annView?.coordinate.longitude == locations.Longitude)
            {
                //getting the image URL, facts and title
                image_url = locations.BuildingImage
                facts = locations.Facts
                title = locations.BuildingName
            }
        }
        
        //Making the transition from the current view controller to the DetailViewController
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
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
        if (segue.identifier == "SWITCHCON"){
            
            let destVc = segue.destination as! SwitchTableViewController
            
            //Send the short path to the table view controller
            destVc.location = shortPath
            
            destVc.delegate = self
        }
    }
 
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //        self.mapView.removeOverlays(self.mapView.overlays)
        //        coordinates = shortPath.map({$0.coordinates})
        //        let closestLocation = getClosestLocation(location: userLocation.coordinate, locations: coordinates)
        //        if let closest = closestLocation {
        //            getDirections(fromLocationCoord: userLocation.coordinate, toLocationCoord: closest)
        //        }
    }
    
    //This function is just used for testing purposes
    func getDir(location : CLLocation){
        for i in 0...locationObjects.count-1{
            if(i == 0){
                getDirections(fromLocationCoord: location.coordinate, toLocationCoord: locationObjects[i].coordinates)
            } else {
                if(i == locationObjects.count-1){
                    //do nothing
                } else {
                    getDirections(fromLocationCoord: locationObjects[i].coordinates, toLocationCoord: locationObjects[i+1].coordinates)
                }
                
            }
        }
    }
    
    /*
     This function is called when the user shakes the phone. This function fires up the PedometerViewController
     */
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC = storyBoard.instantiateViewController(withIdentifier: "TRACKSTEPS") as! PedometerViewController
            
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}

//This extension is used to get the latitude and longitude of each location coordinate
extension CLLocationCoordinate2D {
    var location: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}












