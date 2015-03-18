//
//  BaseModel.swift
//  Plan a Movie Night
//
//  Created by Angel S. Moreno on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit


public class Serializable : NSObject{
    
    public func toDictionary() -> NSMutableDictionary {
        var aClass : AnyClass? = self.dynamicType
        var propertiesCount : CUnsignedInt = 0
        let propertiesInAClass : UnsafeMutablePointer<objc_property_t> = class_copyPropertyList(aClass, &propertiesCount)
        var propertiesDictionary : NSMutableDictionary = NSMutableDictionary()
        
        for var i = 0; i < Int(propertiesCount); i++ {
            var property = propertiesInAClass[i]
            var propName = NSString(CString: property_getName(property), encoding: NSUTF8StringEncoding)!
            var propType = property_getAttributes(property)
            var propValue : AnyObject! = self.valueForKey(propName);
            
            if propValue is Serializable {
                propertiesDictionary.setValue((propValue as Serializable).toDictionary(), forKey: propName)
            } else if propValue is Array<Serializable> {
                var subArray = Array<NSDictionary>()
                for item in (propValue as Array<Serializable>) {
                    subArray.append(item.toDictionary())
                }
                propertiesDictionary.setValue(subArray, forKey: propName)
            } else if propValue is NSData {
                propertiesDictionary.setValue((propValue as NSData).base64EncodedStringWithOptions(nil), forKey: propName)
            } else if propValue is Bool {
                propertiesDictionary.setValue((propValue as Bool).boolValue, forKey: propName)
            } else {
                propertiesDictionary.setValue(propValue, forKey: propName)
            }
        }
        
        // class_copyPropertyList retaints all the
        propertiesInAClass.dealloc(Int(propertiesCount))
        
        return propertiesDictionary
    }
    
    public func toJson() -> NSData! {
        var dictionary = self.toDictionary()
        //println(dictionary)
        var err: NSError?
        return NSJSONSerialization.dataWithJSONObject(dictionary, options:NSJSONWritingOptions(0), error: &err)
    }
    
    public func toJsonString() -> NSString! {
        return NSString(data: self.toJson(), encoding: NSUTF8StringEncoding)
    }
    
}

protocol PAMNModelProtocol {
    
//    class func fetchOne()  -> BasePAMNModel
//    class func fetchMany()  -> [BasePAMNModel]
    func save()
    func getDbname()
    //    class func create(data: NSDictionary) -> BasePAMNModel
}

class BasePAMNModel: Serializable {
    private let firebase_url_prefix = "https://pamn.firebaseio.com/"
    var id: String
    var created: String = ""
    var modified: String = ""
    
    init(id: String) {
        self.id = id
    }
    
    func save() {
        var data = self.toDictionary()
        data.removeObjectForKey("id")
        getFirebase().childByAppendingPath(self.id).setValue(data)
    }
    
    private func getFirebase() -> Firebase {
        return Firebase(url: self.firebase_url_prefix).childByAppendingPath(getDbname())
    }
    
    func getDbname() -> String{
        return "test"
    }
    
    func getDateAsString() -> String {
        return "\(NSDate().timeIntervalSince1970 * 1000)"
    }
    
}

