//
//  WmataAPIManager.swift
//  MetroFinder
//
//  Created by sanidhya on 12/6/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import Foundation


var  xxxx = [String]()


class WmataAPI {
    
    let myUrl = "https://api.wmata.com/Rail.svc/json/jStations"
    let method = "GET"
    let key = "cf7675512b6b450395270a38112a4042"
    let headerField = "api_key"

    func fetchMetroStations(completion:@escaping(SomeThing)->()) {
     
        var somethingxx:SomeThing!
     
        let urlObj=URLComponents(string: myUrl)!
        let url = urlObj.url!
        var request = URLRequest(url: url)
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
                let someThing=try JSONDecoder().decode(SomeThing.self, from: data)
               
                somethingxx=someThing
                
            }
                
            catch let error {
                
                print(error)
                
                
            }
            completion(somethingxx)
        }
        
       
        task.resume()
        
    }
    
}
