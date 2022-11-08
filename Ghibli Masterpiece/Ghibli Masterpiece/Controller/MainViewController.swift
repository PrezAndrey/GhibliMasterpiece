//
//  ViewController.swift
//  Ghibli Masterpiece
//
//  Created by Андрей През on 02.09.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var films: [Film]? = nil
    var locations: [Location]? = nil
    var species: [Species]? = nil
    var people: [People]? = nil
    var vehicles: [Vehicle]? = nil
    let networkDataFetcher = NetworkDataFetcher()

    var currentValue = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { return }
        guard let chosenIndexPath = tableView.indexPathForSelectedRow?.row else { return }
        switch currentValue {
        case "Locations":
            guard let location = locations else { return }
//            detailVC.configureUI(with: location[chosenIndexPath])
            detailVC.location = location[chosenIndexPath]
            detailVC.currentValue = "l"
        case "Films":
            guard let film = films else { return }
            detailVC.film = film[chosenIndexPath]
            detailVC.currentValue = "f"
        case "People":
            guard let people = people else { return }
            detailVC.people1 = people[chosenIndexPath]
            detailVC.currentValue = "p"
        case "Vehicles":
            guard let vehicle = vehicles else { return }
            detailVC.vehicle = vehicle[chosenIndexPath]
            detailVC.currentValue = "v"
        case "Species":
            guard let species = species else { return }
            detailVC.species1 = species[chosenIndexPath]
            detailVC.currentValue = "s"
        default:
            print("No value")
        }
    }
    
    func configureTableView(data: String, url: String) {
        currentValue = data
        switch currentValue {
        case "Locations":
            networkDataFetcher.fetchLocationArray(urlString: url) { (locations) in
                guard let locationsArray = locations else { return }
                self.locations = locationsArray
                self.navigationItem.title = "Locations"
                self.tableView.reloadData()
            }
        case "Films":
            networkDataFetcher.fetchFilmArray(urlString: url) { (result) in
                guard let result = result else { return }
                self.films = result
                self.navigationItem.title = "Films"
                self.tableView.reloadData()
            }
        case "People":
            networkDataFetcher.fetchPeopleArray(urlString: url) { (people) in
                guard let peopleArray = people else { return }
                self.people = peopleArray
                print("Array: \(peopleArray)")
                self.navigationItem.title = "People"
                self.tableView.reloadData()
            }
        case "Vehicles":
            networkDataFetcher.fetchVehicleArray(urlString: url) { (vehicles) in
                guard let vehiclesArray = vehicles else { return }
                self.vehicles = vehiclesArray
                self.navigationItem.title = "Vehicles"
                self.tableView.reloadData()
            }
        case "Species":
            networkDataFetcher.fetchSpeciesArray(urlString: url) { (species) in
                guard let speciesArray = species else { return }
                self.species = speciesArray
                self.tableView.reloadData()
                self.navigationItem.title = "Species"
            }
        default:
            print("No value")
        }
    }
    
    func configureImage(_ str: String?) -> UIImage {
        var image = UIImage(named: "noImage")!
        guard let str = str,
              let url = URL(string: str)
        else { return image }
        
        
        if let data = try? Data(contentsOf: url) {
            image = UIImage(data: data) ?? image
        }
        return image
    }
}

// MARK: TABLE VIEW CONFIGURATION
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "details", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var amountOfRows = 0
        
        switch currentValue {
        case "Locations":
            guard let amount = locations?.count else { return 0 }
            amountOfRows = amount
        case "Films":
            guard let amount = films?.count else { return 0 }
            amountOfRows = amount
        case "People":
            guard let amount = people?.count else { return 0 }
            amountOfRows = amount
        case "Vehicles":
            guard let amount = vehicles?.count else { return 0 }
            amountOfRows = amount
        case "Species":
            guard let amount = species?.count else { return 0 }
            amountOfRows = amount
        default:
            print("No value")
        }
        return amountOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MainTableViewCell
        
        switch currentValue {
        case "Locations":
            guard let currentLocation = locations?[indexPath.row] else { return cell }
            cell.filmName.text = currentLocation.name
            cell.directorLable.text = currentLocation.terrain
            cell.originalName.text = currentLocation.climate
            cell.filmImage.image = UIImage(named: "noImage")
        case "Films":
            guard let currentFilm = films?[indexPath.row] else { return cell }
            cell.filmName.text = currentFilm.title
            cell.directorLable.text = currentFilm.director
            cell.originalName.text = currentFilm.original_title
            guard let imageString = currentFilm.image,
                let imageUrl = URL(string: imageString) else { return cell }
            if let imageData = try? Data(contentsOf: imageUrl) {
                cell.filmImage.image = UIImage(data: imageData)
            }
        case "People":
            guard let currentPeople = people?[indexPath.row] else { return cell }
            cell.filmName.text = currentPeople.name
            cell.directorLable.text = currentPeople.species
            cell.originalName.text = currentPeople.gender
            cell.filmImage.image = UIImage(named: "noImage")
        case "Vehicles":
            guard let currentVehicle = vehicles?[indexPath.row] else { return cell }
            cell.filmName.text = currentVehicle.name
            cell.directorLable.text = currentVehicle.vehicle_class
            cell.originalName.text = currentVehicle.pilot
            cell.filmImage.image = UIImage(named: "noImage")
        case "Species":
            guard let currentSpecies = species?[indexPath.row] else { return cell }
            cell.filmName.text = currentSpecies.name
            cell.directorLable.text = currentSpecies.classification
            cell.originalName.text =  ""
            cell.filmImage.image = UIImage(named: "noImage")
        default:
            print("No value")
        }

        return cell
    }
    
}

