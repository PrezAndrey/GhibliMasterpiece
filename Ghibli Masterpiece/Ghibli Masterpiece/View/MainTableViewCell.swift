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
    
    var path: String?
    
    override func prepareForReuse() {
        filmImage.image = nil
    }
    
    func configureImage(imageStr: String?) {
        self.path = imageStr
        indicator.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let string = imageStr,
               let url = URL(string: string),
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data),
               self?.path == imageStr {
                DispatchQueue.main.async {
                    self?.filmImage.image = image
                    self?.indicator.stopAnimating()
                }
            } else {
                DispatchQueue.main.async {
                    self?.filmImage.image = UIImage(named: "noImage")
                    self?.indicator.stopAnimating()
                }
            }
        }
        
    }
}
