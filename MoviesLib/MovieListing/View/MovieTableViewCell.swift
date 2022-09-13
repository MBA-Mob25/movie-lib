//
//  MovieTableViewCell.swift
//  MoviesLib
//
//  Created by Marcelo Mussi on 02/09/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var imaveViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSummary: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    
    func configure(with movie: Movie) {
        labelTitle.text = movie.title
        labelRating.text = movie.ratingFormatted
        labelSummary.text = movie.summary
        if let image = movie.image {
            imaveViewPoster.image = UIImage(data: image)
        }
        
        imaveViewPoster.layer.cornerRadius = 8
    }
    
}
