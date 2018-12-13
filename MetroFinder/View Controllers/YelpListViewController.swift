//
//  YelpListViewController.swift
//  MetroFinder
//
//  Created by sanidhya on 12/11/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import AlamofireImage

var landmarkNames = [String]()
var landmarkImages = [String]()
var landmarkLatitude = [Double]()
var landmarkLongititude = [Double]()
var landmarkRating = [float_t]()
var landmarkAddress = [String]()


var check = ""
var landmarkDetails : [LandmarkDetails] = []

class YelpListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let yelapi=YelpAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title="Landmarks"
        navigationController?.navigationBar.prefersLargeTitles=true
        
        tableView.delegate = self as! UITableViewDelegate
        tableView.dataSource = self as! UITableViewDataSource
        
        landmarkNames.removeAll()
        landmarkImages.removeAll()
        landmarkLongititude.removeAll()
        landmarkLongititude.removeAll()
        landmarkRating.removeAll()
        landmarkAddress.removeAll()
        
        SVProgressHUD.show(withStatus: "Loading")
   
            callyelp()
 

      
    }
    
    //fetches information from yelp API
    func callyelp(){
        yelapi.fetchlandmarks(selectedStationName: stationNames[myindex], selectedLat : stationLat[myindex], selectedLong : stationLong[myindex] ){(results:yelpres) in
            
            for value in results.businesses{
                landmarkNames.append(value.name!)
                landmarkDetails.append(LandmarkDetails(landmarkname: value.name!, landmarkurl: value.image_url!))
                landmarkImages.append(value.image_url!)
                
                landmarkRating.append(value.rating!)
                landmarkLatitude.append(value.coordinates.latitude!)
                landmarkLongititude.append(value.coordinates.longitude!)
                landmarkAddress.append((value.location?.address1!)! + " " + (value.location?.city!)!)
                
            }
            
            
            SVProgressHUD.dismiss()
        
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
}
    
    extension YelpListViewController : UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return landmarkNames.count
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            myindex=indexPath.row
            performSegue(withIdentifier: "segueeight", sender: self)
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FifthCell") as! YelpListTableViewCell
         
            cell.nameOfYelpLandmark.text=landmarkNames[indexPath.row]
        
            Alamofire.request(landmarkImages[indexPath.row]).responseImage(completionHandler: { response in
                
                if var image = response.result.value{
                    DispatchQueue.main.async {
                        cell.imageOfYelpLandmark.image=image
                    }
                    
                }
                
            }
            )
            
            return cell
        }
        
        
        
    }
    



