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
    var nearstationname = ""
    var nearestLat : Double = 0.0
    var nearestLong : Double = 0.0
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
        
               if(userlatitude>0.0){
            
            fetchxxxx( )
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
        super.viewWillAppear(animated)
         stationNames.removeAll()
        stationLat.removeAll()
        stationLong.removeAll()
        
        stationNames.append(nearstationname)
        stationLat.append(nearestLat)
        stationLong.append(nearestLong)
        
        tableView.reloadData()
        
        
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
        performSegue(withIdentifier: "segueeleven", sender: self)
    }
    
    func fetchxxxx( )
    {
        
   
        SVProgressHUD.dismiss()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellTwoID")
        
        
        wmata.fetchMetroStations(){(results:SomeThing) in
            
            var mindist = 2000.000
            var mindiststationname = ""
            var mynearestStationlat : Double = 0.0
            var mynearestStationlong : Double = 0.0
            
             stationNames.removeAll()
            stationLat.removeAll()
            stationLong.removeAll()
            
        
            for value in results.Stations{
                var stationlat=value.Lat
                var stationlon=value.Lon
                
                var coordinateone = CLLocation(latitude: stationlat!, longitude: stationlon!)
                
                
                var distanceInMeters = coordinateone.distance(from: coordinatetwo)
                
                
                
                if (distanceInMeters < mindist){
                    
                    mindist = distanceInMeters
                    mindiststationname = value.Name!
                    mynearestStationlat = value.Lat!
                    mynearestStationlong = value.Lon!
                 
                }
                
            }
            
            self.nearstationname = mindiststationname
            self.nearestLat = mynearestStationlat
            self.nearestLong = mynearestStationlong
            
            stationNames.append(mindiststationname)
            stationLat.append(mynearestStationlat)
            stationLong.append(mynearestStationlong)
            
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
            
            self.fetchxxxx()
        
        }
        
    }
    
    func locationNotDetected() {
        print("no location found :(")
        
    
    }
    
    func locationZipCode(zipcode : String){
        
    }
    
    
}
