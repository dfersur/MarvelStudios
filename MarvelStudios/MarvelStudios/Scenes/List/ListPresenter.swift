//
//  ListPresenter.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 11/6/22.
//  Copyright (c) 2022 MyNSoftware. All rights reserved.
//

protocol ListDisplayLogic: BaseDisplayLogic {
    func setupView()
    func updateUI(list: [List.CharacterViewModel])
}

protocol ListDataStore { }

class ListPresenter: ListPresenterLogic, ListDataStore {
    
    weak var view: (ListDisplayLogic & ListRouterLogic)?
    var repository: CharacterRepository = CharacterAPIRepository()
    
    var list: [List.CharacterViewModel] = []
    var filteredList: [List.CharacterViewModel] = []

    func setupView() {
        view?.setupView()
        fetchCharacters()
    }
    
    private func fetchCharacters() {
        Task { [weak self] in
            do {
                self?.view?.showLoading()
                self?.list = try await repository.getCharacters().map({ item in
                    return List.CharacterViewModel(id: item.id, name: item.name)
                })
                self?.filterList(text: nil)
                self?.view?.hideLoading()
            }
            catch CustomRequestBuilderError.noData {
                self?.view?.showAlert(title: "Alerta", message: "No hay datos")
                self?.view?.hideLoading()
            }
            catch {
                self?.view?.showAlert(title: "Alerta", message: "Ha habido un error en la aplicación, inténtelo de nuevo más tarde.")
                self?.view?.hideLoading()
            }
        }
    }
    
    func filterList(text: String?) {
        filteredList = text?.isEmpty ?? true
                        ? list
                        : list.filter({$0.name?.contains(text ?? "") ?? false})
        
        view?.updateUI(list: filteredList)
    }
    
    func didSelectRowAt(index: Int) {
        let itemSelected = filteredList[index]
        guard let id = itemSelected.id else { return }
        view?.navigateToDetail(id: id)
    }
    
}
