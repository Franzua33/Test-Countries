# Test-Countries
Test-Countries es una aplicación iOS desarrollada en Swift que permite a los usuarios buscar y explorar información sobre países utilizando la API de REST Countries. La aplicación está diseñada con la arquitectura MVVM (Model-View-ViewModel) y utiliza Combine para la gestión reactiva de datos.

# Características
### Lista de países: Muestra una lista de países obtenida desde la API.
### Búsqueda de países: Permite buscar países por nombre con un retraso de medio segundo para optimizar la experiencia del usuario.
### Detalle de país: Al seleccionar un país, se muestra información detallada como el nombre, región, población y el escudo de armas.
### Carga asíncrona de datos: Los datos se obtienen de forma asíncrona utilizando URLSession con un delegado personalizado.
### Indicador de carga: Muestra un indicador de actividad mientras se cargan los datos.
### Arquitectura MVVM: Separa la lógica de negocio (ViewModel) de la interfaz de usuario (View) para facilitar el mantenimiento y escalabilidad.
### Combine: Utilizado para la gestión de eventos y la actualización reactiva de la interfaz de usuario.

# Estructura del Proyecto
El proyecto está organizado de la siguiente manera:

Test-Countries/
├── AppDelegate.swift
├── SceneDelegate.swift
├── Assets.xcassets/
├── Base.lproj/
│   ├── Main.storyboard
│   ├── LaunchScreen.storyboard
├── Info.plist
├── MVVM/
│   ├── Model/
│   │   ├── CountriesModel.swift
│   ├── View/
│   │   ├── CountriesViewController.swift
│   │   ├── CountryDetailViewController.swift
│   ├── ViewModel/
│       ├── ListCountriesViewModel.swift
│       ├── NetworkManager.swift
├── Test-Countries.xcodeproj/
├── Test-CountriesTest/
│   ├── CountriesViewControllerTests.swift

# Principales Componentes
### Model
CountriesModel: Define las estructuras de datos para representar la información de los países, como el nombre, región, población y escudo de armas.
### View
CountriesViewController: Controlador principal que muestra la lista de países y permite realizar búsquedas.
CountryDetailViewController: Controlador que muestra los detalles de un país seleccionado.
### ViewModel
ListCountriesViewModel: Gestiona la lógica de negocio, incluyendo la obtención de datos desde la API y la actualización de la interfaz de usuario.
NetworkManager: Responsable de realizar las solicitudes HTTP y manejar la comunicación con la API.

# Tecnologías Utilizadas
### Swift: Lenguaje de programación principal.
### Combine: Framework para la programación reactiva.
### URLSession: Para realizar solicitudes HTTP.
#### Storyboard: Para el diseño de la interfaz de usuario.
SwiftLint: Para mantener la calidad del código.
# Instalación
Clona este repositorio:
git clone https://github.com/tu-usuario/Test-Countries.git
Abre el proyecto en Xcode:
open Test-Countries.xcodeproj

# Pruebas Unitarias
El proyecto incluye pruebas unitarias para garantizar la calidad del código. Las pruebas están ubicadas en el directorio Test-CountriesTest. Ejemplo de pruebas:

# Verificación de la funcionalidad de búsqueda en CountriesViewControllerTests.
Para ejecutar las pruebas:

Selecciona el esquema Test-CountriesTest en Xcode.
Presiona Cmd + U para ejecutar las pruebas.
# Contribuciones
Si deseas contribuir al proyecto, por favor sigue estos pasos:

Haz un fork del repositorio.
Crea una rama para tu funcionalidad:
git checkout -b feature/nueva-funcionalidad
Realiza tus cambios y haz un commit:
git commit -m "Agrega nueva funcionalidad"
Envía un pull request.

