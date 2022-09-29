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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var directorLable: UILabel!
    @IBOutlet weak var producerLable: UILabel!
    @IBOutlet weak var releaseDate: UILabel!

    @IBOutlet weak var peopleCollectionView: UICollectionView!
    @IBOutlet weak var speciesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI(film)
    }
    
    // Configuration functions
    func configureUI(_ film: Film?) {
        if let film = film {
            print("-------------------------------People url: \(film.species)")
            fillUpSpeciesList(urls: film.species!)
            fillUpPeopleList(urls: film.people!)
            configureImage(film.movie_banner)
            descriptionLable.text = film.description
            directorLable.text = film.director
            producerLable.text = film.producer
            releaseDate.text = film.release_date

            navigationItem.title = film.title
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
            }
            networkDataFetcher.fetchPeopleData(urlString: i) { (people) in
                guard let people = people as? People else { return }
                self.people.append(people)
                self.peopleCollectionView.reloadData()
                
            }
        }
        
    }
    
    func fillUpSpeciesList(urls: [String]) {
        print("-------------------------------Species url: \(urls)")
        for i in urls {
            networkDataFetcher.fetchSpeciesData(urlString: i) { (species) in
                guard let species = species as? Species else { return }
                self.species.append(species)
                self.speciesCollectionView.reloadData()
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
        default:
            return UICollectionViewCell()
        }
        
        
    }
    
    
}

extension DetailViewController: UICollectionViewDelegate {
    
}
