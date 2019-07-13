//
//  PhonebookController.swift
//  CampusMap
//
//  Created by 손원희 on 13/02/2019.
//  Copyright © 2019 iamwhs. All rights reserved.
//

import UIKit
class PhonebookController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    let pbList = UIApplication.shared.delegate as? AppDelegate
    var needTrans: String = ""
    
    lazy var pbListItems: [PeopleVO] = {
        var tmpPbListItems = [PeopleVO]()
        let pvo = PeopleVO()

        print("Ready to append")
        print((UIApplication.shared.delegate as? AppDelegate)!.officesTitle)
        
        for(officeTitle) in (UIApplication.shared.delegate as? AppDelegate)!.officesTitle {
            pvo.typeB = "\(officeTitle)"
            tmpPbListItems.append(pvo)
        }
        
        for(building, department, position, name, phone) in pbList!.dataset {
            if name == "" {
                if position == "" {
                    //pvo.typeB = "\(building)"
                } else if position != "" {
                    pvo.strBtm = "\(name)  |  \(phone)"
                    pvo.strTop = "\(department)  |  \(position)"
                }
                tmpPbListItems.append(pvo)
            }
        }
        
        return tmpPbListItems
    }()
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
        //self.navigationController?.popViewController(animated: true)
    }
    
    func initNavigationBackBtn() {
        let back = UIImageView(image: UIImage(named: "btn_x"))
        back.frame = CGRect(x: 2, y: 10, width: 26.5, height: 26.5)
        let backView = UIView(frame: CGRect(x: 7, y: 10, width: 26.5, height: 26.5))
        backView.backgroundColor = UIColor.white
        backView.addSubview(back)
        let backItem = UIBarButtonItem(customView: backView)
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let height: CGFloat = 100
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
        initNavigationBackBtn()
    }
    
    @IBAction func searchFieldAction(_ sender: UITextField) {
        NSLog("Act : \(String(describing: sender.text!))")
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        guard let detailPhonebookController = dest as? DetailPhonebookController else { return }
        detailPhonebookController.receivedStr = self.needTrans
    }
}



extension PhonebookController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pbListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.pbListItems[indexPath.row]
        let cell_A = tableView.dequeueReusableCell(withIdentifier: "ListCell_TypeA")!
        let cell_B = tableView.dequeueReusableCell(withIdentifier: "ListCell_TypeB")!
    
        if row.typeB != nil {
            let top_B = cell_B.viewWithTag(201) as? UILabel
            top_B?.text = row.typeB
            NSLog("Cell top_B.text : \(top_B?.text))")
            return cell_B
        } else {
            let top = cell_A.viewWithTag(101) as? UILabel
            let btm = cell_A.viewWithTag(102) as? UILabel
            top?.text = row.strTop
            btm?.text = row.strBtm
            //btnCall?.addTarget(self, action: #selector(onBtnCall), for: .touchUpInside)
            cell_A.isHighlighted = false
            return cell_A
        }
    }
}

extension PhonebookController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        NSLog("didSelectRowAt : \(indexPath.row))")
        NSLog(" - dataset dept : \(self.pbListItems[indexPath.row].typeB)")
        NSLog(" - dataset name : \(self.pbList!.dataset[indexPath.row].1))")
        needTrans = self.pbListItems[indexPath.row].typeB!
        self.performSegue(withIdentifier: "ToDetail_pb", sender: self)
    }
}


