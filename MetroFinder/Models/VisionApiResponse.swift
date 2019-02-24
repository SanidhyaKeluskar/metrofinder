//
//  VisionApiResponse.swift
//  MetroFinder
//
//  Created by sanidhya on 12/14/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import Foundation

struct visionapiresponse : Codable{
    let responses : [xxxxxxxx]
}

struct xxxxxxxx : Codable{
    let textAnnotations : [yyyyy]
   
}

struct yyyyy : Codable{
    let locale : String?
    //let locale : String?
    let description : String?
}



