//
//  ViewController+Context.swift
//  MoviesLib
//
//  Created by Marcelo Mussi on 08/09/22.
//

import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
