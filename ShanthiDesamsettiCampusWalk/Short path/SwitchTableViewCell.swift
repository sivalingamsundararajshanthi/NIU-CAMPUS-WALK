//
//  SwitchTableViewCell.swift
//  ShanthiDesamsettiCampusWalk
//
//  Created by siva lingam on 11/20/18.
//  Copyright © 2018 Sivalingam Sundararaj Shanthi. All rights reserved.
//

/*
 This view controller is associated with switch table view cell. This is used to display an image, building name and a switch
 */
import UIKit

class SwitchTableViewCell: UITableViewCell {

    //Outlet for the switch
    @IBOutlet weak var `switch`: UISwitch!
    
    //Outlet for the building name
    @IBOutlet weak var switchBuildingName: UILabel!
    
    //Outlet for the building image
    @IBOutlet weak var switchBuildingImageView: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
