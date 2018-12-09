//
//  YelpResponse.swift
//  MetroFinder
//
//  Created by sanidhya on 12/8/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import Foundation

struct yelpres : Codable{
   let businesses : [someotherthing]
}

struct someotherthing : Codable{
    let id : String?
    let alias : String?
    let name : String?
    let image_url : String?
  //  let is_closed : Int?
    let url : String?
    let review_count : Int?
    let categories : [categoryDetails]
    let rating : float_t?
    let coordinates : cordinatesDetails
    let transactions : [String]?
    let price : String?
    let location : locationDetails?
    let phone : String?
    let display_phone : String?
    let distance : Double?
}

struct categoryDetails : Codable{
    let alias : String?
    let title : String?
}
struct locationDetails : Codable{
    let address1 : String?
    let address2 : String?
    let address3 : String?
    let city : String?
    let zip_code : String?
    let country : String?
    let state : String?
    let display_address : [String]?
}

struct cordinatesDetails : Codable{
    let latitude : Double?
    let longitude : Double?
}


