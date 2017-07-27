//
//  FoundViewController.swift
//  FindriOS
//
//  Created by Ananya Gupta on 7/17/17.
//  Copyright (c) 2017 Ananya Gupta. All rights reserved.
//

import UIKit

class FoundViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    lazy var foundPlaces = [String:String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if (NSUserDefaults.standardUserDefaults().objectForKey("foundPlaces") == nil) {
            var foundPlaces = [String: String]()
        } else {
            var foundPlaces = NSUserDefaults.standardUserDefaults().objectForKey("foundPlaces")
        }
        //print(filePath)
        loadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        loadData()
        tableView.reloadData()
    }
    
    var data = [FoundItem]();
    
    @IBOutlet weak var searchBar: UISearchBar!
    var searchData = [FoundItem]()
    var searching:Bool! = false
    
    var filePath: String {
        let manager = NSFileManager.defaultManager();
        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last
        
        var notString =  url!.URLByAppendingPathComponent("Data")
        var mod = notString.absoluteString!
        var ret = mod.stringByReplacingOccurrencesOfString("file://", withString: "", options: .allZeros, range: nil)
        return ret;
    }
    
    private func loadData() {
        if let ourData = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? [FoundItem] {
            data = ourData;
        }
    }
    
    private func saveData(item: FoundItem) {
        data.append(item);
        NSKeyedArchiver.archiveRootObject(data, toFile: filePath);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var tableView: UITableView!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath)
        if searching == true {
            cell.textLabel??.text = searchData[indexPath.row].Item
            cell.detailTextLabel??.text = searchData[indexPath.row].Date
        } else {
            cell.textLabel??.text = data[indexPath.row].Item
            cell.detailTextLabel??.text = data[indexPath.row].Date
        }
        
        return cell as! UITableViewCell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchData = data.filter({ (text) -> Bool in
            let tmp: NSString = text.Item
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if (searchData.count == 0) {
            searching = false
        } else {
            searching = true
        }
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching! == true {
            return searchData.count
        } else {
            return data.count
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            data.removeAtIndex(indexPath.row);
            NSKeyedArchiver.archiveRootObject(data, toFile: filePath);
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
        
    }
    
    @IBAction func addFoundItem(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Report Found Item" , message: "Enter information about the found item", preferredStyle: UIAlertControllerStyle.Alert);
        let save = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default) { (UIAlertAction) in
            let item = ((alert.textFields![0] as! UITextField).text)
            let descr = ((alert.textFields![1] as! UITextField).text)
            let date = ((alert.textFields![2] as! UITextField).text)
            let address = ((alert.textFields![3] as! UITextField).text)
            
            let lat = (alert.textFields![4] as! UITextField).text
            let long = ((alert.textFields![5] as! UITextField).text)
            
            self.foundPlaces[lat] = long
            
            NSUserDefaults.standardUserDefaults().setObject(self.foundPlaces, forKey: "foundPlaces")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            
            let newItem = FoundItem(item: item, description: descr, status: "Found", date: date, address: address, lat: lat, long: long)
            
            self.saveData(newItem)
            
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil)
        
        
        alert.addTextFieldWithConfigurationHandler { (text: UITextField!) in
            text.placeholder = "Item"
        }
        
        alert.addTextFieldWithConfigurationHandler { (text: UITextField!) in
            text.placeholder = "Description of Item"
        }
        
        alert.addTextFieldWithConfigurationHandler { (text: UITextField!) in
            text.placeholder = "Date Item was Found"
        }
        
        alert.addTextFieldWithConfigurationHandler { (text: UITextField!) in
            text.placeholder = "Address Where Item was Found"
        }
        
        alert.addTextFieldWithConfigurationHandler { (text: UITextField!) in
            text.placeholder = "Latitude Where Item was Found"
        }
        
        alert.addTextFieldWithConfigurationHandler { (text: UITextField!) in
            text.placeholder = "Longitude Where Item was Found"
        }
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editFoundItem" {
            
            if let destination = segue.destinationViewController as? EditFoundItemController {
                
                destination.path = filePath
                
                if searching == true {
                    destination.item = searchData[tableView.indexPathForSelectedRow()!.row].Item
                    destination.descr = searchData[tableView.indexPathForSelectedRow()!.row].Description
                    destination.date = searchData[tableView.indexPathForSelectedRow()!.row].Date
                    destination.loc = searchData[tableView.indexPathForSelectedRow()!.row].Address
                    destination.lat = searchData[tableView.indexPathForSelectedRow()!.row].Lat
                    destination.long = searchData[tableView.indexPathForSelectedRow()!.row].Long
                    destination.index = tableView.indexPathForSelectedRow()!.row
                    destination.data = searchData
                    destination.search = true
                } else {
                    destination.item = data[tableView.indexPathForSelectedRow()!.row].Item
                    destination.descr = data[tableView.indexPathForSelectedRow()!.row].Description
                    destination.date = data[tableView.indexPathForSelectedRow()!.row].Date
                    destination.loc = data[tableView.indexPathForSelectedRow()!.row].Address
                    destination.lat = data[tableView.indexPathForSelectedRow()!.row].Lat
                    destination.long = data[tableView.indexPathForSelectedRow()!.row].Long
                    destination.index = tableView.indexPathForSelectedRow()!.row
                    destination.data = data
                    destination.search = false
                }
            }
            
        }
    }
    
    

}
