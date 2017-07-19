//
//  LostViewController.swift
//  FindriOS
//
//  Created by Ananya Gupta on 7/17/17.
//  Copyright (c) 2017 Ananya Gupta. All rights reserved.
//

import UIKit

class LostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
        //var stringPath = filePath.absoluteString;
        print (filePath)
    }
    
    var data = [LostItem]();
    
    var filePath: String {
        let manager = NSFileManager.defaultManager();
        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
        
        var notString =  url!.URLByAppendingPathComponent("Data")
        var mod = notString.absoluteString!
        var ret = mod.stringByReplacingOccurrencesOfString("file://", withString: "", options: .allZeros, range: nil)
        return ret;
    }
    
    private func loadData() {
//        var stringPath = filePath.absoluteString;
        if let ourData = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? [LostItem] {
            data = ourData;
        }
    }
    
    private func saveData(item: LostItem) {
        data.append(item);
        
//        var stringPath = filePath.absoluteString;
        
        NSKeyedArchiver.archiveRootObject(data, toFile: filePath);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBOutlet weak var tableView: UITableView!
    
//    let arr = ["Pen", "Teddy Bear", "Dog"]
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: AnyObject = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel??.text = data[indexPath.row].Item
        cell.detailTextLabel??.text = data[indexPath.row].Date
        
        return cell as! UITableViewCell
    }
    
    @IBAction func addLostItem(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Add Lost Item" , message: "Enter information about the lost item", preferredStyle: UIAlertControllerStyle.Alert);
        let save = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default) { (UIAlertAction) in
            let item = ((alert.textFields![0] as! UITextField).text)
            let descr = ((alert.textFields![1] as! UITextField).text)
            let date = ((alert.textFields![2] as! UITextField).text)
            let address = ((alert.textFields![3] as! UITextField).text)
            
            let newItem = LostItem(item: item, description: descr, status: "Lost", date: date, address: address)
            
            self.saveData(newItem)
            
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil)
        
//        alert.addTextFieldWithConfigurationHandler(nil)
//        alert.addTextFieldWithConfigurationHandler(nil)
//        alert.addTextFieldWithConfigurationHandler(nil)
//        alert.addTextFieldWithConfigurationHandler(nil)
        
        alert.addTextFieldWithConfigurationHandler { (text: UITextField!) in
            text.placeholder = "Item"
        }
        
        alert.addTextFieldWithConfigurationHandler { (text: UITextField!) in
            text.placeholder = "Description of Item"
        }
        
        alert.addTextFieldWithConfigurationHandler { (text: UITextField!) in
            text.placeholder = "Date Item was Lost"
        }
        
        alert.addTextFieldWithConfigurationHandler { (text: UITextField!) in
            text.placeholder = "Address Where Item was Lost"
        }
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
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
