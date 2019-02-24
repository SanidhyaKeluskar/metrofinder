//
//  VisionAPI.swift
//  MetroFinder
//
//  Created by sanidhya on 12/14/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import Foundation
import UIKit

class VisionAPI{
    let myUrl = "https://vision.googleapis.com/v1/images:annotate"
    let method = "POST"
    let key = "AIzaSyD1hjwHV3rjh4_By6nqX6o3PqDx2K9iR3A"
    let headerField = "Authorization"
    
    let term = "key"
    let location = "location"
    let latitude = "latitude"
    let longitude = "longitude"
    let typeOfsearch = "food"
    
    
    func fetchVisionCall( contentone : String, completion:@escaping(visionapiresponse)->()) {
        
        var xxttt:visionapiresponse!
        
        let x1 = layerThree(type :  "TEXT_DETECTION")
        var x4 = [layerThree]()
        x4.append(x1)
        let x2 = layerTwo(content : contentone)
        
        let x3 = layer(image: x2, features: x4 )
        
        var x5 = [layer]()
        x5.append(x3)
        
        let parameters = Post(requests : x5)
        
        
        var urlObj=URLComponents(string: myUrl)
        
        let queryItemToken = URLQueryItem(name: term, value: key)
     
        urlObj!.queryItems = [queryItemToken]
        
        let url = urlObj?.url!
        
        var request = URLRequest(url: url!)
        request.httpMethod = method
     //  request.setValue("Content-Type", forHTTPHeaderField: "application/json")
        let encoder = JSONEncoder()
       
        
        do {
           let jsonData = try encoder.encode(parameters)
           
            // ... and set our request's HTTP body
            request.httpBody = jsonData
             print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            
        }
        // ... and set our request's HTTP body
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let response=response{
                print(response)
            }
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
                let yelpjson=try JSONDecoder().decode(visionapiresponse.self, from: data)
                
                xxttt=yelpjson
                
                print(xxttt)
                
                
            }
                
            catch let error {
                
                print(error)
                
            }
            completion(xxttt)
        }
        
        
        task.resume()
        
    }
}
