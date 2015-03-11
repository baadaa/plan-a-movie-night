//
//  BaseModel.swift
//  Plan a Movie Night
//
//  Created by Angel S. Moreno on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    class public func fetchOne(){
        println("Fetching One")
    }
    
    class public func fetchMany(){
        println("Fetching Many")
    }
    
    public func save(){
        println("saving")
    }
    
    public func create(){
        println("creating")
    }
}
