//
//  IIModuleCore.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

/**
 
 middle transport module description：
 a.collect all modules invoktion
 b.how:
 1.publish all invoked by others

 */

public class IIModuleCore: NSObject {
    
    /// ratain all modules
    private var moduleIns: [ModuleGodFather] = []
    
    /// establish the [urls] and [modules] relationship
    private var urlAndModuleDic: Dictionary<String, ModuleGodFather> = [:]
    
    private override init() {
        super.init()
    }
    
    private static var shareInstance: IIModuleCore!
    
    public static func getInstance() -> IIModuleCore {
        if self.shareInstance == nil {
            shareInstance = IIModuleCore()
        }
        return shareInstance
    }
    
    /// register
    func registerService(module: ModuleGodFather.Type) {
        let ins = module.init()
        ins.startServices()
        for eachItem in ins.urls {
            self.urlAndModuleDic[eachItem] = ins
        }
    }
    
    /// remove module
    func removeModule(moduleClass: AnyClass) {
        for eachKey in self.urlAndModuleDic.keys {
            if self.urlAndModuleDic[eachKey]!.isKind(of: moduleClass) {
                self.urlAndModuleDic.removeValue(forKey: eachKey)
            }
        }
    }
    
    /// get all [urls] from the module
    func getUrls(with: AnyClass) ->[String]? {
        for eachKey in self.urlAndModuleDic.keys {
            if self.urlAndModuleDic[eachKey]!.isKind(of: with) {
                return self.urlAndModuleDic[eachKey]?.urls
            }
        }
        print("inherite the ModuleGodFather?")
        return nil
    }
    
    /// invoke one method with url
    @discardableResult
    public func invokingSomeFunciton(url: String, params: [String: Any]?, action:(@convention(block)(_ info: Any) -> Void)?) -> Any? {
        var paraChange = [String: Any]()
        if params != nil {
            paraChange[IIModulefunctionParamsKey] = params
        }
        if action != nil {
            paraChange[IIModulecallBackKey] = action!
        }
        let module = self.getModule(with: url)
        if module == nil {
            print("register the method? ")
            return nil
        }
        let obj = module!.exeOneFunction(notiName: url, params: paraChange)
        if obj == nil { return nil }
        
        return obj!.takeUnretainedValue()
    }
    
    private func getModule(with url: String) -> ModuleGodFather? {
        return self.urlAndModuleDic[url]
    }
    
}
