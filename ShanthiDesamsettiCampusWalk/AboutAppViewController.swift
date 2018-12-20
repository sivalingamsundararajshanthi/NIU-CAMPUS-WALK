//
//  AboutAppViewController.swift
//  ShanthiDesamsettiCampusWalk
//
//  Created by siva lingam on 11/26/18.
//  Copyright © 2018 Sivalingam Sundararaj Shanthi. All rights reserved.
//

/*
 This view controller is used for the about app view. This view lets the user read information about the app and also
 lets the user to send feedback to the user.
 */

import UIKit
import MessageUI

class AboutAppViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    //IBAction to send the mail
    @IBAction func sendEmail(_ sender: UIButton) {
        
        let mailComposeVc = MFMailComposeViewController()
        
        //Made the mail compose view controller be it's own delegate
        mailComposeVc.mailComposeDelegate = self
        
        //Email address for one or more reciepents
        let toRecipient = ["niucsci@gmail.com"]
        
        //Email title in "text/string"
        let emailTitle = "ShanthiDesamsettiCampusWalk"
        
        //Email message body in "text/string"
        let messageBody = "Person 1: \n" +
        "First Name: Sivalingam \n" +
        "Last Name: Sundararaj Shanthi \n" +
        "Student zid: z1829451 \n" +
        
        "Person 2: \n" +
        "First Name: Harshith \n" +
        "Last Name: Desamsetti \n" +
        "Student zid: z1829024 \n" +
        
        "Due date: 11/28/2018 \n" +
        "Time: 11.59 P.M."
        
        //Connect the reciepents to the mail compose view controller
        mailComposeVc.setToRecipients(toRecipient)
        
        //Connect the subject title to the mail address view controller
        mailComposeVc.setSubject(emailTitle)
        
        //Connect the message body to the mail address view controller
        mailComposeVc.setMessageBody(messageBody, isHTML: false)
        
        //Present the mail compose view controller
        self.present(mailComposeVc, animated: true, completion: nil)
    }
    
    //This function is used to dismiss the mail compose view after the send button is tapped
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
