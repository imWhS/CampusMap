//
//  cBuildings.swift
//  CampusMap
//
//  Created by 손원희 on 08/05/2019.
//  Copyright © 2019 iamwhs. All rights reserved.
//

import Foundation

//"id":1,"title":"대학본부","lat":"37.3767741","log":"126.63464720000002"

class CBuildings {
    var id: Int?
    var title: String?
    var lat: String?
    var log: String?
    
    init(id: Int?, title: String?, lat: String?, log: String?) {
        self.id = id
        self.title = title
        self.lat = lat
        self.log = log
    }
}
