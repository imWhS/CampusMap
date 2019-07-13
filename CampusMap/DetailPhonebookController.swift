//
//  DetailPhonebookController.swift
//  CampusMap
//
//  Created by 손원희 on 20/02/2019.
//  Copyright © 2019 iamwhs. All rights reserved.
//

import UIKit
import Alamofire

class DetailPhonebookController: UIViewController {
    
    @IBOutlet var customSearchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    var receivedStr: String = ""
    let dpbList = UIApplication.shared.delegate as? AppDelegate

    
    lazy var list: [PeopleVO] = {
        var datalist = [PeopleVO]()
        
        for(building, department, position, name, phone) in dpbList!.dataset {
            
            NSLog("running for detail")
            
            let pvo = PeopleVO()
            if name != "" && building == receivedStr {
                pvo.strBtm = "\(name)  |  \(phone)"
                pvo.strTop = "\(department)  |  \(position)"
                datalist.append(pvo)
                NSLog("append datalist : \(pvo.strBtm)")
            }
        }
        return datalist
    }()
    
    @IBAction func back(_ sender: Any) {
        //self.presentingViewController?.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func callBtn(_ sender: UIButton) {
        let contentView = sender.superview
        let cell = contentView?.superview as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        
        let pURL = (self.list[indexPath!.row].strBtm)?.components(separatedBy: " | ")
    NSLog("URL : \(pURL![1])")
        if let phoneURL = URL(string: "tel://\(pURL![1])") {
            let application = UIApplication.shared
            if application.canOpenURL(phoneURL) {
                application.open(phoneURL, options: [:], completionHandler: nil)
            }
        }
 
    }
}

extension DetailPhonebookController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("list.count : \(self.list.count)")
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        let top = cell.viewWithTag(101) as? UILabel
        let btm = cell.viewWithTag(102) as? UILabel
        NSLog("Cell btm.text : \(btm?.text))")
        top?.text = row.strTop
        btm?.text = row.strBtm
        
        return cell
    }
}

extension DetailPhonebookController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("didSelectRowAt : \(indexPath.row))")
    }
    
}
