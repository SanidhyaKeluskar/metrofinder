//
//  NearestTableViewController.swift
//  MetroFinder
//
//  Created by sanidhya on 12/8/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD

var mysecondindex=0
var zippp=""
var userlatitude : Double = 0.0
var userlongitude : Double = 0.0
var  coordinatetwo = CLLocation(latitude: 0.0, longitude: 0.0)

class NearestTableViewController: UITableViewController {
    
    let wmata=WmataAPI()
    let locationDetector = LocationDetector()
    
    let cellTwoID="CellIDTWOThreee"
    
    override func viewDidLoad() {
  
        super.viewDidLoad()
        
        locationDetector.delegate = (self as LocationDetectorDelegate)
        locationDetector.findLocation()
        
        
        
        let userlocation = HomeViewController()
        
        
     
        navigationItem.title="Nearest Station"
        navigationController?.navigationBar.prefersLargeTitles=true
        
        
        SVProgressHUD.show(withStatus: "Loading")
        
       // stationNames.removeAll()
        if(userlatitude>0.0){
            
            fetchxxxx( )
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationNames.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CellTwoID", for: indexPath)
        let name=stationNames[indexPath.row]
        cell.textLabel?.text = name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myindex=indexPath.row
        performSegue(withIdentifier: "Seguethree", sender: self)
    }
    
    func fetchxxxx( )
    {
        
   
        SVProgressHUD.dismiss()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellTwoID")
        
        
        wmata.fetchMetroStations(){(results:SomeThing) in
             stationNames.removeAll()
            for value in results.Stations{
                var stationlat=value.Lat
                var stationlon=value.Lon
                
                var coordinateone = CLLocation(latitude: stationlat!, longitude: stationlon!)
                
                
                var distanceInMeters = coordinateone.distance(from: coordinatetwo)
                
                
                if (distanceInMeters <= 1402.336){
                    stationNames.append(value.Name!)
                }
                
            }
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
            
            for name in stationNames{
                
                print(name)
            }
            
        }
    }
    

}


extension NearestTableViewController: LocationDetectorDelegate {
    func locationDetected(latitude: Double, longitude: Double) {
        print(latitude)
        print(longitude)
        userlatitude=latitude
        userlongitude=longitude
        coordinatetwo = CLLocation(latitude: userlatitude, longitude: userlongitude)
        
        
        DispatchQueue.main.async {
                //TODO: Show a AlertController with error
    //    stationNames.removeAll()
            self.fetchxxxx()
        
        }
        
    }
    
    func locationNotDetected() {
        print("no location found :(")
        
        //TODO: Show a AlertController with error
    }
    
    func locationZipCode(zipcode : String){
        
    }
    
    
}
