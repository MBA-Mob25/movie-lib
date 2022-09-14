//
//  ConfigurationsViewController.swift
//  MoviesLib
//
//  Created by Marcelo Mussi on 13/09/22.
//

import UIKit

class ConfigurationsViewController: UIViewController {
    
    
    let userDefault = UserDefaults.standard

    // MARK: - Outlets
    @IBOutlet weak var textFieldCategory: UITextField!
    @IBOutlet weak var switchAutoPlay: UISwitch!
    @IBOutlet weak var segmentedControlColor: UISegmentedControl!
    
    // MARK: - Defaults
    override func viewDidLoad() {
        super.viewDidLoad()
     }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userDefault.set(textFieldCategory.text, forKey: "category")
        textFieldCategory.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let category = userDefault.string(forKey: "category")
        textFieldCategory.text = category
        
        let autoplay = userDefault.bool(forKey: "autoplay")
        switchAutoPlay.setOn(autoplay, animated: autoplay)
        
        let colorInt = userDefault.integer(forKey: "color")
        segmentedControlColor.selectedSegmentIndex = colorInt
    }
    
    // MARK: - Actions
    @IBAction func changeCategory(_ sender: UITextField) {
        userDefault.set(sender.text, forKey: "category")
    }
    
    @IBAction func changeAutoPlay(_ sender: UISwitch) {
        userDefault.set(sender.isOn, forKey: "autoplay")
    }
    
    @IBAction func changeColor(_ sender: UISegmentedControl) {
        userDefault.set(sender.selectedSegmentIndex, forKey: "color")
    }
}
