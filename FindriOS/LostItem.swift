//
//  LostItem.swift
//  FindriOS
//
//  Created by Ananya Gupta on 7/18/17.
//  Copyright (c) 2017 Ananya Gupta. All rights reserved.
//

import Foundation

class LostItem: NSObject, NSCoding {
    
    struct Keys {
        static let Item = "item";
        static let Description = "description"
        static let Status = "status"
        static let Date = "date"
        static let Address = "address"
        static let Lat = "lat"
        static let Long = "long"
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
        self._lat = lat
        self._long = long
    }
    
    required init(coder decoder: NSCoder) {
        if let itemObj = decoder.decodeObjectForKey(Keys.Item) as?
            String {
                _item = itemObj;
        }
        
        if let descriptionObj = decoder.decodeObjectForKey(Keys.Description) as?
            String {
                _description = descriptionObj;
        }
        
        if let statusObj = decoder.decodeObjectForKey(Keys.Status) as?
            String {
                _status = statusObj;
        }
        
        if let dateObj = decoder.decodeObjectForKey(Keys.Date) as?
            String {
                _date = dateObj;
        }
        
        if let addressObj = decoder.decodeObjectForKey(Keys.Address) as?
            String {
                _address = addressObj;
        }
        
        if let latObj = decoder.decodeObjectForKey(Keys.Lat) as?
            String {
                _lat = latObj;
        }
        
        if let longObj = decoder.decodeObjectForKey(Keys.Long) as?
            String {
                _long = longObj;
        }
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(_item, forKey: Keys.Item);
        coder.encodeObject(_description, forKey: Keys.Description);
        coder.encodeObject(_status, forKey: Keys.Status);
        coder.encodeObject(_date, forKey: Keys.Date);
        coder.encodeObject(_address, forKey: Keys.Address);
        coder.encodeObject(_lat, forKey: Keys.Lat);
        coder.encodeObject(_long, forKey: Keys.Long);
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
