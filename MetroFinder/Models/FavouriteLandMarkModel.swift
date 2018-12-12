//
//  FavouriteLandMarkModel.swift
//  MetroFinder
//
//  Created by sanidhya on 12/10/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import Foundation

struct FavouriteLandMarkModel: Codable {
    let name: String
    let url: String
    let landmarkLat : Double
    let landmarkLong : Double
    let landmarkRating : float_t
}

