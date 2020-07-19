//
//  Person.swift
//  SQLiteExample
//
//  Created by WDP on 19/07/20.
//  Copyright © 2020 WDP. All rights reserved.
//

import Foundation

class Person{
    var name : String = ""
    var age : Int = 0
    var id : Int = 0
    
    init(id:Int,name:String,age:Int) {
        self.id = id
        self.name = name
        self.age = age
    }
    
}
