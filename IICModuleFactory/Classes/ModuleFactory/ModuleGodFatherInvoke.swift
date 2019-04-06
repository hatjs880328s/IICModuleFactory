//
//  ModuleGodFatherLifeCircle.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

extension ModuleGodFather {

    
    func exeOneFunction(notiName: String, params: [AnyHashable: Any]) -> Unmanaged<AnyObject>? {
        let selector = (self.allFuncitons[notiName] as! RegisterModel).selectorInfo
        var functionParams: [AnyHashable: Any]!
        var functionCallback: (@convention(block)(_ info: Any) -> Void)!
        if params[IIModulefunctionParamsKey] != nil {
            functionParams = params[IIModulefunctionParamsKey] as? [AnyHashable: Any]
        }
        if params[IIModulecallBackKey] != nil {
            functionCallback = params[IIModulecallBackKey] as? (@convention(block)(_ info: Any) -> Void)
        }
        //let rush = IIModuleInvocation().invokingMethod(self, selector: selector, params: ["a":4])
        //invoke
        if functionCallback != nil && functionParams != nil {
            return self.perform(selector, with: functionParams, with: functionCallback)
        } else if functionCallback == nil && functionParams != nil {
            return self.perform(selector, with: functionParams)
        } else if functionCallback != nil && functionParams == nil {
            return self.perform(selector, with: functionCallback)
        } else {
            return self.perform(selector)
        }
    }
    
}
