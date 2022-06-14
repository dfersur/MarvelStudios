//
//  BaseViewController.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 11/6/22.
//

import UIKit

protocol BaseDisplayLogic: AnyObject {
    func showAlert(title: String, message: String)
    func showLoading()
    func hideLoading()
}

class BaseViewController: UIViewController {
    
    var coordinator: AppCoordinator?
    
    var loading: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupScene()
    }
    
    override func viewDidLoad() {
        applyDefaultStyle()
        DispatchQueue.main.async { [weak self] in
            self?.setupLoading()
        }
    }
    
    // MARK: Setup
    func setupScene() { }
    
    func applyDefaultStyle() {
        view.backgroundColor = .white
    }
    
    private func setupLoading() {
        view.addSubview(loading)
        loading.isHidden = true
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loading.isHidden = false
            self?.loading.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {[weak self] in
            self?.loading.isHidden = true
            self?.loading.stopAnimating()
        }
    }

}
