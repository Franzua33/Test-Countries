//
//  CountriesModel.swift
//  Test-Countries
//
//  Created by Franzua Renzo Ramirez Gaston Zuloeta on 29/05/25.
//

import Foundation

//https://restcountries.com/v3.1/all
//https://restcountries.com/v3.1/name/{name}

struct CountriesModel: Codable {
    let name: NamesCountry?
    let region: String?
    let coatOfArms:Flag?
}
struct NamesCountry: Codable {
    let common: String?
    let official: String?
}
struct Flag: Codable {
    let png: String?
}



