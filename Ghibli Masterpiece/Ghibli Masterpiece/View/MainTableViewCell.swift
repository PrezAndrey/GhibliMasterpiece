//
//  FilmTableViewCell.swift
//  Ghibli Masterpiece
//
//  Created by Андрей През on 04.09.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var originalName: UILabel!
    @IBOutlet weak var filmName: UILabel!
    @IBOutlet weak var directorLable: UILabel!
    @IBOutlet weak var filmImage: UIImageView!
    
    override func prepareForReuse() {
        filmImage.image = nil
    }
    
    func configureImage(imageStr: String?) {
        indicator.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let string = imageStr,
               let url = URL(string: string),
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.filmImage.image = image
                    self?.indicator.stopAnimating()
                }
            }
        }
        
    }
    
    

}
