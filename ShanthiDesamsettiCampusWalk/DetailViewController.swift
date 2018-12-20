//
//  DetailViewController.swift
//  ShanthiDesamsettiCampusWalk
//
//  Created by siva lingam on 11/17/18.
//  Copyright © 2018 Sivalingam Sundararaj Shanthi. All rights reserved.
//

/*
 This view controller is associated with the detail view. This view controllers lets the user to see details about the selected annotation marker. This view controller can also play audio information about the details.
 */
import UIKit
import AVFoundation


class DetailViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    //Variable
    var playPauseBool : Bool?
    var facts : String!
    var imageURL : String!
    
    //Outlet for the imageview
    @IBOutlet weak var imageView: UIImageView!
    
    //Outlet for the facts
    @IBOutlet weak var factsTV: UITextView!
    let speechSynthesizer = AVSpeechSynthesizer()
    
    //Outlet for the play label
    @IBOutlet weak var playLabel: UILabel!
    
    //This function is called when the view disappears
    override func viewWillDisappear(_ animated: Bool) {
        //If the device is speaking
        if(speechSynthesizer.isSpeaking){
            //Stop the speech
            speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
            
            //Set playPauseBool to true
            playPauseBool = true
        } else {
            //Do nothing
        }
    }
    
    //IBAction for the play button
    @IBAction func playButton(_ sender: UIButton) {
        
        //If playPauseBool is true
        if(playPauseBool)!
        {
            //Give the facts string to AVSpeechUtterance
            let speechUtterance = AVSpeechUtterance(string: facts)
            //Speak the content
            speechSynthesizer.speak(speechUtterance)
            //Set playPause to false
            playPauseBool = false
            //Changing the image for the playButton
            playButtonImage.setImage(UIImage(named: "pause_3x"), for: .normal)
            //Changing the label of play
            playLabel.text = "PAUSE"
        }
        else if(playPauseBool==false)
        {
            //Pause the speech
            speechSynthesizer.pauseSpeaking(at: AVSpeechBoundary.immediate)
            //Set playPause to true
            playPauseBool = true
            //Changing the image for the playButton
            playButtonImage.setImage(UIImage(named: "play_3x"), for: .normal)
            //Changing the label of play
            playLabel.text = "PLAY"
        }
        
        //If speech is paused
        if (speechSynthesizer.isPaused)
        {
            //Continue speaking
            speechSynthesizer.continueSpeaking();
        }
    }
    
    //Outlet for the playButtonImage
    @IBOutlet weak var playButtonImage: UIButton!
    
    //IBAction for the stop button
    @IBAction func stopButton(_ sender: UIButton) {
        //If device is speaking
        if(speechSynthesizer.isSpeaking)
        {
            //Stop the speech
            speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
            
            //Set playPause to true
            playPauseBool = true
            
            //Changing the image for the playButton
            playButtonImage.setImage(UIImage(named: "play_3x"), for: .normal)
            
            //Changing the label of play
            playLabel.text = "PLAY"
        }
    }
    
    //View Did load function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechSynthesizer.delegate = self
        
        playPauseBool = true
        
        //Converting image URL string to URL
        let url = URL(string: imageURL)
        
        DispatchQueue.global().async {
            //Fetching the imae from the internet
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                //Setting the image
                let image = UIImage(data: data!)
                self.imageView.image = image
            }
        }
        
        //Setting the facts
        factsTV.text = facts
        
        
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
    
    //This function is called when the speech finishes
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("all done")
        //Set playPause to true
        playPauseBool = true
        //Setting the image for the play button
        playButtonImage.setImage(UIImage(named: "play_3x"), for: .normal)
        //Setting the playLabel text
        playLabel.text = "PLAY"
    }
}
