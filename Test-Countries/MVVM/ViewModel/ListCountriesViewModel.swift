//
//  ListCountriesViewModel.swift
//  Test-Countries
//
//  Created by Franzua Renzo Ramirez Gaston Zuloeta on 29/05/25.
//

import Foundation
import Combine

class ListCountriesViewModel {

    var countriesList : [CountriesModel] = []

    var reloadData = PassthroughSubject<Void,Never>()
    @Published var isLoading : Bool?
    @Published var searchText: String = ""

    func getAllCountries(){
        isLoading = true
            NetworkManager().getAllCountries { (allCountries) in
                self.countriesList = allCountries
                self.reloadData.send()
                self.isLoading = false
            }
        }
    
    func startSearch(){
        isLoading = true
        NetworkManager().getContries(name: searchText){ [weak self] countries in
            self?.isLoading = false
            self?.countriesList = countries
            self?.reloadData.send()
        }
    }

}




