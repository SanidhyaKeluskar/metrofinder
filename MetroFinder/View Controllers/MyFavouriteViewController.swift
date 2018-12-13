//
//  MyFavouriteViewController.swift
//  MetroFinder
//
//  Created by sanidhya on 12/11/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MyFavouriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellID="MyFavouriteLandmark"
    let tittle = "Favourites"
    let sequeIdentifier = "segueten"
    
  var fetchedFavouriteLandmarks = PersistenceManager.sharedInstance.fetchFavouriteLandmarks()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = tittle
        navigationController?.navigationBar.prefersLargeTitles=false
        
        tableView.delegate = self
        tableView.dataSource = self

        landmarkNames.removeAll()
        landmarkImages.removeAll()
        landmarkLongititude.removeAll()
        landmarkLongititude.removeAll()
        landmarkRating.removeAll()
        
        for value in fetchedFavouriteLandmarks{
            landmarkNames.append(value.name)
            landmarkImages.append(value.url)
            landmarkRating.append(value.landmarkRating)
            landmarkLatitude.append(value.landmarkLat)
            landmarkLongititude.append(value.landmarkLong)
        }
        
        for value in landmarkNames {
            print(value)
        }
        for value in landmarkImages {
            print(value)
        }
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Fetch favourite Landmarks and display whenever view will appear
        fetchedFavouriteLandmarks = PersistenceManager.sharedInstance.fetchFavouriteLandmarks()
        super.viewWillAppear(animated)
        print("hiiiii")
        tableView.reloadData()
        landmarkNames.removeAll()
        landmarkImages.removeAll()
        landmarkLongititude.removeAll()
        landmarkLongititude.removeAll()
        landmarkRating.removeAll()
        landmarkAddress.removeAll()
        
        for value in fetchedFavouriteLandmarks{
            landmarkNames.append(value.name)
            landmarkImages.append(value.url)
            landmarkRating.append(value.landmarkRating)
            landmarkLatitude.append(value.landmarkLat)
            landmarkLongititude.append(value.landmarkLong)
            landmarkAddress.append( value.landmarkAddress )
        }
        
    }
    


}

extension MyFavouriteViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  fetchedFavouriteLandmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! MyFavouriteTableViewCell
        
        cell.myFavouriteLandmarkname.text = fetchedFavouriteLandmarks[indexPath.row].name
        
        Alamofire.request(fetchedFavouriteLandmarks[indexPath.row].url).responseImage(completionHandler: { response in
            
            if var image = response.result.value{
                DispatchQueue.main.async {
                    cell.myFavouriteLandmarkImage.image = image
                }
                
            }
            
        } )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myindex=indexPath.row
        performSegue(withIdentifier: sequeIdentifier, sender: self)
    }
}
