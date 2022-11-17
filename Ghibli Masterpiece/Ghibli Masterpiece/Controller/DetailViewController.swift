//
//  DetailViewController.swift
//  Ghibli Masterpiece
//
//  Created by Андрей През on 05.09.2022.
//

import UIKit


class DetailViewController: UIViewController {
    
    var currentValue: String?
    var state: String?
    var film: Film?
    var location: Location?
    var people1: People?
    var species1: Species?
    var vehicle: Vehicle?
    

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
    @IBOutlet weak var lastLabelBlock: UIStackView!
    
    var currentIndexPath = 0
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabelOne: UILabel!
    @IBOutlet weak var titleLabelTwo: UILabel!
    @IBOutlet weak var titleLabelThree: UILabel!
    @IBOutlet weak var titleLabelFour: UILabel!
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!

    @IBOutlet weak var locationsCollectionView: UICollectionView!
    @IBOutlet weak var peopleCollectionView: UICollectionView!
    @IBOutlet weak var speciesCollectionView: UICollectionView!
    @IBOutlet weak var filmsCollectionView: UICollectionView!
    @IBOutlet weak var vehiclesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch currentValue {
        case "f":
            configureUI(with: film)
        case "l":
            configureUI(with: location)
        case "p":
            configureUI(with: people1)
        case "s":
            configureUI(with: species1)
        case "v":
            configureUI(with: vehicle)
        default:
            print("Error")
        }
    }
    
// MARK: Configuration functions
    func configureUI(with film: Film?) {
        if let film = film {
            fillUpSpeciesList(urls: film.species!)
            fillUpPeopleList(urls: film.people!)
            fillUpLocationList(urls: film.locations!)
            fillUpVehicleList(urls: film.vehicles!)
            configureImage(film.movie_banner)
            
            configureTitleLabels(first: "Director:", second: "Producer:", third: "Release date:", fourth: "Description:")
            configureLabels(first: film.director!, second: film.producer!, third: film.release_date!, fourth: film.description!)
            
            navigationItem.title = film.title
            blockIsHidden(people: false, films: true, locations: false, species: false, vehicles: false, lastLabel: false)
        }
        blockIsHidden(people: false, films: true, locations: false, species: false, vehicles: false, lastLabel: false)
    }
    
    func configureUI(with people: People?) {
        if let people = people {
            fillUpSpeciesList(url: people.species!)
            fillUpFilmList(urls: people.films!)
            
            configureTitleLabels(first: "Age:", second: "Eye color:", third: "Hair color:", fourth: "Gender:")
            configureLabels(first: people.age!, second: people.eye_color!, third: people.hair_color!, fourth: people.gender!)
            
            navigationItem.title = people.name
        }
        blockIsHidden(people: true, films: false, locations: true, species: false, vehicles: true, lastLabel: false)
        configureImage(nil)
    }
    
    func configureUI(with species: Species?) {
        if let species = species {
            fillUpFilmList(urls: species.films!)
            fillUpPeopleList(urls: species.people!)
            
            configureTitleLabels(first: "Classification:", second: "Eye color:", third: "Hair color:", fourth: nil)
            configureLabels(first: species.classification!, second: species.eye_colors!, third: species.hair_colors!, fourth: nil)
            
            navigationItem.title = species.name
        }
        blockIsHidden(people: false, films: false, locations: true, species: true, vehicles: true, lastLabel: true)
        configureImage(nil)
    }
    
    func configureUI(with location: Location?) {
        if let location = location {
            fillUpPeopleList(urls: location.residents!)
            fillUpFilmList(urls: location.films!)
            
            configureTitleLabels(first: "Climate:", second: "Terrain:", third: "Surface water:", fourth: nil)
            configureLabels(first: location.climate!, second: location.terrain!, third: location.surface_water!, fourth: nil)
            
            navigationItem.title = location.name
        }
        blockIsHidden(people: false, films: false, locations: true, species: true, vehicles: true, lastLabel: false)
        configureImage(nil)
    }
    
    func configureUI(with vehicle: Vehicle?) {
        if let vehicle = vehicle {
            fillUpPeopleList(url: vehicle.pilot!)
            fillUpFilmList(urls: vehicle.films!)
            
            configureTitleLabels(first: "Description:", second: "Vehicle class:", third: "Vehicle length:", fourth: nil)
            configureLabels(first: vehicle.description!, second: vehicle.vehicle_class!, third: vehicle.length!, fourth: nil)
            
            navigationItem.title = vehicle.name
        }
        blockIsHidden(people: false, films: false, locations: true, species: true, vehicles: true, lastLabel: true)
        configureImage(nil)
    }
    
    func configureImage(_ str: String?) {
        self.state = str
        indicator.startAnimating()
        let defaultImage = UIImage(named: "noImage")
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let imageStr = str,
               let url = URL(string: imageStr),
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data),
               str == self?.state {
                DispatchQueue.main.async {
                    self?.imageView.image = image
                    self?.indicator.stopAnimating()
                }
            } else {
                DispatchQueue.main.async {
                    self?.imageView.image = defaultImage
                    self?.indicator.stopAnimating()
                }
            }
        }
    }
    
    func blockIsHidden(people: Bool, films: Bool, locations: Bool, species: Bool, vehicles: Bool, lastLabel: Bool) {
       
        peopleBlock.isHidden = people
        filmBlock.isHidden = films
        locationsBlock.isHidden = locations
        speciesBlock.isHidden = species
        vehicleBlock.isHidden = vehicles
        lastLabelBlock.isHidden = lastLabel
    }
    
    func configureTitleLabels(first: String, second: String, third: String, fourth: String?) {
        
        titleLabelOne.text = first
        titleLabelTwo.text = second
        titleLabelThree.text = third
        
        if let fourth = fourth {
            titleLabelFour.text = fourth
        }
    }
    
    func configureLabels(first: String, second: String, third: String, fourth: String?) {
        
        labelOne.text = first
        labelTwo.text = second
        labelThree.text = third
        
        if let fourth = fourth {
            labelFour.text = fourth
        }
    }
}


