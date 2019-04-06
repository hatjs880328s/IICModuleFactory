//
//  ModuleGodFatherPostBack.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/7.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

extension ModuleGodFather {

    func getBackNotification(functionName: String) -> String {
        return (self.allFuncitons["\(moduleURL)\(functionName)"] as? RegisterModel)?.backNotificationName ?? ""
    }

    func postBackNotification(backNotificationName: String, backUserinfo: [String: Any], oldNotiDic: [String: Any]) {
        let backNotiName = self.getBackNotification(functionName: backNotificationName)
        var postDic = backUserinfo
        postDic[self.uuidKeyStr] = oldNotiDic[self.uuidKeyStr]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: backNotiName), object: nil, userInfo: postDic)
    }

    func backFunction(backUserinfo: [String: Any], oldNotiDic: Any) {
        guard let oldDic = oldNotiDic as? [String: Any] else { return }
        guard let sel = oldDic[eachFunctionISA] as? Selector else { return }
        let funcName = NSStringFromSelector(sel)
        var methodNum: UInt32 = 0
        guard let listInfo = getClassType()?.1 else { return }
        let methodlist = class_copyMethodList(listInfo, &methodNum)
        for index in 0 ..< numericCast(methodNum) {
            let method: Method = methodlist![index]
            let methodSelector = method_getName(method)
            if "\(methodSelector)".contains(funcName) {
                self.postBackNotification(backNotificationName: "\(methodSelector)", backUserinfo: backUserinfo, oldNotiDic: oldDic)
                return
            }
        }
    }
}
