//
//  YelpTableViewController.swift
//  MetroFinder
//
//  Created by sanidhya on 12/8/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import AlamofireImage

var landmarkNames = [String]()
var landmarkImages = [String]()
var check = ""
var landmarkDetails : [LandmarkDetails] = []

class YelpTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
   // let cellFourID="CellIDxxxxxx"
    let yelapi=YelpAPI()
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
        navigationItem.title="Landmarks Nearby"
        navigationController?.navigationBar.prefersLargeTitles=true
        landmarkNames.removeAll()
        landmarkImages.removeAll()
   //    tableView.register(YelpTableViewCell.self, forCellReuseIdentifier: "cellFourID")
        
        SVProgressHUD.show(withStatus: "Loading")
        if check != stationNames[myindex] {
            check = stationNames[myindex] 
            callyelp()
        }
      
    }
    
    func callyelp(){
        yelapi.fetchlandmarks(selectedStationName: stationNames[myindex]){(results:yelpres) in
            
            for value in results.businesses{
                landmarkNames.append(value.name!)
                landmarkDetails.append(LandmarkDetails(landmarkname: value.name!, landmarkurl: value.image_url!))
                landmarkImages.append(value.image_url!)
            }
            for name in landmarkNames{
                
             //   print(name)
            }

            
            
            SVProgressHUD.dismiss()
            DispatchQueue.main.async{
                self.tableView.register(YelpTableViewCell.self, forCellReuseIdentifier: "cellFourID")
                self.tableView.reloadData()
            }
        }
    }


    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  let cell=tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! YelpTableViewController
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFourID") as! YelpTableViewCell
       let name=landmarkNames[indexPath.row]
        
        let fff=landmarkDetails[indexPath.row]
    //   cell.textLabel?.text = name
      //  print(cell.textofindividualcell.text  as Any)
        cell.setlandmarks(xxxx: fff)
            cell.textofindividualcell?.text = fff.landmarkname
               // print("hi here " + cell.textOfLandmark.text!)
        
       //cell.textOfLandmark.text = name
        print(cell.textofindividualcell?.text as Any)
        
        
    Alamofire.request(landmarkImages[indexPath.row]).responseImage(completionHandler: { response in
        
        if var image = response.result.value{
            DispatchQueue.main.async {
                cell.imageofindividualcell?.image = image
                print(image)
            }
            
        }
        
            }
            )
        
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return landmarkNames.count
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myindex=indexPath.row
        performSegue(withIdentifier: "seguetolast", sender: self)
    }
    

}
