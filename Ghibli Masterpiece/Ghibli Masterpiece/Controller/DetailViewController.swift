//
//  DetailViewController.swift
//  Ghibli Masterpiece
//
//  Created by Андрей През on 05.09.2022.
//

import UIKit


class DetailViewController: UIViewController {
    
    var film: Film?
    let networkDataFetcher = NetworkDataFetcher()
    var people = [People]()
    var species = [Species]()
    var locations = [Location]()
    var vehicles = [Vehicle]()
    var films = [Film]()
    
    
    @IBOutlet weak var vehicleBlock: UIStackView!
    @IBOutlet weak var locationsBlock: UIStackView!
    @IBOutlet weak var speciesBlock: UIStackView!
    @IBOutlet weak var peopleBlock: UIStackView!
    @IBOutlet weak var filmBlock: UIStackView!
    
    var currentIndexPath = 0
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var directorLable: UILabel!
    @IBOutlet weak var producerLable: UILabel!
    @IBOutlet weak var releaseDate: UILabel!

    @IBOutlet weak var locationsCollectionView: UICollectionView!
    @IBOutlet weak var peopleCollectionView: UICollectionView!
    @IBOutlet weak var speciesCollectionView: UICollectionView!
    @IBOutlet weak var filmsCollectionView: UICollectionView!
    @IBOutlet weak var vehiclesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI(film)
    }
    
    // Configuration functions
    func configureUI(_ film: Film?) {
        if let film = film {
            
            fillUpSpeciesList(urls: film.species!)
            fillUpPeopleList(urls: film.people!)
            fillUpLocationList(urls: film.locations!)
            fillUpVehicleList(urls: film.vehicles!)
            configureImage(film.movie_banner)
            descriptionLable.text = film.description
            directorLable.text = film.director
            producerLable.text = film.producer
            releaseDate.text = film.release_date

            navigationItem.title = film.title
        }
    }
    
    func configureWithPeople(_ people: People?) {
        if let people = people {
            
            fillUpSpeciesList(url: people.species!)
            fillUpFilmList(urls: people.films!)
            
            descriptionLable.text = people.gender
            directorLable.text = people.age
            producerLable.text = people.eye_color
            releaseDate.text = people.hair_color

            navigationItem.title = people.name
        }
    }
    
    func configureImage(_ str: String?) {
        guard let str = str,
              let url = URL(string: str)
        else { return }
        
        if let data = try? Data(contentsOf: url) {
            imageView.image = UIImage(data: data)
        }
    }
    
    func fillUpPeopleList(urls: [String]) {
        
        for i in urls {
            if i.hasSuffix("people/"){
                networkDataFetcher.fetchPeopleArray(urlString: i) { (people) in
                    guard let people = people else { return }
                    self.people = people
                    self.peopleCollectionView.reloadData()
                }
            } else {
                networkDataFetcher.fetchPeopleData(urlString: i) { (people) in
                    guard let people = people as? People else { return }
                    self.people.append(people)
                    self.peopleCollectionView.reloadData()
                }
            }
        }
    }
    
    func fillUpSpeciesList(urls: [String]) {
        for i in urls {
            networkDataFetcher.fetchSpeciesData(urlString: i) { (species) in
                guard let species = species as? Species else { return }
                self.species.append(species)
                self.speciesCollectionView.reloadData()
            }
        }
    }
    
    func fillUpSpeciesList(url: String) {
        networkDataFetcher.fetchSpeciesData(urlString: url) { (species) in
            guard let species = species as? Species else { return }
            self.species.append(species)
            self.speciesCollectionView.reloadData()
        }
    }
    
    func fillUpFilmList(urls: [String]) {
        for i in urls {
            networkDataFetcher.fetchData(urlString: i) { (films) in
                guard let filmes = films as? Film else { return }
                self.films.append(filmes)
                self.speciesCollectionView.reloadData()
            }
        }
    }
    
    func fillUpLocationList(urls: [String]) {
        for i in urls {
            if i.hasSuffix("locations/") {
                networkDataFetcher.fetchLocationArray(urlString: i) { (locations) in
                    guard let locations = locations as? [Location] else { return }
                    self.locations = locations
                    self.locationsCollectionView.reloadData()
                }
            } else {
                networkDataFetcher.fetchLocationData(urlString: i) { (locations) in
                    guard let locations = locations as? Location else { return }
                    self.locations.append(locations)
                    self.locationsCollectionView.reloadData()
                }
            }
        }
    }
    
    func fillUpVehicleList(urls: [String]) {
        for i in urls {
            if i.hasSuffix("vehicles/") {
                networkDataFetcher.fetchVehicleArray(urlString: i) { (vehicles) in
                    guard let vehicles = vehicles as? [Vehicle] else { return }
                    self.vehicles = vehicles
                    self.vehiclesCollectionView.reloadData()
                }
            } else {
                networkDataFetcher.fetchVehicleData(urlString: i) { (vehicles) in
                    guard let vehicles = vehicles as? Vehicle else { return }
                    self.vehicles.append(vehicles)
                    self.vehiclesCollectionView.reloadData()
                }
            }
        }
    }
}


extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case peopleCollectionView:
            return people.count
        case speciesCollectionView:
            return species.count
        case locationsCollectionView:
            return locations.count
        case vehiclesCollectionView:
            return vehicles.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case peopleCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "peopleCell", for: indexPath) as! PeopleCollectionViewCell
            cell.peopleLabel.text = people[indexPath.row].name
            return cell
        case speciesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "speciesCell", for: indexPath) as! SpeciesCollectionViewCell
            cell.speciesLable.text = species[indexPath.row].name
            return cell
        case locationsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "locationCell", for: indexPath) as! LocationCollectionViewCell
            cell.locationLabel.text = locations[indexPath.row].name
            return cell
        case vehiclesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "vehicleCell", for: indexPath) as! VehicleCollectionViewCell
            cell.vehicleName.text = vehicles[indexPath.row].name
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == peopleCollectionView {
            configureWithPeople(people[indexPath.row])
        }
    }
}
