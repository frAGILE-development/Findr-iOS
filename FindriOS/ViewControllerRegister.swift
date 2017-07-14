//
//  ViewControllerRegister.swift
//  FindriOS
//
//  Created by Ananya Gupta on 7/14/17.
//  Copyright (c) 2017 Ananya Gupta. All rights reserved.
//

import UIKit

class ViewControllerRegister: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var repeatPassText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Clicking register
    //Checks for validity of data
    @IBAction func onClickRegister(sender: AnyObject) {
        let email = emailText.text;
        let password = passwordText.text;
        let repPass = repeatPassText.text;
        let phone = phoneText.text;
        
        //check if fields empty
        if (email.isEmpty || password.isEmpty || repPass.isEmpty || phone.isEmpty) {
            throwError("All fields are required");
        }
        
        //checks (cursorily) is valid email
        if (email.rangeOfString("@") == nil) {
            throwError("Please enter a valid email id");
        }
        
        //checks if passwords match
        if (password != repPass) {
            throwError("Please enter the same password");
        }
        
        //store data
        NSUserDefaults.standardUserDefaults().setObject(email, forKey: "email");
        NSUserDefaults.standardUserDefaults().setObject(password, forKey: "password");
        NSUserDefaults.standardUserDefaults().synchronize();
        
        //display confirmation
        var alert = UIAlertController(title: "Alert", message: "Registration Successful", preferredStyle: UIAlertControllerStyle.Alert);
        
        let Action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){action in
            self.dismissViewControllerAnimated(true, completion: nil);
        }
        
        alert.addAction(Action);
        self.presentViewController(alert, animated: true, completion: nil);
        
    }
    
    @IBAction func onCancelClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    //error throwing function
    func throwError(userMessage:String) {
        var alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let Action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil);
        
        alert.addAction(Action);
        self.presentViewController(alert, animated: true, completion: nil);
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