// MARK: Fill up array functions
extension DetailViewController {
    
    // People
    func fillUpPeopleList(urls: [String]) {
        people = [People]()
        for i in urls {
            if i.hasSuffix("people/"){
                networkDataFetcher.fetchPeopleArray(urlString: i) { (people) in
                    guard let people = people else { return }
                    self.people = people
                    self.peopleCollectionView.reloadData()
                }
            } else {
                networkDataFetcher.fetchPeopleData(urlString: i) { (people) in
                    guard let people = people else { return }
                    self.people.append(people)
                    self.peopleCollectionView.reloadData()
                }
            }
        }
    }
    
    func fillUpPeopleList(url: String) {
        people = [People]()
        networkDataFetcher.fetchPeopleData(urlString: url) { (people) in
            guard let people = people else { return }
            self.people.append(people)
            self.peopleCollectionView.reloadData()
        }
    }
    
    // Films
    func fillUpFilmList(urls: [String]) {
        films = [Film]()
        for i in urls {
            networkDataFetcher.fetchFilmData(urlString: i) { (film) in
                guard let film = film else { return }
                self.films.append(film)
                self.filmsCollectionView.reloadData()
            }
        }
    }
    
    // Locations
    func fillUpLocationList(urls: [String]) {
        locations = [Location]()
        for i in urls {
            if i.hasSuffix("locations/") {
                networkDataFetcher.fetchLocationArray(urlString: i) { (locations) in
                    guard let locations = locations else { return }
                    self.locations = locations
                    self.locationsCollectionView.reloadData()
                }
            } else {
                networkDataFetcher.fetchLocationData(urlString: i) { (locations) in
                    guard let locations = locations else { return }
                    self.locations.append(locations)
                    self.locationsCollectionView.reloadData()
                }
            }
        }
    }
    
    // Species
    func fillUpSpeciesList(urls: [String]) {
        species = [Species]()
        for i in urls {
            networkDataFetcher.fetchSpeciesData(urlString: i) { (species) in
                guard let species = species else { return }
                self.species.append(species)
                self.speciesCollectionView.reloadData()
            }
        }
    }
    
    func fillUpSpeciesList(url: String) {
        species = [Species]()
        networkDataFetcher.fetchSpeciesData(urlString: url) { (species) in
            guard let species = species else { return }
            self.species.append(species)
            self.speciesCollectionView.reloadData()
        }
    }
    
    // Vehicles
    func fillUpVehicleList(urls: [String]) {
        vehicles = [Vehicle]()
        for i in urls {
            if i.hasSuffix("vehicles/") {
                networkDataFetcher.fetchVehicleArray(urlString: i) { (vehicles) in
                    guard let vehicles = vehicles else { return }
                    self.vehicles = vehicles
                    self.vehiclesCollectionView.reloadData()
                }
            } else {
                networkDataFetcher.fetchVehicleData(urlString: i) { (vehicles) in
                    guard let vehicles = vehicles else { return }
                    self.vehicles.append(vehicles)
                    self.vehiclesCollectionView.reloadData()
                }
            }
        }
    }
}
 

// MARK: Collection View Data Source
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
        case filmsCollectionView:
            return films.count
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
        case filmsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmCell", for: indexPath) as! FilmsCollectionViewCell
            cell.filmName.text = films[indexPath.row].title
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}


// MARK: Collection View Delegate
extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case peopleCollectionView:
            configureUI(with: people[indexPath.row])
        case speciesCollectionView:
            configureUI(with: species[indexPath.row])
        case locationsCollectionView:
            configureUI(with: locations[indexPath.row])
        case vehiclesCollectionView:
            configureUI(with: vehicles[indexPath.row])
        case filmsCollectionView:
            configureUI(with: films[indexPath.row])
        default:
            print("Collection View Error")
        }
        scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 414, height: 896), animated: true)
    }
}

