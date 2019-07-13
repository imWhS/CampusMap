//
//  COffices.swift
//  CampusMap
//
//  Created by 손원희 on 20/05/2019.
//  Copyright © 2019 iamwhs. All rights reserved.
//

import Foundation

//[{"id":8,"title":"교무과(학사지원파트)","buildingId":1,"floorId":"FL01","roomId":"104","filterId":0,"isMain":null}]

class COffices {
    var id: Int?
    var title: String?
    var buildingId: Int?
    var floorId: String?
    var roomId: String?
    var filterId: Int?
    var isMain: Bool?
    
    init(id: Int?, title: String?, buildingId: Int?, floorId: String?, roomId: String?, filterId: Int?, isMain: Bool?) {
        self.id = id
        self.title = title
        self.buildingId = buildingId
        self.floorId = floorId
        self.roomId = roomId
        self.filterId = filterId
        self.isMain = isMain
    }
}
