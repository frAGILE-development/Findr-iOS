//
//  FoundItem.swift
//  FindriOS
//
//  Created by Ananya Gupta on 7/20/17.
//  Copyright (c) 2017 Ananya Gupta. All rights reserved.
//

import Foundation

class FoundItem: NSObject, NSCoding {
    
    struct Keys2 {
        static let Item = "item";
        static let Description = "description"
        static let Status = "status"
        static let Date = "date"
        static let Address = "address"
        static let Lat = "latitude"
        static let Long = "longitude"
    }
    
    private var _item = "";
    
    private var _description = "";
    
    private var _status = "";
    
    private var _date = "";
    
    private var _address = "";
    
    private var _lat = "";
    
    private var _long = "";
    
    override init() {}
    
    init(item: String, description: String, status: String, date: String, address: String, lat: String, long: String) {
        self._item = item;
        self._description = description;
        self._status = status;
        self._date = date;
        self._address = address;
        self._lat = lat;
        self._long = long;
    }
    
    required init(coder decoder: NSCoder) {
        if let itemObj = decoder.decodeObjectForKey(Keys2.Item) as?
            String {
                _item = itemObj;
        }
        
        if let descriptionObj = decoder.decodeObjectForKey(Keys2.Description) as?
            String {
                _description = descriptionObj;
        }
        
        if let statusObj = decoder.decodeObjectForKey(Keys2.Status) as?
            String {
                _status = statusObj;
        }
        
        if let dateObj = decoder.decodeObjectForKey(Keys2.Date) as?
            String {
                _date = dateObj;
        }
        
        if let addressObj = decoder.decodeObjectForKey(Keys2.Address) as?
            String {
                _address = addressObj;
        }
        
        if let latObj = decoder.decodeObjectForKey(Keys2.Lat) as?
            String {
                _lat = latObj;
        }
        
        if let longObj = decoder.decodeObjectForKey(Keys2.Long) as?
            String {
                _long = longObj;
        }
        
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(_item, forKey: Keys2.Item);
        coder.encodeObject(_description, forKey: Keys2.Description);
        coder.encodeObject(_status, forKey: Keys2.Status);
        coder.encodeObject(_date, forKey: Keys2.Date);
        coder.encodeObject(_address, forKey: Keys2.Address);
        coder.encodeObject(_lat, forKey: Keys2.Lat);
        coder.encodeObject(_long, forKey: Keys2.Long);
    }
    
    var Item: String {
        get {
            return _item;
        }
        set {
            _item = newValue;
        }
    }
    
    var Description: String {
        get {
            return _description;
        }
        set {
            _description = newValue;
        }
    }
    
    var Status: String {
        get {
            return _status;
        }
        set {
            _status = newValue;
        }
    }
    
    var Date: String {
        get {
            return _date;
        }
        set {
            _date = newValue;
        }
    }
    
    var Address: String {
        get {
            return _address;
        }
        set {
            _address = newValue;
        }
    }
    
    var Lat: String {
        get {
            return _lat;
        }
        set {
            _lat = newValue;
        }
    }
    
    var Long: String {
        get {
            return _long;
        }
        set {
            _long = newValue;
        }
    }
    
    
    
}
