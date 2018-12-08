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

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Hello")
        locationDetector.delegate = (self as LocationDetectorDelegate)
        locationDetector.findLocation()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
    
    func locationZipCode(zipcode : Int){
        
    }
    
    
}
