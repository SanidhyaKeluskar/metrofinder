//
//  PeristenceManager.swift
//  MetroFinder
//
//  Created by sanidhya on 12/10/18.
//  Copyright © 2018 sanidhya. All rights reserved.
//

import Foundation

class PersistenceManager {
    static let sharedInstance = PersistenceManager()
    
    let workoutsKey = "workouts"
    
    func saveWorkout(workout: FavouriteLandMarkModel)-> Bool {
        let userDefaults = UserDefaults.standard
        
        var workouts = fetchWorkouts()
        
        for value in workouts{
            if(value.name==workout.name){
                return false
            }
            
        }
        workouts.append(workout)
        
        let encoder = JSONEncoder()
        let encodedWorkouts = try? encoder.encode(workouts)
        
        userDefaults.set(encodedWorkouts, forKey: workoutsKey)
        return true
    }
    
    func fetchWorkouts() -> [FavouriteLandMarkModel] {
        let userDefaults = UserDefaults.standard
        
        if let workoutData = userDefaults.data(forKey: workoutsKey), let workouts = try? JSONDecoder().decode([FavouriteLandMarkModel].self, from: workoutData) {
            //workoutData is non-nil and successfully decoded
            return workouts
        }
        else {
            return [FavouriteLandMarkModel]()
        }
    }
    
    func remove(name: String) {
        let userDefaults = UserDefaults.standard
        var workouts = fetchWorkouts()
        var indexone : Int
        
        for (index, element) in workouts.enumerated() {
            if element.name == name{
                indexone = index
                workouts.remove(at: indexone)
            }
        }
        
        let encoder = JSONEncoder()
        let encodedWorkouts = try? encoder.encode(workouts)
        
        userDefaults.set(encodedWorkouts, forKey: workoutsKey)
 

    }
    
}
