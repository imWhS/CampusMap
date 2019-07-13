//
//  DepartmentController.swift
//  CampusMap
//
//  Created by 손원희 on 15/02/2019.
//  Copyright © 2019 iamwhs. All rights reserved.
//

import Foundation
import UIKit

class DepartmentController: UIViewController {
    
    let ctmFont = UIFont(name: "NanumSquareRound", size: 16)
    
    @IBOutlet var searchBar: UITextField!
    
    let dpList = UIApplication.shared.delegate as? AppDelegate
    
    lazy var list: [DepartmentVO] = {
        var datalist = [DepartmentVO]()
        
        for(department, building, phone) in dpList!.dataset_tmp {
            NSLog("running for")
            let dvo = DepartmentVO()
            dvo.str_left = "\(department)"
            dvo.str_right = "\(building)"
            datalist.append(dvo)
        }
        return datalist
    }()
    
    func initNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "bgWhite"), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.presentingViewController!.dismiss(animated: true);
    }
    
    func customizingNavigationBar() {
        let navView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 100))
        navView.backgroundColor = UIColor.red
        self.navigationItem.titleView = navView
        
        let hide_back = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let leftItem = UIBarButtonItem(customView: hide_back)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    @objc func back() {
        //self.navigationController?.popViewController(animated: false)
        self.presentingViewController!.dismiss(animated: true);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.initNavigationBar()
        //self.customizingNavigationBar()
        self.searchBar.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        UIView.animate(withDuration: 0.3) {
            self.searchBar.center.x -= 44
            self.searchBar.center.y -= 5
        }
    }
    

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.searchBar.resignFirstResponder()
    }
    
}

extension DepartmentController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NSLog("Inserting cells...")
        let row = self.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        
        let cell_str_left = cell.viewWithTag(101) as? UILabel
        let cell_str_right = cell.viewWithTag(102) as? UILabel
        cell_str_left?.text = row.str_left
        cell_str_right?.text = row.str_right
        
        cell_str_left?.numberOfLines = 0
        var maximumLabelSize: CGSize = CGSize(width: 220, height: 9999)
        var expectedLabelSize: CGSize = (cell_str_left?.sizeThatFits(maximumLabelSize))!
        var newFrame: CGRect = (cell_str_left?.frame)!
        newFrame.size.height = expectedLabelSize.height
        newFrame.size.width = expectedLabelSize.width
        cell_str_left?.frame = newFrame
        
        cell_str_right?.center.x += newFrame.size.width - 45
        
        return cell
    }
}
