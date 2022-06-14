//
//  AppCoordinator.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 10/6/22.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

/// Coordinador de la aplicación
class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(false, animated: false)
    }
    
    /// Navegación a la pantalla de inicio
    func start() {
        let initiaScene: ListViewController = ListViewController()
        initiaScene.coordinator = self
        navigationController.setViewControllers([initiaScene], animated: false)
    }
    
    /// Navegación a la pantalla detalle
    /// - Parameter id: Id del Character
    func navigateToDetail(by id: Int) {
        let detailView: DetailViewController = DetailViewController()
        detailView.coordinator = self
        detailView.dataStore?.id = id
        navigationController.show(detailView, sender: nil)
    }
    
}
