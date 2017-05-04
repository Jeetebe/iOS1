//
//  TinhObj.swift
//  IOS8SwiftTabBarControllerTutorial
//
//  Created by MacBook on 4/30/17.
//  Copyright © 2017 Arthur Knopper. All rights reserved.
//

import Foundation

class TinhObj
{
    var _tinhdau:String = ""
    var _tinhid:String = ""
    var _ngay:String = ""
    init (id:String, tinh:String, ngay:String)
    {
        self._ngay=ngay
        self._tinhdau=tinh
        self._tinhid=id
    }
    
}