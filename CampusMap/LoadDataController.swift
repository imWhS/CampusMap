//
//  LoadDataController.swift
//  CampusMap
//
//  Created by 손원희 on 03/04/2019.
//  Copyright © 2019 iamwhs. All rights reserved.
//

import Foundation
import UIKit
import Network

class LoadDataController : UIViewController {
    @IBOutlet var lSignal: UIActivityIndicatorView!

    var buildingItems: [CBuildings] = []
    var officeItems: [COffices] = []
    let sharedDatas = UIApplication.shared.delegate as? AppDelegate
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lSignal.startAnimating()
        
        let model = NetworkModel(self)
        
        model.getBuildings()
        model.getOffices()
    }
    
    func divideBuildings() {
        for item in buildingItems {
            /*
             if !(((UIApplication.shared.delegate as? AppDelegate)?.buildingsId.contains(item.id!))!) {
             (UIApplication.shared.delegate as? AppDelegate)?.buildingsId.append(item.id!)
             }
            */
            
            if !((sharedDatas?.buildingsId.contains(item.id!))!) {
                sharedDatas?.buildingsId.append(item.id!)
            }
            if !((sharedDatas?.buildingsTitle.contains(item.title!))!) {
                sharedDatas?.buildingsTitle.append(item.title!)
            }
            sharedDatas?.buildingsLat.append(item.lat!)
            sharedDatas?.buildingsLog.append(item.log!)
        }
    }
    
    func divideOffices() {
        for item in officeItems {
            if !((sharedDatas?.officesId.contains(item.id!))!) {
                sharedDatas?.officesId.append(item.id!)
            }
            
            if !((sharedDatas?.officesTitle.contains(item.title!))!) {
                sharedDatas?.officesTitle.append(item.title!)
            }
            
            if !((sharedDatas?.officesBuildingId.contains(item.buildingId!))!) {
                sharedDatas?.officesBuildingId.append(item.buildingId!)
            }
            
            if !((sharedDatas?.officesFloorId.contains(item.floorId!))!) {
                sharedDatas?.officesFloorId.append(item.floorId!)
            }
            
            if !((sharedDatas?.officesRoomId.contains(item.roomId!))!) {
                sharedDatas?.officesRoomId.append(item.roomId!)
            }
            
            if !((sharedDatas?.officesFilterId.contains(item.filterId!))!) {
                sharedDatas?.officesFilterId.append(item.filterId!)
            }
            
            if !((sharedDatas?.officesIsMain.contains(item.isMain!))!) {
                sharedDatas?.officesIsMain.append(item.isMain!)
            }
        }
    }
}

extension LoadDataController: NetworkCallback {
    func networkSuc(resultdata: Any, code: String) {
        if(code == "buildings") {
            if let items = resultdata as? [NSDictionary] {
                var temp: [CBuildings] = []
                for item in items {
                    let id = item["id"] as? Int ?? 0
                    let title = item["title"] as? String ?? ""
                    let lat = item["lat"] as? String ?? ""
                    let log = item["log"] as? String ?? ""
                    
                    let obj = CBuildings(id: id, title: title, lat: lat, log: log)
                    temp.append(obj)
                }
                self.buildingItems = temp
            }
            divideBuildings()
            print("Constructed buildings data!")
        }
        
        if(code == "offices") {
            if let items = resultdata as? [NSDictionary] {
                var temp: [COffices] = []
                for item in items {
                    let id = item["id"] as? Int ?? 0
                    let title = item["title"] as? String ?? ""
                    let buildingId = item["buildingId"] as? Int ?? 0
                    let floorId = item["floorId"] as? String ?? ""
                    let roomId = item["roomId"] as? String ?? ""
                    let filterId = item["filterId"] as? Int ?? 0
                    let isMain = item["isMain"] as? Bool ?? false
                    
                    let obj = COffices(id: id, title: title, buildingId: buildingId, floorId: floorId, roomId: roomId, filterId: filterId, isMain: isMain)
                    temp.append(obj)
                }
                self.officeItems = temp
            }
            divideOffices()
            print("Constructed offices data!")
        }
        
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "Main")
        viewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve;
        self.present(viewController, animated: true);
    }
    
    func networkFail(code: String) {
        if(code == "buildings") {
            print("buildings data 수신 실패")
            let model = NetworkModel(self)
            model.getBuildings()
        }
        if(code == "offices") {
            print("offices data 수신 실패")
            let model = NetworkModel(self)
            model.getOffices()
        }
        
    }
}
