//
//  MoviesTableViewController.swift
//  MoviesLib
//
//  Created by Marcelo Mussi on 02/09/22.
//

import UIKit
import CoreData

class MoviesTableViewController: UITableViewController {
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Movie> = {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    private let labelNoMovies: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 14)
        label.text = "Sem filmes cadastrados"
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? MovieViewController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        
         controller.movie = fetchedResultsController.object(at: indexPath)
    }
    
    private func loadMovies() -> Void {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Erro no fetch de movies \(error)")
        }
    }
    
    // Todas as vezes que o numberOfSections for 1, você pode remover esta sessão
//    override func numberOfSections(in tableView: UITableView) -> Int {
//         return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResultsController.fetchedObjects?.count ?? 0
        tableView.backgroundView = count == 0 ? labelNoMovies : nil
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = fetchedResultsController.object(at: indexPath)
        cell.configure(with: movie)
        
        return cell;
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie = fetchedResultsController.object(at: indexPath)
            context.delete(movie)
            try? context.save()
            //tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

}


extension MoviesTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
