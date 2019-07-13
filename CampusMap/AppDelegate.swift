//
//  AppDelegate.swift
//  CampusMap
//
//  Created by 손원희 on 12/02/2019.
//  Copyright © 2019 iamwhs. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var dataset = [
        ("인문대학", "국어국문학과", "인문학연구소장", "송원용", "010-0000-0000"),
        ("인문대학", "국어국문학과", "인문학연구소장", "조현우", "010-0000-0000"),
        ("인문대학", "국어국문학과", "부교수", "채숙희", "032-835-8111"),
        ("인문대학", "국어국문학과", "조교수", "김정경", "032-835-8948"),
        ("인문대학", "", "", "", ""),
        ("정보기술대학", "", "", "", ""),
        /*
        ("종합상황실", "", "", "", ""),
        ("MRO창고", "", "", "", ""),
        ("종합문서고", "", "", "", ""),
        ("MRO창고", "", "", "", ""),
        ("입학관리과", "", "", "", ""),
        ("상담실", "", "", "", ""),
        ("당직실", "", "", "", ""),
        ("교무과(학사지원파트)", "", "", "", ""),
        ("창고", "", "", "", ""),
        ("국제지원팀", "", "", "", ""),
        ("창업동아리실", "", "", "", ""),
        ("창업동아리실", "", "", "", ""),
        ("창업동아리실", "", "", "", ""),
        ("창업동아리실", "", "", "", ""),
        ("창업동아리실", "", "", "", ""),
        ("창업동아리실", "", "", "", ""),
        ("창업동아리실", "", "", "", ""),
        ("시설과", "", "", "", ""),
        ("Happycoll Center", "", "", "", ""),
        ("회의실", "", "", "", ""),
        ("회의실", "", "", "", ""),
        ("접견실", "", "", "", ""),
        ("국제지원팀", "", "", "", ""),
        ("상설감사장", "", "", "", ""),
        ("감사팀", "", "", "", ""),
        ("교무과", "", "", "", ""),
         */
        ("정보기술대학", "컴퓨터공학부", "교수", "채진석", "032-835-8427"),
        ("정보기술대학", "컴퓨터공학부", "교수", "박문주", "032-835-8459"),
        ("정보기술대학", "컴퓨터공학부", "송도산업단지캠퍼스조성사업단장", "홍윤식", "032-835-8495"),
        ("정보기술대학", "컴퓨터공학부", "교수", "최승식", "032-835-8498")
    ]
    
    var dataset_tmp = [
        ("감사", "본관 5층", "032-000-0000"),
        ("미래전략팀", "대학본부 2층", "032-000-0000"),
        ("교무과", "대학본부 3층", "032-000-0000"),
    ]
    
    /*
     Downloaded buildings info (sorted by 'id - 1')
    */
    var buildingsId: [Int] = []
    var buildingsTitle: [String] = []
    var buildingsLat: [String] = []
    var buildingsLog: [String] = []
    var buildingsCount: Int = 0
    
    /*
     Downloaded Departments info
    */
    
    
    /*
     Downloaded Offices info
    */
    
    var officesId: [Int] = []
    var officesTitle: [String] = []
    var officesBuildingId: [Int] = []
    var officesFloorId: [String] = []
    var officesRoomId: [String] = []
    var officesFilterId: [Int] = []
    var officesIsMain: [Bool] = []
    var officesCount: Int = 0
    
    func accessData() {
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: 1)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

