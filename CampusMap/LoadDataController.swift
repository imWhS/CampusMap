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
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func chkReachablility() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Connected network!")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("check network reachability")
        chkReachablility()
        
        lSignal.startAnimating()
        let model = NetworkModel(self)
        model.getBuildings()
        model.getOffices()
    }
    
    func divideBuildings() {
        for item in buildingItems {
            if !(((UIApplication.shared.delegate as? AppDelegate)?.buildingsId.contains(item.id!))!) {
                (UIApplication.shared.delegate as? AppDelegate)?.buildingsId.append(item.id!)
            }
            
            if !(((UIApplication.shared.delegate as? AppDelegate)?.buildingsTitle.contains(item.title!))!) {
                (UIApplication.shared.delegate as? AppDelegate)?.buildingsTitle.append(item.title!)
            }
        
            (UIApplication.shared.delegate as? AppDelegate)?.buildingsLat.append(item.lat!)
            (UIApplication.shared.delegate as? AppDelegate)?.buildingsLog.append(item.log!)
        }
    }
    //let obj = CBuildings(id: id, title: title, buildingId: buildingId, floorId: floorId, roomId: roomId, filterId: filterId, isMain: isMain)
    func divideOffices() {
        for item in officeItems {
            if !(((UIApplication.shared.delegate as? AppDelegate)?.officesId.contains(item.id!))!) {
                (UIApplication.shared.delegate as? AppDelegate)?.officesId.append(item.id!)
            }
            
            if !(((UIApplication.shared.delegate as? AppDelegate)?.officesTitle.contains(item.title!))!) {
                (UIApplication.shared.delegate as? AppDelegate)?.officesTitle.append(item.title!)
            }
            
            if !(((UIApplication.shared.delegate as? AppDelegate)?.officesBuildingId.contains(item.buildingId!))!) {
                (UIApplication.shared.delegate as? AppDelegate)?.officesBuildingId.append(item.buildingId!)
            }
            
            if !(((UIApplication.shared.delegate as? AppDelegate)?.officesFloorId.contains(item.floorId!))!) {
                (UIApplication.shared.delegate as? AppDelegate)?.officesFloorId.append(item.floorId!)
            }
            
            if !(((UIApplication.shared.delegate as? AppDelegate)?.officesRoomId.contains(item.roomId!))!) {
                (UIApplication.shared.delegate as? AppDelegate)?.officesRoomId.append(item.roomId!)
            }
            
            if !(((UIApplication.shared.delegate as? AppDelegate)?.officesFilterId.contains(item.filterId!))!) {
                (UIApplication.shared.delegate as? AppDelegate)?.officesFilterId.append(item.filterId!)
            }
            
            if !(((UIApplication.shared.delegate as? AppDelegate)?.officesIsMain.contains(item.isMain!))!) {
                (UIApplication.shared.delegate as? AppDelegate)?.officesIsMain.append(item.isMain!)
            }
        }
    }
}

//"id":1,"title":"대학본부","lat":"37.3767741","log":"126.63464720000002"
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
