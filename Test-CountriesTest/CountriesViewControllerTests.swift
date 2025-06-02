//
//  CountriesViewControllerTests.swift
//  Test-CountriesTest
//
//  Created by Franzua Renzo Ramirez Gaston Zuloeta on 1/06/25.
//

import XCTest
@testable import Test_Countries

final class CountriesViewControllerTests: XCTestCase {
    
    var sut: CountriesViewController!
    var mockViewModel: ListCountriesViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        // Inicializar el ViewModel y el ViewController
              mockViewModel = ListCountriesViewModel()
              sut = CountriesViewController()
              sut.viewModel = mockViewModel
              
              // Cargar la vista del ViewController
              sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockViewModel = nil
        super.tearDown()
        
    }

    func testViewDidLoad_initialSetup() throws {
            // Verificar que las vistas estén configuradas correctamente
            XCTAssertNotNil(sut.searchCountriesField, "El campo de búsqueda debería estar inicializado")
            XCTAssertNotNil(sut.buttonSearch, "El botón de búsqueda debería estar inicializado")
            XCTAssertNotNil(sut.listCountriesTableView, "La tabla debería estar inicializada")
            XCTAssertNotNil(sut.loading, "El indicador de carga debería estar inicializado")
        }
        
        func testTableViewNumberOfRows() throws {
            // Configurar datos simulados en el ViewModel
            mockViewModel.countriesList = [
                CountriesModel(name: NamesCountry(common: "Peru", official: "Republic of Peru"), region: "Americas", coatOfArms: nil),
                CountriesModel(name: NamesCountry(common: "Chile", official: "Republic of Chile"), region: "Americas", coatOfArms: nil)
            ]
            
            // Verificar el número de filas en la tabla
            let rows = sut.tableView(sut.listCountriesTableView, numberOfRowsInSection: 0)
            XCTAssertEqual(rows, 2, "El número de filas debería coincidir con el número de países en la lista")
        }
        
        func testTableViewCellForRowAt() throws {
            // Configurar datos simulados en el ViewModel
            mockViewModel.countriesList = [
                CountriesModel(name: NamesCountry(common: "Peru", official: "Republic of Peru"), region: "Americas", coatOfArms: nil)
            ]
            
            // Obtener la celda para la primera fila
            let cell = sut.tableView(sut.listCountriesTableView, cellForRowAt: IndexPath(row: 0, section: 0))
            
            XCTAssertEqual(cell.textLabel?.text, "Peru", "El texto de la celda debería coincidir con el nombre del país")
        }
        
        func testSearchButtonTapped() throws {
            // Configurar datos simulados en el ViewModel
            mockViewModel.countriesList = [
                CountriesModel(name: NamesCountry(common: "Peru", official: "Republic of Peru"), region: "Americas", coatOfArms: nil),
                CountriesModel(name: NamesCountry(common: "Chile", official: "Republic of Chile"), region: "Americas", coatOfArms: nil)
            ]
            
            // Simular texto en el campo de búsqueda
            sut.searchCountriesField.text = "Peru"
            
            // Llamar al método de búsqueda
            sut.searchButtonTapped()
            
            // Verificar que la búsqueda se haya realizado correctamente
            XCTAssertEqual(mockViewModel.searchText, "Peru", "El texto de búsqueda debería coincidir con el texto ingresado")
        }

}
