//
//  VisionAPIRequestBody.swift
//  MetroFinder
//
//  Created by sanidhya on 12/14/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import Foundation


struct Post: Codable {
    let requests: [layer]

}

struct layer: Codable {
    let image: layerTwo
    let features : [layerThree]
}

struct layerTwo: Codable {
    let content: String
}

struct layerThree: Codable {
    let type: String
}
