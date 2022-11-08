//
//  LibraryViewController.swift
//  Ghibli Masterpiece
//
//  Created by Андрей  on 03.11.2022.
//

import UIKit

class LibraryViewController: UIViewController {

    @IBAction func didMoveToFilms(_ sender: Any) {
    }
    
    @IBAction func didMoveToPeople(_ sender: Any) {
    }
    
    @IBAction func didMoveToLocations(_ sender: Any) {
    }
    
    @IBAction func didMoveToSpecies(_ sender: Any) {
    }
    
    @IBAction func didMoveToVehicles(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mainVC = segue.destination as? MainViewController else { return }
        switch segue.identifier {
        case "moveToFilms":
            mainVC.configureTableView(data: "Films", url: "https://ghibliapi.herokuapp.com/films/")
        case "moveToPeople":
            mainVC.configureTableView(data: "People", url: "https://ghibliapi.herokuapp.com/people/")
        case "moveToLocations":
            mainVC.configureTableView(data: "Locations", url: "https://ghibliapi.herokuapp.com/locations/")
        case "moveToSpecies":
            mainVC.configureTableView(data: "Species", url: "https://ghibliapi.herokuapp.com/species/")
        case "moveToVehicles":
            mainVC.configureTableView(data: "Vehicles", url: "https://ghibliapi.herokuapp.com/vehicles/")
        default:
            print("Error")
        }
    }
}
