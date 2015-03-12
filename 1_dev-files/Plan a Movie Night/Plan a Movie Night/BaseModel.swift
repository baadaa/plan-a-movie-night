//
//  BaseModel.swift
//  Plan a Movie Night
//
//  Created by Angel S. Moreno on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

protocol PAMNModelProtocol {
    
    init()
    class func fetchOne()  -> BasePAMNModel
    class func fetchMany()  -> [BasePAMNModel]
    func save()  -> String
    class func create(data: NSDictionary) -> BasePAMNModel
}

class BasePAMNModel: PAMNModelProtocol {
    
    required init(){

    }
    
    class func fetchOne() -> BasePAMNModel {
        return BasePAMNModel()
    }
    
    class func fetchMany() -> [BasePAMNModel]{
        return [BasePAMNModel()]
    }
    
    func save() -> String {
        return String()
    }
    
    class func create(data: NSDictionary) -> BasePAMNModel {
        return BasePAMNModel()
    }
}

