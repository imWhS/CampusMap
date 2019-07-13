//
//  NetworkModel.swift
//  CampusMap
//
//  Created by 손원희 on 03/04/2019.
//  Copyright © 2019 iamwhs. All rights reserved.
//

import Foundation
import Alamofire

class NetworkModel {
    var view: NetworkCallback
    let url = "http://117.16.231.66:7004"
    
    init(_ view: NetworkCallback) {
        self.view = view
    }
    
    func getBuildings() {
        let url_buildings = URL.init(string: url + "/dbRouter/building")
        Alamofire.request(url_buildings!, method: .get, parameters: nil, headers: nil).responseJSON { res in
            switch res.result {
                case .success(let item):
                    self.view.networkSuc(resultdata: item, code: "buildings")
                    break
                case .failure(let error):
                    print("getBuildings")
                    print(error)
                    self.view.networkFail(code: "buildings")
                    break
            }
        }
    }
    
    func getOffices() {
        let url_offices = URL.init(string: url + "/dbRouter/office")
        Alamofire.request(url_offices!, method: .get, parameters: nil, headers: nil).responseJSON { res in
            switch res.result {
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "offices")
                break
            case .failure(let error):
                print("getOffices")
                print(error)
                self.view.networkFail(code: "offices")
                break
            }
        }
    }
}
