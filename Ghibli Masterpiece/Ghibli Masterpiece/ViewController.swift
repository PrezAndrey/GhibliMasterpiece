//
//  ViewController.swift
//  Ghibli Masterpiece
//
//  Created by Андрей През on 02.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var films: [Film]? = nil
    let networkDataFetcher = NetworkDataFetcher()
    let urlString = "https://ghibliapi.herokuapp.com/films"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkDataFetcher.fetchFilmData(urlString: urlString) { (result) in
            guard let result = result as? [Film] else { return }
            self.films = result
            print(self.films)
            self.tableView.reloadData()
        }
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
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "details", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}

extension ViewController: UITableViewDataSource {
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

