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
    var id: String {
        get
    }
    
    var dbname: String {
        get
    }
    
    
//    init()
//    class func fetchOne()  -> BasePAMNModel
//    class func fetchMany()  -> [BasePAMNModel]
    func save()  -> Bool
    func getFirebase() -> Firebase
//    class func create(data: NSDictionary) -> BasePAMNModel
}

class BasePAMNModel: Serializable {
    let firebase_url_prefix = "https://pamn.firebaseio.com/calls/"
    var firebase_ref: Firebase!
    
    var dbname: String!
    
    var id: String!
    
    override init(){
        //@todo idk why but i must call super.init() prior to using self? why?
        super.init()
        
        //ensure the model class has a dbname
        if self.dbname == "" {
            self.dbname = _stdlib_getDemangledTypeName(self)
        }
        
        //ensure the model class has an id
        if self.id == "" {
            self.id = NSUUID().UUIDString
        }
        
        let firebase_ref = Firebase(url:self.firebase_url_prefix).childByAppendingPath(self.dbname)
    }
    
//    class func fetchOne() -> BasePAMNModel {
//        return BasePAMNModel()
//    }
//    
//    class func fetchMany() -> [BasePAMNModel]{
//        return [BasePAMNModel()]
//    }
//    
    func save() -> Bool {
        var data = self.toDictionary()
        self.firebase_ref.childByAppendingPath(self.id).setValue(data)
        
        //@otodo we need to return if the saving was successful or not
        return Bool()
    }
//
//    class func create(data: NSDictionary) -> BasePAMNModel {
//        return BasePAMNModel()
//    }
}

