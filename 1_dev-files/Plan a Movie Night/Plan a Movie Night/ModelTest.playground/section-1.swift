// Playground - noun: a place where people can play

import UIKit

class BaseModel: NSObject {
    class func fetchOne() -> BaseModel {
        println("Fetching One")
        return BaseModel()
    }
    
    class func fetchMany() -> [BaseModel]{
        println("Fetching Many")
        return [BaseModel(), BaseModel()]
    }
    
    func save(){
        println("saving")
    }
    
    func create(){
        println("creating")
    }
}


let foo = BaseModel.fetchOne()

foo.save()

