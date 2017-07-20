//
//  FoundViewController.swift
//  FindriOS
//
//  Created by Ananya Gupta on 7/17/17.
//  Copyright (c) 2017 Ananya Gupta. All rights reserved.
//

import UIKit

class FoundViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func onClickBack(sender: AnyObject) {
//        self.dismissViewControllerAnimated(true, completion: nil);
//    }

    @IBOutlet weak var tableView: UITableView!
    
    let arr = ["Diary", "Fidget Spinner", "Vape"]
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel??.text = arr[indexPath.row]
        return cell as! UITableViewCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
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
