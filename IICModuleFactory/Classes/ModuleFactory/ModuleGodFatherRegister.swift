//
//  ModuleGodFatherRegister.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

extension ModuleGodFather {
    
    func setModuleURLAndBackurl() {
        guard let className = getClassType()?.0 else { return }
        self.moduleURL = className + "/"
        self.backModuleURL = "back" + "/" + self.moduleURL
    }

    func getClassType() -> (String, AnyClass)? {
        let className = self.description.components(separatedBy: ":")[0].components(separatedBy: ".")[1]
        guard let nameSpace = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String else { return nil }
        let cls: AnyClass = NSClassFromString("\(nameSpace).\(className)")!
        return (className, cls)
    }
    
    func registerFunctions() {
        var methodNum: UInt32 = 0
        guard let listInfo = getClassType()?.1 else { return }
        let methodlist = class_copyMethodList(listInfo, &methodNum)
        for index in 0 ..< numericCast(methodNum) {
            guard let method: Method = methodlist?[index] else { continue}
            let methodSelector = method_getName(method)
            if !"\(methodSelector)".contains("init") && !"\(methodSelector)".contains("startServices") && !"\(methodSelector)".contains("cxx_destruct")
                && !"\(methodSelector)".contains("AnalyzeNetWorkWithNoti") {
                let registone = RegisterModel()
                registone.descriptionD = "\(method_getName(method))"
                registone.notifacationName = "\(moduleURL)\(method_getName(method))"
                registone.backNotificationName = "\(backModuleURL)\(method_getName(method))"
                registone.selectorInfo = method_getName(method)
                self.allFuncitons[registone.notifacationName] = registone
                self.urls.append(registone.notifacationName)
                print("\n\(registone.notifacationName)\n")
            }
        }
    }
    
}
