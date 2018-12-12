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

    @IBOutlet weak var imageOflandmark: UIImageView!
    @IBOutlet weak var nameofLandmark: UILabel!
    @IBOutlet weak var phoneNumberofLandmark: UILabel!
    
    @IBAction func shareButton(_ sender: Any) {
        
        let shareText = "Hi check out " + landmarkNames[myindex] + " with Yelp rating: " + landmarkRating[myindex].description
        
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func mapsButton(_ sender: Any) {
        //Defining destination
        let latitude:CLLocationDegrees = landmarkLatitude[myindex]
        let longitude:CLLocationDegrees = landmarkLongititude[myindex]
        
        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = landmarkNames[myindex]
        mapItem.openInMaps(launchOptions: options)
        
    }
    
    
    
    
    @IBAction func favourites(_ sender: Any) {
        let workout = FavouriteLandMarkModel(name: landmarkNames[myindex], url: landmarkImages[myindex])
        PersistenceManager.sharedInstance.saveWorkout(workout: workout)

    }
    
    @IBAction func unfavourite(_ sender: Any) {
        PersistenceManager.sharedInstance.remove(name: landmarkNames[myindex])
    }
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        navigationItem.title="Landmark Details"
        navigationController?.navigationBar.prefersLargeTitles=false
        
          nameofLandmark.text=landmarkNames[myindex]
        
        Alamofire.request(landmarkImages[myindex]).responseImage(completionHandler: {response in
            DispatchQueue.main.async {
                self.imageOflandmark.image=response.result.value
            }
        }
        )
        
        phoneNumberofLandmark.text = "Ratings : " + landmarkRating[myindex].description
        
       
        
    }
    

   

}
