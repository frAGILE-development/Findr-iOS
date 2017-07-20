//
//  EditFoundItemController.swift
//  FindriOS
//
//  Created by Ananya Gupta on 7/20/17.
//  Copyright (c) 2017 Ananya Gupta. All rights reserved.
//

import UIKit

class EditFoundItemController: UIViewController {

    @IBOutlet weak var itemTxt: UITextField!
    @IBOutlet weak var descrTxt: UITextView!
    @IBOutlet weak var dateTxt: UITextField!
    @IBOutlet weak var locTxt: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fill values
        itemTxt.text = item;
        descrTxt.text = descr;
        dateTxt.text = date;
        locTxt.text = loc;
        
        //give borders
        descrTxt.layer.cornerRadius = 5
        descrTxt.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.5).CGColor
        descrTxt.layer.borderWidth = 0.5
        descrTxt.clipsToBounds = true
        
        locTxt.layer.cornerRadius = 5
        locTxt.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.5).CGColor
        locTxt.layer.borderWidth = 0.5
        locTxt.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    var item = ""
    var descr = ""
    var date = ""
    var loc = ""

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
