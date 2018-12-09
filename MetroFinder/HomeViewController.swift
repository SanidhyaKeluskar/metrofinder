//
//  HomeViewController.swift
//  MetroFinder
//
//  Created by sanidhya on 12/8/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController {
    let locationDetector = LocationDetector()
    var userZipCode=""
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Hello")
        locationDetector.delegate = (self as LocationDetectorDelegate)
        locationDetector.findLocation()
        // Do any additional setup after loading the view.
    }
    

}
extension HomeViewController: LocationDetectorDelegate {
    func locationDetected(latitude: Double, longitude: Double) {
       print(latitude)
       print(longitude)
        
    }
    
    func locationNotDetected() {
        print("no location found :(")
      
            //TODO: Show a AlertController with error
        }
    
    func locationZipCode(zipcode : String){
        userZipCode=zipcode
        
        print(userZipCode)
    }
    
    
}
