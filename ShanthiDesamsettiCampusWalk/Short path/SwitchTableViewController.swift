//
//  SwitchTableViewController.swift
//  ShanthiDesamsettiCampusWalk
//
//  Created by siva lingam on 11/20/18.
//  Copyright © 2018 Sivalingam Sundararaj Shanthi. All rights reserved.
//

/*
 This view is associated with the switch view. This view lets the user to skip or add stops from a maximum of 10 stops
 */
import UIKit

class SwitchTableViewController: UITableViewController {
    
    //Variables, array
    var testSend : Bool?
    var testRefresh : Bool?
    var delegate:MyProtocol?
    var location = [Locations]()
    var send = [Locations]()
    var counter : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Counter is used to keep track of the number of stops that were selected
        counter = 0
        
        //Checking and incrementing the counter
        for loc in location{
            if(loc.condition == true){
                counter = counter! + 1
            }
        }
        
        //Setting the row height
        tableView.rowHeight = 110
        
        //Setting the seperator color
        tableView.separatorColor = UIColor.black
        
        testSend = false
        testRefresh = false
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //Setting the title for the navigation item
        self.navigationItem.title = "SELECT 10 OR LESS     [" + String(describing: counter!.description) + "]"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    //Number of sections for the table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    //Number of elements in the location array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return location.count
    }

    //This function is used to place an image, text and switch for the table view cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let loc : Locations = self.location[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SWITCHCELL", for: indexPath) as! SwitchTableViewCell
        
        //Convert the image URL string to a URL
        let url = URL(string: loc.BuildingImage)
        
        DispatchQueue.global().async {
            //Get the image from the internet
            let data = try? Data(contentsOf: url!)
            
            DispatchQueue.main.async {
                //Setting the image
                cell.switchBuildingImageView.image = UIImage(data: data!)
            }
        }
        
        //Setting the text for the table view cell item
        cell.switchBuildingName.text = loc.BuildingName
        
//        cell.switch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        
        //Setting a tag for the cell item
        cell.switch.tag = indexPath.row
        
        //Adding a target which is an Objective c function
        cell.switch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        
        //Checking to see if the switch should be turned on or off
        if(loc.condition){
            cell.switch.isOn = true
        } else {
            cell.switch.isOn = false
        }

        // Configure the cell...

        return cell
    }
    
    //This Objective c function is used to set the condition variable based on the switch state
    @objc func switchChanged(_ sender : UISwitch!){
        
        //location object condition variable is set based on the switch state
        location[sender.tag].condition = sender.isOn
        
        //Counter variable is modified based on the switch state
        if(location[sender.tag].condition == false){
            counter = counter! - 1
        } else {
            counter = counter! + 1
        }
        //print("Touched")
        
//        for loc in location{
//            print(loc.condition)
//        }
        
        //if(!sender.isOn){
          //  print("here")
            self.testSend = true
        
        self.testRefresh = true
        //}
        
        //print(testSend?.description)
        
        //Setting the title for the navigation item
        self.navigationItem.title = "SELECT 10 OR LESS     [" + String(describing: self.counter!) + "]"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    //When the view disappears we append the location object which have a condition of true to the send array
    override func viewWillDisappear(_ animated: Bool) {
        for loc in location {
            if(loc.condition){
                send.append(loc)
            }
        }
        //This is used to send an array and two booleans to the ShortMapController
        delegate?.setResultOfBusinessLogic(array: send, test: testSend!, testR: true)
    }
}

//This protocol is used to send back data to the ShortMapController
protocol MyProtocol {
    func setResultOfBusinessLogic(array : [Locations], test : Bool, testR : Bool)
}

//    func switchChanged(_ sender : UISwitch!, loc : Locations){
//
//        //print(mySwitch.isOn)
//        //print(loc.BuildingName)
//    }

/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 
 print("here")
 }
 */





















