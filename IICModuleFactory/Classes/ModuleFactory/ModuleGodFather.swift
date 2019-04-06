//
//  ModuleGodFather.swift
//  ModuleFactory
//
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class ModuleGodFather: NSObject {
    
    /// all observable keys
    var allFuncitons = NSMutableDictionary()
    
    /// foreground observer
    var moduleURL: String = ""
    
    /// behind observer
    var backModuleURL: String = ""
    
    /// uuid
    var uuidKeyStr: String = "blockUUID"
    
    /// restore #Selector eg. #selector(A.b)
    var eachFunctionISA: String = "_moduleFactory_selectorDIC"
    
    /// all [url]
    var urls: [String] = []
    
    required override init() {
         super.init()
    }
    
    /// start - service
    public func startServices() {
        setModuleURLAndBackurl()
        registerFunctions()
    }
    
}
