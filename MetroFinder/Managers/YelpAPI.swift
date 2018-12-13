//
//  YelpAPI.swift
//  MetroFinder
//
//  Created by sanidhya on 12/8/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import Foundation
import UIKit

class YelpAPI {
    
    let myUrl = "https://api.yelp.com/v3/businesses/search"
    let method = "GET"
    let key = "Bearer Y7IIfy2RXcCawmIsrc-ENW4iP3Mp2esOTJxk468MNjuyUOR1FxwzAcEyxIdhHbLiEpF-dvIdOljhUPtmM2ALLSqdB9QzDxttn55G79GN65o1gS7yRqGPsvE1hoAMXHYx"
    let headerField = "Authorization"
    
    let term = "term"
    let location = "location"
    let latitude = "latitude"
    let longitude = "longitude"
    let typeOfsearch = "food"
    
    func fetchlandmarks(selectedStationName : String, selectedLat : Double, selectedLong : Double , completion:@escaping(yelpres)->()) {
        
        var xxttt:yelpres!
        
        
        var urlObj=URLComponents(string: myUrl)
        
        let queryItemToken = URLQueryItem(name: term, value: typeOfsearch)
        let queryItemQuery = URLQueryItem(name: location, value: selectedStationName)
        let queryItemLat = URLQueryItem(name: latitude, value: selectedLat.description)
        let queryItemLong = URLQueryItem(name: longitude, value: selectedLong.description)
        
        urlObj!.queryItems = [queryItemToken, queryItemLat, queryItemLong]
        
        let url = urlObj?.url!
        
        var request = URLRequest(url: url!)
        request.httpMethod = method
        request.setValue(key, forHTTPHeaderField: headerField)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            guard let response = response as? HTTPURLResponse else {
                
                return
            }
            
            guard response.statusCode == 200 else {
                
                return
            }
            
            guard let data = data else {
                
                return
            }
            
            do{
                let yelpjson=try JSONDecoder().decode(yelpres.self, from: data)
                
                xxttt=yelpjson
                
           
                
            }
                
            catch let error {
                
                print(error)
                
                
            }
            completion(xxttt)
        }
        
        
        task.resume()
        
    }
}
