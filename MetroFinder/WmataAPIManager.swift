//
//  WmataAPIManager.swift
//  MetroFinder
//
//  Created by sanidhya on 12/6/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import Foundation

struct SomeThing : Decodable{
    let Station : [StationInfo]
    
}
struct StationInfo : Decodable{
    let name : String
}

class WmataAPIManager {
    
    
    func fetchMetroStations() {
        
        var urlObj=URLComponents(string: "https://api.wmata.com/Rail.svc/json/jStations")!
        let url = urlObj.url!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("cf7675512b6b450395270a38112a4042", forHTTPHeaderField: "api_key")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //PUT CODE HERE TO RUN UPON COMPLETION
            
            guard let response = response as? HTTPURLResponse else {
                
            //    self.delegate?.gymsNotFound(reason: .noResponse)
                
                return
            }
            
            guard response.statusCode == 200 else {
             //   self.delegate?.gymsNotFound(reason: .non200Response)
                
                return
            }
            
            //HERE - response is NOT nil and IS 200
            
            guard let data = data else {
              //  self.delegate?.gymsNotFound(reason: .noData)//
                
                return
            }
            
            do{
                let something=try JSONDecoder().decode(SomeThing.self, from: data)
                print(something.Station)
            }
            catch let error {
                //if we get here, need to set a breakpoint and inspect the error to see where there is a mismatch between JSON and our Codable model structs
                print(error.localizedDescription)
                
               // self.delegate?.gymsNotFound(reason: .badData)
            }
        }
        
        task.resume()
        
        
        
        
        
}
}
