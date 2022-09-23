//
//  DetailViewController.swift
//  Ghibli Masterpiece
//
//  Created by Андрей През on 05.09.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var film: Film?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var directorLable: UILabel!
    @IBOutlet weak var producerLable: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var runningTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI(film)
    }
    
    func configureUI(_ film: Film?) {
        if let film = film {
            configureImage(film.movie_banner)
            descriptionLable.text = film.description
            directorLable.text = film.director
            producerLable.text = film.producer
            releaseDate.text = film.release_date
            runningTime.text = film.runnung_time
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
    
    
        
        
    
}
