//
//  PedometerViewController.swift
//  ShanthiDesamsettiCampusWalk
//
//  Created by siva lingam on 11/24/18.
//  Copyright © 2018 Sivalingam Sundararaj Shanthi. All rights reserved.
//

/*
 This view controller is associated with the pedometer view for counting the steps.
 */
import UIKit
import CoreMotion

class PedometerViewController: UIViewController {
    
    
    //Add
    
    //The CMMotionActivityManager object
    private let activityManager = CMMotionActivityManager()
    
    //The CMPedometer object
    private let pedometer = CMPedometer()
    //Add
    
    //Outlets for the steps, total steps and status
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    
    //Variables
    var numberOfSteps:Int?
    var distance:Double?
    var averagePace:Double?
    var pace:Double?
    var steps : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add
        
        //Function call to startUpdating
        startUpdating()
        
        //Setting the text for avgLabel from the totalSteps in the AllLocations class
        avgLabel.text = String(AllLocations.totalSteps)
        //Add
        
        //Setting the title for the navigation item
        self.navigationItem.title = "STEP COUNT"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Add
    //This is used to check the authorization to track the user's motion
    func checkAuthorizationStatus(){

        switch CMMotionActivityManager.authorizationStatus() {
        case CMAuthorizationStatus.denied:
            print("Denied")

//        case CMAuthorizationStatus.authorized:
//            print("Permission given")
//            startTrackingActivity()

        default:
            startTrackingActivity()
            print("given")
        }
    }

    //This function is used to track what kind of activity the user is doing
    func startTrackingActivity(){
        activityManager.startActivityUpdates(to: OperationQueue.main) {
            [weak self ](activity: CMMotionActivity?) in
            guard let activity = activity else { return }
            DispatchQueue.main.async {
                if activity.walking {
                    self?.paceLabel.text = "Walking"
                } else if activity.stationary {
                    //self?.activityTypeLabel.text = "Stationary"
                    self?.paceLabel.text = "Stationary"
                } else if activity.running {
                    //self?.activityTypeLabel.text = "Running"
                    self?.paceLabel.text = "Running"
                } else if activity.automotive {
                    //self?.activityTypeLabel.text = "Automotive"
                    self?.paceLabel.text = "Automotive"
                }
            }
        }
    }

    //This function is used to count the the user's steps
    private func startCountingSteps(){
        pedometer.startUpdates(from: Date()){
            [weak self] pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else {return}

            DispatchQueue.main.async {
//                AllLocations.totalSteps = AllLocations.totalSteps + pedometerData.numberOfSteps.intValue
                //self?.avgLabel.text = String(AllLocations.totalSteps)
                //Setting the steps label
                self?.stepsLabel.text = pedometerData.numberOfSteps.stringValue

            }

            self?.steps = pedometerData.numberOfSteps.intValue
        }
    }

    //This function checks whether the user's activity and step counts are available
    private func startUpdating(){
        if CMMotionActivityManager.isActivityAvailable(){
            startTrackingActivity()
        }

        if CMPedometer.isStepCountingAvailable(){
            startCountingSteps()
        }
    }

    //This function is called when the view disappears
    override func viewWillDisappear(_ animated: Bool) {
        //If the steps variable is not nil
        if(self.steps != nil){
            //Appending the steps count to the totalSteps variable in the AllLocations class
            AllLocations.totalSteps = AllLocations.totalSteps + self.steps!
        }
    }
    //Add
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
