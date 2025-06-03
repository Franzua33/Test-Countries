//
//  NetworkManager.swift
//  Test-Countries
//
//  Created by Franzua Renzo Ramirez Gaston Zuloeta on 29/05/25.
//

import Foundation

class NetworkManager {

    // Crear el delegate personalizado
    private let customDelegate = CustomURLSessionDelegate()

    // Crear URLSession con el delegate personalizado
    private lazy var customURLSession: URLSession = {
        return URLSession(configuration: .default, delegate: customDelegate, delegateQueue: nil)
    }()
    // https://jsonplaceholder.typicode.com/posts
    // completion = a Dato a devolver
    func getAllCountries(completion: @escaping ([CountriesModel]) -> Void) {
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else {
            fatalError("La url no es correcta o no se ha podido acceder a ella")
        }

        customURLSession.dataTask(with: url) { datos, respuesta, error in
//            guard let self = self else { return }
            guard let data = datos, error == nil, let response = respuesta as? HTTPURLResponse else {
                return
            }

            let countriesData = try? JSONSerialization.jsonObject(with: data)
            //           Ver datos Serializados en Consola
            print("Datos Serializados : \(String(describing: countriesData))")
            if response.statusCode == 200 {

                do {
                    let countries = try JSONDecoder().decode([CountriesModel].self, from: data)

                    DispatchQueue.main.async {
                        completion(countries)
                    }
                } catch let error {
                    print("Ha ocurrrido un error: \(error.localizedDescription)")
                }
            }

        }.resume()
    }

    func getContries(name: String, completion: @escaping (([CountriesModel]) -> Void)) {
        guard let url = URL(string: "https://restcountries.com/v3.1/name/\(name)") else {
            fatalError("La url no es correcta o no se ha podido acceder a ella")
        }

        customURLSession.dataTask(with: url) { datos, respuesta, error in
            guard let data = datos, error == nil, let response = respuesta as? HTTPURLResponse else {
                return
            }
            let countriesData = try? JSONSerialization.jsonObject(with: data)
            //           Ver datos Serializados en Consola
            print("Datos Serializados : \(String(describing: countriesData))")
            if response.statusCode == 200 {
                do {
                    let countries = try JSONDecoder().decode([CountriesModel].self, from: data)

                    DispatchQueue.main.async {
                        completion(countries)
                    }
                } catch let error {
                    print("Ha ocurrrido un error: \(error.localizedDescription)")
                }
            }

        }.resume()
    }

}
class CustomURLSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        // Lista de dominios permitidos
        let allowedDomains = ["restcountries.com", "mainfacts.com"]
        
        // Validar si el host está en la lista de dominios permitidos
        if allowedDomains.contains(challenge.protectionSpace.host) {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                completionHandler(.useCredential, URLCredential(trust: serverTrust))
            } else {
                completionHandler(.performDefaultHandling, nil)
            }
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
