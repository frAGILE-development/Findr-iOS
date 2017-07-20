//
//  LostViewController.swift
//  FindriOS
//
//  Created by Ananya Gupta on 7/17/17.
//  Copyright (c) 2017 Ananya Gupta. All rights reserved.
//

import UIKit

class LostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(filePath)
        loadData()
    }

    @IBOutlet weak var searchBar: UISearchBar!
    
    var data = [LostItem]();
    
    var searchData = [LostItem]()
    var searching:Bool! = false
    
    var filePath: String {
        let manager = NSFileManager.defaultManager();
        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
        
        var notString =  url!.URLByAppendingPathComponent("Data2")
        var mod = notString.absoluteString!
        var ret = mod.stringByReplacingOccurrencesOfString("file://", withString: "", options: .allZeros, range: nil)
        return ret;
    }
    
    private func loadData() {
        if let ourData = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? [LostItem] {
            data = ourData;
        }
    }
    
    private func saveData(item: LostItem) {
        data.append(item);
        NSKeyedArchiver.archiveRootObject(data, toFile: filePath);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var tableView: UITableView!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: AnyObject = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if searching == true {
            cell.textLabel??.text = searchData[indexPath.row].Item
            cell.detailTextLabel??.text = data[indexPath.row].Date
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

    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            data.removeAtIndex(indexPath.row);
            NSKeyedArchiver.archiveRootObject(data, toFile: filePath);
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var index = tableView.indexPathForSelectedRow()!.row;
        performSegueWithIdentifier("editLostItem", sender: index)
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
        
        if searching! == true {
            return searchData.count
        } else {
            return data.count
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editLostItem" {
            
            if let destination = segue.destinationViewController as? EditLostItemController {
                
                if searching == true {
                    destination.item = searchData[tableView.indexPathForSelectedRow()!.row].Item
                    destination.descr = searchData[tableView.indexPathForSelectedRow()!.row].Description
                    destination.date = searchData[tableView.indexPathForSelectedRow()!.row].Date
                    destination.loc = searchData[tableView.indexPathForSelectedRow()!.row].Address
                } else {
                    destination.item = data[tableView.indexPathForSelectedRow()!.row].Item
                    destination.descr = data[tableView.indexPathForSelectedRow()!.row].Description
                    destination.date = data[tableView.indexPathForSelectedRow()!.row].Date
                    destination.loc = data[tableView.indexPathForSelectedRow()!.row].Address
                }
            }
            
        }
    }


}
