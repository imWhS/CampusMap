//
//  JSON_buildings.swift
//  CampusMap
//
//  Created by 손원희 on 02/04/2019.
//  Copyright © 2019 iamwhs. All rights reserved.
//

import Foundation

class JSON_buildings: NSObject {
    var id: Int
    var title: String
    var lat: String
    var log: String
    
    init(jsonDic: NSDictionary) {
        self.id = (jsonDic["id"] != nil ? jsonDic["id"] as! Int! : nil)!
        self.title = (jsonDic["title"] != nil ? jsonDic["title"] as! String! : nil)!
        self.lat = (jsonDic["lat"] != nil ? jsonDic["lat"] as! String! : nil)!
        self.title = (jsonDic["log"] != nil ? jsonDic["log"] as! String! : nil)!
    }
}
