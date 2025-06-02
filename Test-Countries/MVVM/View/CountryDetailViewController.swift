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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    // METHOD
    func setupUI(){
        guard let country = selectedCountry else { return }
        nameCountryLabel.text = country.name?.common ?? "Nombre no disponible"
        capitalLabel.text = country.region ?? "Region no disponible"
        
        if let imgURLFlag = country.coatOfArms?.png, let url = URL(string: imgURLFlag){
            DispatchQueue.global().async{
                
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.imageCountry.image = image
                    }
                }
            }
        }
        
    }
}
