//
//  MovieFormViewController.swift
//  MoviesLib
//
//  Created by Marcelo Mussi on 08/09/22.
//

import UIKit

class MovieFormViewController: UIViewController {
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldRating: UITextField!
    @IBOutlet weak var textFieldDuration: UITextField!
    @IBOutlet weak var labelCategories: UILabel!
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var textViewSummary: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    
    
    var movie: Movie?
    var selectedCategories: Set<Category> = [] {
        didSet {
            if selectedCategories.isEmpty {
                labelCategories.text = "Adicionar categorias"
            } else {
                labelCategories.text = selectedCategories
                    .compactMap({ $0.name })
                    .sorted()
                    .joined(separator: ", ")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let categoriesViewController = segue.destination as? CategoriesTableViewController
        categoriesViewController?.selectedCategories = selectedCategories
        categoriesViewController?.delegate = self
    }
    
    private func setupUI() {
        if let movie = movie {
            title = "Atualização de Filme"
            textFieldTitle.text = movie.title
            textFieldRating.text = "\(movie.rating)"
            textFieldDuration.text = movie.duration
            textViewSummary.text = movie.summary
            if let image = movie.image {
                imageViewPoster.image = UIImage(data: image)
            }
            if let categories = movie.catergories as? Set<Category>, !categories.isEmpty {
                selectedCategories = categories
            }
            btnSave.setTitle("Atualizar", for: .normal)
        }
    }
    
    @IBAction func selectImage(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar pôster", message: "De onde você deseja escolher o pôster?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default) { _ in
                self.selectPictureFrom(.camera)
            }
            alert.addAction(cameraAction)
        }
        
        let galleryAction = UIAlertAction(title: "Galeria de fotos", style: .default) { _ in
            self.selectPictureFrom(.photoLibrary)
        }
        alert.addAction(galleryAction)
        
        let photosAction = UIAlertAction(title: "Álbum de fotos" , style: .default) { _ in
            self.selectPictureFrom(.savedPhotosAlbum)
        }
        alert.addAction(photosAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func selectPictureFrom(_ sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    @IBAction func save(_ sender: UIButton) {
        if movie == nil {
          movie = Movie(context: context)
        }
        
        movie?.title = textFieldTitle.text
        movie?.rating = Double(textFieldRating.text!) ?? 0
        movie?.duration = textFieldDuration.text
        movie?.summary = textViewSummary.text
        movie?.image = imageViewPoster.image?.jpegData(compressionQuality: 0.8)
        movie?.catergories = selectedCategories as NSSet
        
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
    }
    
}


extension MovieFormViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageViewPoster.image = image
        }
        dismiss(animated: true)
    }
}

extension MovieFormViewController: CategoriesDelegate {
    func setSelectedCategories(_ categories: Set<Category>) {
        selectedCategories = categories
    }
}
