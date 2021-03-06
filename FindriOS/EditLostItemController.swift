//
//  EditLostItemController.swift
//  FindriOS
//
//  Created by Ananya Gupta on 7/19/17.
//  Copyright (c) 2017 Ananya Gupta. All rights reserved.
//

import UIKit

class EditLostItemController: UIViewController {

    @IBOutlet weak var itemTxt: UITextField!
    
    @IBOutlet weak var descrTxt: UITextView!

    @IBOutlet weak var dateTxt: UITextField!
    
    @IBOutlet weak var locTxt: UITextView!
    
    @IBOutlet weak var latTxt: UITextField!
    
    @IBOutlet weak var LongTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("this is \(index) it is")
        
        //fill values
        itemTxt.text = item;
        descrTxt.text = descr;
        dateTxt.text = date;
        locTxt.text = loc;
        latTxt.text = lat
        LongTxt.text = long 
        
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
    var lat = ""
    var long = ""
    
    var search = true
    
    var index = 0;
    
    var data = [LostItem]()
    
    var path = ""

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onClickEdit(sender: AnyObject) {
        if (!search) {
            itemTxt.enabled = true
            descrTxt.editable = true
            dateTxt.enabled = true
            locTxt.editable = true
            latTxt.enabled = true
            LongTxt.enabled = true
        } else {
            throwError("Cannot Edit while Searching")
        }
    }
    
    @IBAction func onClickOK(sender: AnyObject) {
        
        data[index].Item = itemTxt.text
        data[index].Description = descrTxt.text
        data[index].Date = dateTxt.text
        data[index].Address = locTxt.text
        data[index].Lat = latTxt.text
        data[index].Long = LongTxt.text
        
        NSKeyedArchiver.archiveRootObject(data, toFile: path);
        
        itemTxt.enabled = false
        descrTxt.editable = false
        dateTxt.enabled = false
        locTxt.editable = false
        latTxt.enabled = false
        LongTxt.enabled = false
    }
    
    func throwError(userMessage:String) {
        var alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let Action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil);
        
        alert.addAction(Action);
        self.presentViewController(alert, animated: true, completion: nil);
    }
    
    
    

}
