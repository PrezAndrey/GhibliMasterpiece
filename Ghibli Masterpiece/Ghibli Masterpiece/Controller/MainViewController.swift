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
    var filmsUrlString = ""
    var peopleUrlString = ""
    var locationsUrlString = ""
    var speciesUrlString = ""
    var vehiclesUrlString = ""
    var currentValue = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            if let detailVC = segue.destination as? DetailViewController {
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    guard let currentFilm = films?[indexPath.row] else { return }
                    detailVC.film = currentFilm
                }
            }
        }
    }
    
    func configureTableView(data: String, url: String) {
        currentValue = data
        switch currentValue {
        case "Locations":
            networkDataFetcher.fetchLocationArray(urlString: url) { (locations) in
                guard let locationsArray = locations else { return }
                self.locations = locationsArray
                self.tableView.reloadData()
            }
        case "Films":
            networkDataFetcher.fetchFilmArray(urlString: filmsUrlString) { (result) in
                guard let result = result else { return }
                self.films = result
                self.tableView.reloadData()
            }
        case "People":
            networkDataFetcher.fetchPeopleArray(urlString: url) { (people) in
                guard let peopleArray = people else { return }
                self.people = peopleArray
                self.tableView.reloadData()
            }
        case "Vehicles":
            networkDataFetcher.fetchVehicleArray(urlString: url) { (vehicles) in
                guard let vehiclesArray = vehicles else { return }
                self.vehicles = vehiclesArray
                self.tableView.reloadData()
            }
        case "Species":
            networkDataFetcher.fetchSpeciesArray(urlString: url) { (species) in
                guard let speciesArray = species else { return }
                self.species = speciesArray
                self.tableView.reloadData()
            }
        default:
            print("No value")
        }
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
        films?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FilmTableViewCell
        
        guard let currentFilm = films?[indexPath.row] else { return cell }
        
        cell.filmName.text = currentFilm.title
        cell.directorLable.text = currentFilm.director
        cell.originalName.text = currentFilm.original_title
        
        
        guard let imageString = currentFilm.image,
            let imageUrl = URL(string: imageString) else { return cell }
        
        if let imageData = try? Data(contentsOf: imageUrl) {
            cell.filmImage.image = UIImage(data: imageData)
        }

        return cell
    }
    
}

