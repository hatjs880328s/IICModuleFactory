//
//  ModuleFactory.swift
//  ModuleFactory
//
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

class ModuleFactory: NSObject {

    /// restore all modules
    private var allRegisterModels: [String: RegisterModel] = [:]

    private override init() { super.init() }

    private static var instance: ModuleFactory!
    
    public static func getInstance() -> ModuleFactory {
        if instance == nil {
            self.instance = ModuleFactory()
        }
        return instance
    }

    public func invokingSomeFunciton(url: String, params: [String: Any]?, action:(@convention(block)(_ info: Any) -> Void)?) {
        var paraChange = [String: Any]()
        if params != nil {
            paraChange[IIModulefunctionParamsKey] = params
        }
        if action != nil {
            paraChange[IIModulecallBackKey] = action!
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: url), object: nil, userInfo: paraChange)
    }

    public func registerFunction(model: [RegisterModel]) {
        for eachItem in model {
            self.allRegisterModels [eachItem.notifacationName] = eachItem
        }
    }

}
