//
//  WmataAPIManager.swift
//  MetroFinder
//
//  Created by sanidhya on 12/6/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import Foundation

struct SomeThing : Decodable{
    let Stations : [StationInfo]
    
}
struct StationInfo : Decodable{
    let Name : String?
   let Code: String?
   let StationTogether1 : String?
   let StationTogether2 : String?
   let LineCode1 : String?
   let LineCode2 : String?
   let LineCode3 : String?
   let LineCode4 : String?
   let Lat : float_t?
   let Lon : float_t?
    let Address : AddressOne?
}

struct AddressOne :Decodable {
   let Street : String?
   let City: String?
   let State: String?
   let Zip: String?
}

class WmataAPI {
    
   
   // stationNames=[]
    
    func fetchMetroStations() {
        var stationNames: [String]
        stationNames=[]
        let urlObj=URLComponents(string: "https://api.wmata.com/Rail.svc/json/jStations")!
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
                let someThing=try JSONDecoder().decode(SomeThing.self, from: data)
               // print(something.Stations[0])
                
                for value in someThing.Stations{
                stationNames.append(value.Name!)
              }
                
              for name in stationNames{
               // print("INnfjbfjdbfdbf")
                  print(name)
              }
                
                
            }
            catch let error {
                //if we get here, need to set a breakpoint and inspect the error to see where there is a mismatch between JSON and our Codable model structs
                print(error)
                
                // self.delegate?.gymsNotFound(reason: .badData)
            }
        }
        
        task.resume()
        
        
       
        
        
    }
}
