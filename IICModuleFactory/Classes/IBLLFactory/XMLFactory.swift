//
// 
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *
//
// IBLLFactory.swift
//
// Created by    Noah Shan on 2018/3/28
// InspurEmail   shanwzh@inspur.com
// GithubAddress https://github.com/hatjs880328s
//
// Copyright © 2018年 Inspur. All rights reserved.
//
// For the full copyright and license information, plz view the LICENSE(open source.)
// File that was distributed with this source code.
//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *
//
//
import UIKit
import Foundation

/*
  Use dispatch semaphore controling the queue <main queue>
  More than one xml file would use in APP
  When last one progress over .... we can analyze the Bean
  Get it's instance when use ,then release . Don't retain it all over.
 */

/// XMLParser - https://github.com/iturb/xmlhero
/// XMLDictionary - https://github.com/nicklockwood/XMLDictionary
class XMLHandler: NSObject {
    
    private let xmlFileCollection = ["SourceBean"]
    
    /// parse the xml file
    private func getData(_ xmlFileName: String) -> NSArray {
        guard let path = Bundle.main.path(forResource: xmlFileName, ofType: "xml") else { return NSArray() }
        guard let dicDoc = NSDictionary(xmlFile: path) else { return NSArray() }
        return (dicDoc["bean"] as? NSArray) ?? NSArray()
    }
    
    /// Start - service
    public func xmlFileStart() -> NSArray {
        var resultArr: NSArray = NSArray()
        for eachXMLName in self.xmlFileCollection {
            guard let realInfo = getData(eachXMLName) as? [Any] else { return resultArr }
            resultArr = resultArr.addingObjects(from: realInfo) as NSArray
        }
        return resultArr
    }
    
    deinit {
        DEBUGPrintLog("-- xmlHandler release --")
    }
}

func DEBUGPrintLog(_ str: String) {
    print(str)
}
