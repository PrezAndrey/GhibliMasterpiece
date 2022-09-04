//
//  ViewController.swift
//  Ghibli Masterpiece
//
//  Created by Андрей През on 02.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let networkDataFetcher = NetworkDataFetcher()
    let urlString = "https://ghibliapi.herokuapp.com/films"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func parseJSON(_ sender: Any) {
        networkDataFetcher.fetchData(urlString: urlString) { (result) in
            guard let result = result else { return }
            print(result)
        }
    }
    


}

