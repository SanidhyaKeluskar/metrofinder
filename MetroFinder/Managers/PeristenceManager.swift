//
//  PeristenceManager.swift
//  MetroFinder
//
//  Created by sanidhya on 12/10/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import Foundation

class PersistenceManager {
    static let sharedInstance = PersistenceManager()
    
    let landmarkKeys = "myfavouriteLandmarks"
    
    func saveFavouriteLandmarks(favourites: FavouriteLandMarkModel)-> Bool {
        let userDefaults = UserDefaults.standard
        
        var myfavouriteLandmarks = fetchFavouriteLandmarks()
        
        for value in myfavouriteLandmarks{
            if(value.name==favourites.name){
                return false
            }
            
        }
        myfavouriteLandmarks.append(favourites)
        
        let encoder = JSONEncoder()
        let encodedmyfavouriteLandmarks = try? encoder.encode(myfavouriteLandmarks)
        
        userDefaults.set(encodedmyfavouriteLandmarks, forKey: landmarkKeys)
        return true
    }
    
    func fetchFavouriteLandmarks() -> [FavouriteLandMarkModel] {
        let userDefaults = UserDefaults.standard
        
        if let favouritesData = userDefaults.data(forKey: landmarkKeys), let myfavouriteLandmarks = try? JSONDecoder().decode([FavouriteLandMarkModel].self, from: favouritesData) {
            //favouritesData is non-nil and successfully decoded
            return myfavouriteLandmarks
        }
        else {
            return [FavouriteLandMarkModel]()
        }
    }
    
    func remove(name: String) {
        let userDefaults = UserDefaults.standard
        var myfavouriteLandmarks = fetchFavouriteLandmarks()
        var indexone : Int
        
        for (index, element) in myfavouriteLandmarks.enumerated() {
            if element.name == name{
                indexone = index
                myfavouriteLandmarks.remove(at: indexone)
            }
        }
        
        let encoder = JSONEncoder()
        let encodedmyfavouriteLandmarks = try? encoder.encode(myfavouriteLandmarks)
        
        userDefaults.set(encodedmyfavouriteLandmarks, forKey: landmarkKeys)
 

    }
    
}
