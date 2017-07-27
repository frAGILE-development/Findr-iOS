//
//  MapContainerViewController.swift
//  FindriOS
//
//  Created by Ananya Gupta on 7/24/17.
//  Copyright (c) 2017 Ananya Gupta. All rights reserved.
//

import UIKit
import CoreLocation

class MapContainerViewController: UIViewController, CLLocationManagerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var data = [FoundItem]()
    var data2 = [LostItem]()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()    }
    
    var filePath: String {
        let manager = NSFileManager.defaultManager();
        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last
        
        var notString =  url!.URLByAppendingPathComponent("Data")
        var mod = notString.absoluteString!
        var ret = mod.stringByReplacingOccurrencesOfString("file://", withString: "", options: .allZeros, range: nil)
        return ret;
    }
    
    var filePath2: String {
        let manager = NSFileManager.defaultManager();
        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
        
        var notString =  url!.URLByAppendingPathComponent("Data2")
        var mod = notString.absoluteString!
        var ret = mod.stringByReplacingOccurrencesOfString("file://", withString: "", options: .allZeros, range: nil)
        return ret;
    }
    
    private func loadData() {
        if let ourData = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? [FoundItem] {
            data = ourData
        }
        
        if let ourData2 = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath2) as? [LostItem] {
            data2 = ourData2
        }
        
    }
    
    override func loadView() {
        loadData()
        let camera = GMSCameraPosition.cameraWithLatitude(33.777427, longitude: -84.397609, zoom: 4.0)
        let mapView = GMSMapView.mapWithFrame(CGRect.nullRect, camera: camera)
        view = mapView
        
        for item in data {
            var lat = (item.Lat as! NSString).doubleValue
            var long = (item.Long as! NSString).doubleValue
            
            var marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            marker.title = "\(item.Item.uppercaseString)" + "  \(item.Date)" + "  \(item.Description)"
            marker.snippet = "\(item.Address)" + "   Found Item"
            marker.map = mapView
        }
        
        for item in data2 {
            var lat = (item.Lat as! NSString).doubleValue
            var long = (item.Long as! NSString).doubleValue
            
            var marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            marker.title = "\(item.Item.uppercaseString)" + "  \(item.Date)" + "  \(item.Description)"
            marker.snippet = "\(item.Address)" + "   Lost Item"
            marker.map = mapView
        }
        
    }

}
