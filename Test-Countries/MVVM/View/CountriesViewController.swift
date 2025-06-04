//
//  CountriesViewController.swift
//  Test-Countries
//
//  Created by Franzua Renzo Ramirez Gaston Zuloeta on 28/05/25.
//
import UIKit
import Combine

class CountriesViewController: UIViewController {
    
    // PROPERTIES:
    var viewModel: ListCountriesViewModel = ListCountriesViewModel()
    var anyCancellable: [AnyCancellable] = []

    // Views
    var searchCountriesField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .lightGray
        textField.placeholder = "Buscar país..."
        return textField
    }()
    
    var buttonSearch: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textColor = .black
        return button
    }()
    
    lazy var listCountriesTableView:  UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .large)
        loading.color = .red
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        subscriptions()
        configureConstraintsViews()
        viewModel.getAllCountries()
        
        searchCountriesField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        buttonSearch.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        }
    

    @objc func searchButtonTapped() {
        guard let searchText = searchCountriesField.text, !searchText.isEmpty else {
            print("El campo de búsqueda está vacío")
            return
        }
        
        viewModel.searchText = searchText // Actualizar el texto de búsqueda den el ViewModel
        viewModel.startSearch()
    }
        @objc func textFieldDidChange(){
            
            guard let textField = searchCountriesField.text else { return }
             
            viewModel.searchText = textField
            if textField.isEmpty {
                viewModel.getAllCountries()
            } else {
                viewModel.startSearch()
            }
        }
    
    func subscriptions() {
        viewModel.reloadData.sink { _ in
        } receiveValue: { [weak self] _ in
            self?.listCountriesTableView.reloadData()
        }.store(in: &anyCancellable)

        viewModel.$isLoading.sink { [weak self] state in
            guard let state = state else { return }
            self?.configLoading(state: state)
        }.store(in: &anyCancellable)
    }

    private func configureConstraintsViews() {
        view.addSubview(searchCountriesField)
        view.addSubview(buttonSearch)
        view.addSubview(listCountriesTableView)
        view.addSubview(loading)

        NSLayoutConstraint.activate([
            // searchCountriesField Constraints
            searchCountriesField.heightAnchor.constraint(equalToConstant: 40),
            searchCountriesField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchCountriesField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            searchCountriesField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            // ButtonSearch Constraints
            buttonSearch.heightAnchor.constraint(equalToConstant: 40),
            buttonSearch.topAnchor.constraint(equalTo: searchCountriesField.topAnchor),
            buttonSearch.leadingAnchor.constraint(equalTo: searchCountriesField.trailingAnchor, constant: 5),
            buttonSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),

            // ListCountriesTableView Constraints
            listCountriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listCountriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listCountriesTableView.topAnchor.constraint(equalTo: searchCountriesField.bottomAnchor, constant: 15),
            listCountriesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func configLoading(state: Bool) {
        if state {
            loading.startAnimating()
            listCountriesTableView.addSubview(loading)
            NSLayoutConstraint.activate([
                loading.centerYAnchor.constraint(equalTo: listCountriesTableView.centerYAnchor),
                loading.centerXAnchor.constraint(equalTo: listCountriesTableView.centerXAnchor)
            ])
            return
        } else {
            loading.removeFromSuperview()
        }

    }

}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countriesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = viewModel.countriesList[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if cell.detailTextLabel == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell.textLabel?.text = user.name?.common
        cell.detailTextLabel?.text = user.region
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CountryDetailViewController") as! CountryDetailViewController
        vc.selectedCountry = viewModel.countriesList[indexPath.row]
        self.present(vc, animated: true)
    }

}
