//
//  LogItem.swift
//  IOS8SwiftTabBarControllerTutorial
//
//  Created by MacBook on 4/30/17.
//  Copyright © 2017 Arthur Knopper. All rights reserved.
//


import Foundation
import CoreData

@objc(LogItem)
public class LogItem: NSManagedObject {
    
    @NSManaged var itemText: String
    @NSManaged var title: String
    
}

