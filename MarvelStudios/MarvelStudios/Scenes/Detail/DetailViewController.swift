//
//  DetailViewController.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 11/6/22.
//  Copyright (c) 2022 MynSoftware. All rights reserved.
//

import UIKit

protocol DetailPresenterLogic {
    func setupView()
}

class DetailViewController: BaseViewController {
    var presenter: DetailPresenterLogic?
    var dataStore: DetailDataStore?
    
    var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fill
        view.axis = .vertical
        view.spacing = 20
        return view
    }()
    
    // MARK: Setup
  
    override func setupScene() {
        let viewController = self
        let presenter = DetailPresenter()
        
        presenter.view = viewController
        viewController.dataStore = presenter
        self.presenter = presenter
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setupView()
    }
    
    private func setupContainer() {
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupDefaultView() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupImage(path: String?, ext: String?) {
        guard let path = path, let ext = ext else {
            return
        }
        let image: UIImageView = UIImageView()
        image.load(url: "\(path).\(ext)")
        stackView.addArrangedSubview(image)
    }
    
    private func setupDescriptionLabel(text: String?) {
        let description: UILabel = UILabel()
        description.text = text
        description.numberOfLines = 5
        stackView.addArrangedSubview(description)
    }
}

// MARK: - Display Logic

extension DetailViewController: DetailDisplayLogic {
    
    func setupView() {
        setupDefaultView()
        setupContainer()
    }
    
    func updateUI(character: Detail.CharacterViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.title = character.name
            self?.setupImage(path: character.thumbnail?.path, ext: character.thumbnail?.ext)
            self?.setupDescriptionLabel(text: character.description)
        }
    }
    
}

// MARK: - Router Logic

protocol DetailRouterLogic: AnyObject { }

protocol DetailDataPass {
    var dataStore: DetailDataStore? { get }
}

extension DetailViewController: DetailRouterLogic, DetailDataPass { }
