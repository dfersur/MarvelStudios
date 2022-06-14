//
//  DetailPresenter.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 11/6/22.
//  Copyright (c) 2022 MynSoftware. All rights reserved.
//

protocol DetailDisplayLogic: BaseDisplayLogic {
    func setupView()
    func updateUI(character: Detail.CharacterViewModel)
}

protocol DetailDataStore {
    var id: Int { get set }
}

class DetailPresenter: DetailPresenterLogic, DetailDataStore {
    var id: Int = -1
    
    weak var view: (DetailDisplayLogic & DetailRouterLogic)?
    var repository: CharacterRepository = CharacterAPIRepository()
    
    func setupView() {
        view?.setupView()
        fetchCharacter()
    }
    
    private func fetchCharacter() {
        Task { [weak self] in
            do {
                self?.view?.showLoading()
                if let data = try await repository.getCharacter(by: id) {
                    let detail = Detail.CharacterViewModel(name: data.name, description: data.description, thumbnail: data.thumbnail)
                    self?.view?.updateUI(character: detail)
                }
                self?.view?.hideLoading()
            }
            catch CustomRequestBuilderError.noData {
                self?.view?.showAlert(title: "Alerta", message: "No hay datos")
            }
            catch {
                self?.view?.showAlert(title: "Alerta", message: "Ha habido un error en la aplicación, inténtelo de nuevo más tarde.")
            }
        }
    }
}
