//
//  LongSwitchViewController.swift
//  ShanthiDesamsettiCampusWalk
//
//  Created by siva lingam on 11/21/18.
//  Copyright © 2018 Sivalingam Sundararaj Shanthi. All rights reserved.
//

/*
 This view is associated with the long switch view. This view lets the user to skip or add stops from a maximum of 28 stops
 */
import UIKit

class LongSwitchViewController: UITableViewController {
    
    //Variables, array
    var longArray = [Locations]()
    var counter : Int?
    var delegate1 : MyProtocol1?
    var testSend : Bool?
    var testRefresh : Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting the row height
        self.tableView.rowHeight = 110
        
        //Setting the seperator color
        self.tableView.separatorColor = UIColor.black
        
        testSend = false
        testRefresh = false
        
        //Counter is used to keep track of the number of stops that were selected
        counter = 0
        
        print(longArray.count)
        
        //Checking and incrementing the counter
        for loc in longArray {
            if(loc.condition == true){
                counter = counter! + 1
            }
        }
        
        //Setting the title for the navigation item
        self.navigationItem.title = "SELECT BUILDINGS     [" + String(describing: self.counter!) + "]"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return longArray.count
    }

    //This function is used to place an image, text and switch for the table view cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LONGSWITCHCELL", for: indexPath) as! LongSwitchViewCell
        
        let loc : Locations = self.longArray[indexPath.row]
        
        //Convert the image URL string to a URL
        let url = URL(string: loc.BuildingImage)
        
        DispatchQueue.global().async {
            //Get the image from the internet
            let data = try? Data(contentsOf: url!)
            
            DispatchQueue.main.async {
                //Setting the image
                cell.longImageView.image = UIImage(data: data!)
            }
        }
        
        //Setting the text for the table view cell item
        cell.longBuildingName.text = loc.BuildingName
        
        //Setting a tag for the cell item
        cell.longSwitch.tag = indexPath.row
        
        //Adding a target which is an Objective c function
        cell.longSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        
        //Checking to see if the switch should be turned on or off
        if(loc.condition){
            //cell.longSwitch.isEnabled = true
            cell.longSwitch.isOn = true
        } else {
//            if(counter == 20){
//                cell.longSwitch.isEnabled = false
//            } else {
//                cell.longSwitch.isEnabled = true
//            }
            cell.longSwitch.isOn = false
        }
        
        

        // Configure the cell...

        return cell
    }
    
    //This Objective c function is used to set the condition variable based on the switch state
    @objc func switchChanged(_ sender : UISwitch!){
        
        //location object condition variable is set based on the switch state
        longArray[sender.tag].condition = sender.isOn
        
        //Counter variable is modified based on the switch state
        if(longArray[sender.tag].condition == false){
            counter = counter! - 1
//            if(counter! < 20){
//                //self.tableView.reloadData()
//            }
        } else {
            counter = counter! + 1
//            if(counter! < 20){
//                counter = counter! + 1
//                //self.tableView.reloadData()
//            }
        }
        
        self.testSend = true
        self.testRefresh = true
        
        //Setting the title for the navigation item
        self.navigationItem.title = "SELECT BUILDING     [" + String(describing: self.counter!) + "]"
    }
    
    //When the view disappears we append the location object which have a condition of true to the send array
    override func viewWillDisappear(_ animated: Bool) {
        
        if(testSend)!{
            var send1 = [Locations]()
            
            //This is used to send an array and two booleans to the ShortMapController
            for loc in longArray {
                if(loc.condition){
                    send1.append(loc)
                }
            }
            //This is used to send an array and two booleans to the ShortMapController
            delegate1?.setResultOfBusinessLogic1(array: send1, test: testSend!, testR: testRefresh!)
        } else {
            //Dont send anything
        }
    }
}

//This protocol is used to send back data to the LongMapController
protocol MyProtocol1 {
    func setResultOfBusinessLogic1(array : [Locations], test : Bool, testR : Bool)
}

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
 }
 */
