//
//  ViewController.swift
//  MoviesLib
//
//  Created by Marcelo Mussi on 30/08/22.
//

import UIKit

class MovieViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelCategories: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var textViewSummary: UITextView!
    
    // MARK: - Proprieties
    var movie: Movie?
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieFormViewCOntroller  = segue.destination as? MovieFormViewController {
            movieFormViewCOntroller.movie = movie
        }
    }
    
    // MARK: - IBAction
    @IBAction func play(_ sender: UIButton) {
        print("Oieee")
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        if let movie = movie {
            labelTitle.text = movie.title
            labelRating.text = movie.ratingFormatted
            labelDuration.text = movie.duration
            //labelCategories.text = movie.categories
            textViewSummary.text = movie.summary
            if let image = movie.image {
                imageViewPoster.image = UIImage(data: image)
            }
            if let categories = movie.catergories as? Set<Category> {
                labelCategories.text = categories
                    .compactMap({ $0.name })
                    .sorted()
                    .joined(separator: ", ")
            }
        }
    }
}

