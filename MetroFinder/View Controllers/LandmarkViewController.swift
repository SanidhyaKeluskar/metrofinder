//
//  LandmarkViewController.swift
//  MetroFinder
//
//  Created by sanidhya on 12/9/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import MapKit

class LandmarkViewController: UIViewController{
    
    let sharingText = "Hi check out "
    let sharingTextTwo = " with Yelp rating: "
    let tittle = "Landmark Details"
    let ratings = "Ratings : "

    @IBOutlet weak var imageOflandmark: UIImageView!
    @IBOutlet weak var nameofLandmark: UILabel!
    @IBOutlet weak var phoneNumberofLandmark: UILabel!
    @IBOutlet weak var addressOfLandmark: UILabel!
    @IBAction func shareButton(_ sender: Any) {
        
        let shareText = sharingText + landmarkNames[myindex] + sharingTextTwo + landmarkRating[myindex].description
        
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func mapsButton(_ sender: Any) {
        //Open apple maps with navigation to yelp Landmark
        let latitude:CLLocationDegrees = landmarkLatitude[myindex]
        let longitude:CLLocationDegrees = landmarkLongititude[myindex]
        
        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span), MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeTransit] as [String : Any]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = landmarkNames[myindex]
        mapItem.openInMaps(launchOptions: options)
        
    }
    
    
    
    
    @IBAction func favourites(_ sender: Any) {
        let myfavourite = FavouriteLandMarkModel(name: landmarkNames[myindex], url: landmarkImages[myindex], landmarkLat : landmarkLatitude[myindex], landmarkLong : landmarkLongititude[myindex], landmarkRating : landmarkRating[myindex] , landmarkAddress : landmarkAddress[myindex] )
        PersistenceManager.sharedInstance.saveFavouriteLandmarks(favourites: myfavourite)

    }
    
    @IBAction func unfavourite(_ sender: Any) {
        PersistenceManager.sharedInstance.remove(name: landmarkNames[myindex])
    }
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        navigationItem.title = tittle
        navigationController?.navigationBar.prefersLargeTitles=false
        
          nameofLandmark.text=landmarkNames[myindex]
        
        Alamofire.request(landmarkImages[myindex]).responseImage(completionHandler: {response in
            DispatchQueue.main.async {
                self.imageOflandmark.image=response.result.value
            }
        }
        )
        
        phoneNumberofLandmark.text = ratings + landmarkRating[myindex].description
        
        addressOfLandmark.text = landmarkAddress[myindex]
        
        
       
        
    }
    

   

}
