//
//  ReferenceTableViewController.swift
//  ShanthiDesamsettiCampusWalk
//
//  Created by siva lingam on 11/28/18.
//  Copyright © 2018 Sivalingam Sundararaj Shanthi. All rights reserved.
//

/*
 This view controller is not used
 */

import UIKit

class ReferenceTableViewController: UITableViewController {
    
    var websiteDictionary: [String : String] = [
        "Customize annotations" :"http://sweettutos.com/2016/03/16/how-to-completely-customise-your-map-annotations-callout-views/",
        "Draw route" : "https://www.iostutorialjunction.com/2018/03/draw-route-on-apple-map-or-mapkit-tutorial-in-swift4.html",
        "Tap annotation call out show" : "http://sweettutos.com/2016/01/21/swift-mapkit-tutorial-series-how-to-customize-the-map-annotations-callout-request-a-transit-eta-and-launch-the-transit-directions-to-your-destination/",
        "Switch in table view cell" : "https://stackoverflow.com/questions/47038673/add-switch-in-uitableview-cell-in-swift",
        "Send data back to previous view" : "http://swiftdeveloperblog.com/pass-information-back-to-the-previous-view-controller/",
        "Text to Speech" : "https://www.appcoda.com/text-to-speech-ios-tutorial/",
        "CoreMotion" : "https://wysockikamil.com/coremotion-pedometer-swift/",
        "Pedometer" : "https://www.devfright.com/cmmotionmanager-tutorial-part-1/",
        "UIAlertView from App Delegate" : "https://stackoverflow.com/questions/27807104/how-to-present-uialertview-from-appdelegate"
    ]
    
    var reference = [Reference]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 100
        
        convert()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func convert(){
        for (key, value) in websiteDictionary{
            reference.append(Reference(name: key, link: value))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return websiteDictionary.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "REFERENCECELL", for: indexPath) as! ReferenceViewCell
        
        let ref : Reference = self.reference[indexPath.row]
        
        cell.referenceTitle.text = ref.name
        
        // Configure the cell...

        return cell
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
