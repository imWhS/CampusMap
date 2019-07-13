//
//  NetworkCallback.swift
//  CampusMap
//
//  Created by 손원희 on 03/04/2019.
//  Copyright © 2019 iamwhs. All rights reserved.
//

import Foundation

protocol NetworkCallback {
    func networkSuc(resultdata: Any, code: String)
    func networkFail(code: String)
}
