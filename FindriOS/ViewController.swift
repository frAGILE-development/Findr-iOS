//
//  ViewController.swift
//  FindriOS
//
//  Created by Ananya Gupta on 7/13/17.
//  Copyright (c) 2017 Ananya Gupta. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        var sound = NSBundle.mainBundle().pathForResource("sample", ofType: "mp3")
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: NSURL .fileURLWithPath(sound!), error: nil)
        audioPlayer.prepareToPlay()
    }
    
    override func viewDidDisappear(animated: Bool) {
        audioPlayer.stop()
    }
//
//    override func viewWillAppear(animated: Bool) {
//        audioPlayer.play()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        let loggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isLoggedIn");
        if (!loggedIn) {
            self.performSegueWithIdentifier("viewLogin", sender: self);
        }
    }

    @IBAction func onClickLogout(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        
        let loginViewController = self.storyboard!.instantiateViewControllerWithIdentifier("viewLogin") as! ViewControllerLogIn;
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController=loginViewController
        
        appDelegate.window?.makeKeyAndVisible()
        
        audioPlayer.stop()
    }

    @IBAction func onClickPlay(sender: AnyObject) {
        audioPlayer.play()
    }
    
    @IBAction func onClickPause(sender: AnyObject) {
//        if audioPlayer.playing {
//            audioPlayer.pause()
//        }
        audioPlayer.stop()
    }
    
    @IBAction func onClickRestart(sender: AnyObject) {
        if audioPlayer.playing {
            audioPlayer.currentTime = 0
            audioPlayer.play()
        } else {
            audioPlayer.play()
        }
    }
    
    
    
}

