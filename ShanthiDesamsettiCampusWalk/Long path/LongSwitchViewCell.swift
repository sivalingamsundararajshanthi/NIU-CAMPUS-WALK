//
//  LongSwitchViewCell.swift
//  ShanthiDesamsettiCampusWalk
//
//  Created by siva lingam on 11/21/18.
//  Copyright © 2018 Sivalingam Sundararaj Shanthi. All rights reserved.
//

/*
 This is the view controller for the long switch table view cell. This displays an image, building name and a switch
 */
import UIKit

class LongSwitchViewCell: UITableViewCell {
    
    //Outlet for the image
    @IBOutlet weak var longImageView: UIImageView!
    
    //Outlet for the building name
    @IBOutlet weak var longBuildingName: UILabel!
    
    //Outlet for the switch
    @IBOutlet weak var longSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
