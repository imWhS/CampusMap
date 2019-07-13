//
//  ViewController.swift
//  CampusMap
//
//  Created by 손원희 on 12/02/2019.
//  Copyright © 2019 iamwhs. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, MTMapViewDelegate {
    var mapView: MTMapView?
    @IBOutlet var btnFilter: Floaty!
    
    @IBOutlet var DataLoadView: UIView!
    
    //Stage
    @IBOutlet var stageBG: UIView!
    @IBOutlet var imgStageLogo: UIImageView!
    @IBOutlet var textViewComment: UITextView!
    
    @IBOutlet var labelSearchField: UILabel!
    @IBOutlet var imgPoints: UIImageView!
    @IBOutlet var imgMyPoint: UIImageView!
    @IBOutlet var imgAsk: UIImageView!
    @IBOutlet var labelPoints: UILabel!
    @IBOutlet var labelMyPoint: UILabel!
    @IBOutlet var labelAsk: UILabel!
    @IBOutlet var labelAskComment: UITextView!
    @IBOutlet var labelMarker: UILabel!
    @IBOutlet var labelMarkerComment: UITextView!
    @IBOutlet var labelMyPos: UILabel!
    @IBOutlet var labelPhoneBook: UILabel!
    
    
    @IBOutlet var btnMyPos: UIButton!
    @IBOutlet var btnCall: UIButton!
    @IBOutlet var searchBar: UIView!
    
    @IBOutlet var btnClose: UIButton!
    
    
    let buildingsId = (UIApplication.shared.delegate as? AppDelegate)?.buildingsId
    let buildingsTitle = (UIApplication.shared.delegate as? AppDelegate)?.buildingsTitle
    let buildingsLat = (UIApplication.shared.delegate as? AppDelegate)?.buildingsLat
    let buildingsLog = (UIApplication.shared.delegate as? AppDelegate)?.buildingsLog
    
    var currentLocationPoint: MTMapPointGeo?
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        currentLocationPoint = location.mapPointGeo()
        print("MTMapView updateCurrentLoation \(currentLocationPoint!.latitude), \(currentLocationPoint!.longitude), accuracy \(accuracy)")
        //mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: currentLocationPoint!.latitude, longitude: currentLocationPoint!.longitude)), zoomLevel: MTMapZoomLevel(1), animated: true)
    }
    
    func mapView(_ mapView: MTMapView!, updateDeviceHeading headingAngle: MTMapRotationAngle) {
        print("MTMapView updateDeviceHeading \(headingAngle) degress")
    }
    
    func setItemStyles() {
        btnMyPos.layer.shadowColor = UIColor.black.cgColor
        btnMyPos.layer.shadowOffset = CGSize(width: 0, height: 3.5)
        btnMyPos.layer.shadowRadius = 4
        btnMyPos.layer.shadowOpacity = 0.28
        
        btnCall.layer.shadowColor = UIColor.black.cgColor
        btnCall.layer.shadowOffset = CGSize(width: 0, height: 3.5)
        btnCall.layer.shadowRadius = 4
        btnCall.layer.shadowOpacity = 0.28
        
        searchBar.frame.origin.y += view.safeAreaInsets.top;
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 3.5)
        searchBar.layer.shadowRadius = 4
        searchBar.layer.shadowOpacity = 0.15
        searchBar.layer.cornerRadius = 4
        searchBar.layer.masksToBounds = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sharedData = UIApplication.shared.delegate as? AppDelegate
        let cntBuildings = buildingsId?.count
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
       
        
        setItemStyles()
        
        let helpStage = UIView()
        let screenSize: CGRect = UIScreen.main.bounds
        helpStage.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        let transBlack = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.6)
        helpStage.backgroundColor = transBlack
    
        mapView = MTMapView(frame: self.view.bounds)
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            mapView.currentLocationTrackingMode = .onWithoutHeading
            
            let poi_cur = MTMapLocationMarkerItem()
            poi_cur.customTrackingImageName = "icMylocation"
            poi_cur.customTrackingAnimationDuration = 0
            mapView.showCurrentLocationMarker = true
            mapView.updateCurrentLocationMarker(poi_cur)
            
            var poiItems = [MTMapPOIItem]()
            let ctmFont = UIFont(name: "NanumSquareRound", size: 16)
            let ctmFont2 = UIFont(name: "NanumSquareRound", size: 13)
            for i in 0..<cntBuildings! {
                let poi = MTMapPOIItem()
                poi.itemName = buildingsTitle![i]
                let dou_lat = Double(buildingsLat![i])!
                let dou_log = Double(buildingsLog![i])!
                poi.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: dou_lat, longitude: dou_log))
                poi.markerType = .customImage
                poi.customImage = UIImage(named: "markerLounge")
                poi.showAnimationType = .springFromGround
                poi.draggable = false
                poi.tag = i + 1
                
                //poi's view
                let vpoi = UIView()
                let vpoi_title = UILabel()
                let vpoi_cont = UITextView(frame: CGRect(x: 17.3, y: 40, width: 150, height: 200))
                let vpoi_ic = UIImageView(image: UIImage(named: "markerLounge"))
                
                vpoi_ic.frame = CGRect(x: 17.3, y: 16, width: 20.2, height: 24.5)
                vpoi_title.frame = CGRect(x: 45.7, y:4.7, width: 130, height: 50)
                vpoi_title.text = "\(poi.tag) \(poi.itemName!)"
                vpoi_title.font = ctmFont
                vpoi_title.accessibilityScroll(.left)
                vpoi_cont.font = ctmFont2
                vpoi_cont.text =
                """
                GS25
                NH농협은행
                """
                vpoi_cont.isEditable = false
                vpoi_cont.isSelectable = false
                
                vpoi.frame = CGRect(x: 0, y: 0, width: 180, height: 242)
                vpoi.layer.cornerRadius = 6
                vpoi.layer.masksToBounds = true
                
                vpoi.layer.shadowColor = UIColor.black.cgColor
                vpoi.layer.shadowOffset = CGSize(width: 0, height: 3.5)
                vpoi.layer.shadowRadius = 4
                vpoi.layer.shadowOpacity = 0.28
                vpoi.backgroundColor = UIColor.white
                vpoi.addSubview(vpoi_cont)
                vpoi.addSubview(vpoi_title)
                vpoi.addSubview(vpoi_ic)
                poi.customCalloutBalloonView = vpoi
                
                poiItems.append(poi)
            }
            
            //mapView.remove(<#T##poiItem: MTMapPOIItem!##MTMapPOIItem!#>)
            mapView.addPOIItems(poiItems)
            self.view.insertSubview(mapView, at: 0)
            self.view.insertSubview(stageBG, aboveSubview: mapView)
        }
        
        btnFilter.addItem(icon: UIImage(named: "btnConvenienceStore"), handler: {item in
        })
        btnFilter.addItem(icon: UIImage(named: "btnCafe"), handler: {item in
        })
        btnFilter.openAnimationType = .slideUp
        
        
        
        let floaty = Floaty()
        //floaty.frame = CGRect(x: 309, y: 590, width: 45, height: 45)
        floaty.buttonImage = UIImage(named: "btnFilter")
        floaty.hasShadow = false
        floaty.openAnimationType = .slideUp
        floaty.addItem(icon: UIImage(named: "btnConvenienceStore"), handler: {item in
            floaty.close()
        })
        floaty.addItem(icon: UIImage(named: "btnCafe"), handler: {item in
            floaty.close()
        })
        //self.view.addSubview(floaty)
    }
    
    @IBAction func myposBtn(_ sender: UIButton) {
        if let mapView = mapView {
            mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: currentLocationPoint!.latitude, longitude: currentLocationPoint!.longitude)), zoomLevel: MTMapZoomLevel(1), animated: true)
        }
    }
    
    @IBAction func btnCloseStage(_ sender: UIButton) {
        imgStageLogo.isHidden = true
        textViewComment.isHidden = true
        imgPoints.isHidden = true
        imgMyPoint.isHidden = true
        imgAsk.isHidden = true
        labelSearchField.isHidden = true
        labelPoints.isHidden = true
        labelMyPoint.isHidden = true
        labelAsk.isHidden = true
        labelAskComment.isHidden = true
        labelMyPos.isHidden = true
        labelPhoneBook.isHidden = true
        labelMarker.isHidden = true
        labelMarkerComment.isHidden = true
        btnClose.isHidden = true
        stageBG.isHidden = true
    }
    
    @IBAction func btnDepartment(_ sender: Any) {
        let departmentController = self.storyboard!.instantiateViewController(withIdentifier: "Department")
        departmentController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve;
        self.present(departmentController, animated: true);
    }
    
    
    @IBAction func btnPhonebook(_ sender: Any) {
        guard let phonebookController = self.storyboard?.instantiateViewController(withIdentifier: "Phonebook") else {
            return
        }
        self.navigationController?.pushViewController(phonebookController, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

