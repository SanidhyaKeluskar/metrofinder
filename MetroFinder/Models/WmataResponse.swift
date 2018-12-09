//
//  WmataResponse.swift
//  MetroFinder
//
//  Created by sanidhya on 12/7/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import Foundation
struct SomeThing : Codable{
    let Stations : [StationInfo]
    
}
struct StationInfo : Codable{
    let Name : String?
    let Code: String?
    let StationTogether1 : String?
    let StationTogether2 : String?
    let LineCode1 : String?
    let LineCode2 : String?
    let LineCode3 : String?
    let LineCode4 : String?
    let Lat : Double?
    let Lon : Double?
    let Address : AddressOne?
}

struct AddressOne :Codable {
    let Street : String?
    let City: String?
    let State: String?
    let Zip: String?
}
