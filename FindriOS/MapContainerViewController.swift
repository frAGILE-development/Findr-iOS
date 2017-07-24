//
//  MapContainerViewController.swift
//  FindriOS
//
//  Created by Ananya Gupta on 7/24/17.
//  Copyright (c) 2017 Ananya Gupta. All rights reserved.
//

import UIKit

class MapContainerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.cameraWithLatitude(33.777427, longitude: -84.397609, zoom: 12.0)
        let mapView = GMSMapView.mapWithFrame(CGRect.nullRect, camera: camera)
        view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 33.777427, longitude: -84.397609)
        marker.title = "Atlanta"
        marker.snippet = "GA"
        marker.map = mapView
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
