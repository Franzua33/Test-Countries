//
//  CountryDetailViewController.swift
//  Test-Countries
//
//  Created by Franzua Renzo Ramirez Gaston Zuloeta on 30/05/25.
//

import UIKit
import Foundation

class CountryDetailViewController: UIViewController {

    // PROPERTIES
    var selectedCountry: CountriesModel?
    @IBOutlet weak var imageCountry: UIImageView!
    @IBOutlet weak var nameCountryLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    // METHOD
    func setupUI() {
        guard let country = selectedCountry else { return }
        nameCountryLabel.text = country.name?.common ?? "Nombre no disponible"
        capitalLabel.text = country.region ?? "Region no disponible"
        
        if let populationString = country.population {
            populationLabel.text = "Habitantes: " + String(describing: populationString) + " " + "personas"
        }
    }
}
