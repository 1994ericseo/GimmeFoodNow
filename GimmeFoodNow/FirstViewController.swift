//
//  ViewController.swift
//  GimmeFoodNow
//
//  Created by Eric Seo on 7/5/18.
//  Copyright © 2018 Eric Seo. All rights reserved.
//

import UIKit

protocol FirstViewControllerDelegate: class {
    func updateLoadingState(isLoading: Bool)
}

class FirstViewController: UIViewController {
    
    private var viewModel: FirstViewModel? {
        didSet {
            setupView()
        }
    }
    
    private lazy var findMeFoodButton: UIButton = {
        if let viewModel = self.viewModel {
            let button = UIButton(type: .roundedRect)
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 16)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(viewModel.buttonTitle, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.blue.cgColor
            button.sizeToFit()
            button.addTarget(self, action: #selector(findMeFoodButtonAction), for: .touchUpInside)
            return button
        }
        return UIButton()
    }()
    
    private lazy var spinnerView: UIView = {
        let spinnerView = UIView(frame: self.view.bounds)
        spinnerView.backgroundColor = UIColor(displayP3Red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        loadingIndicator.center = self.view.center
        loadingIndicator.startAnimating()
        loadingIndicator.center = spinnerView.center
        spinnerView.addSubview(loadingIndicator)
        return spinnerView
    }()
    
    init(viewModel: FirstViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel?.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        setupView()
        setupConstraints()
        super.viewDidLoad()
    }
    
    func setupView() {
        title = "FOOOOOOD"
        view.addSubview(findMeFoodButton)
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            findMeFoodButton.heightAnchor.constraint(equalToConstant: 48),
            findMeFoodButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            findMeFoodButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func findMeFoodButtonAction() {
        if let viewModel = self.viewModel {
            viewModel.findMeFoodAction()
        }
    }
    
    func displaySpinner() {
        DispatchQueue.main.async { [weak self] in
            if let viewController = self {
                viewController.view.addSubview(viewController.spinnerView)
            }
        }
    }
    
    func removeSpinner() {
        DispatchQueue.main.async { [weak self] in
            self?.spinnerView.removeFromSuperview()
        }
    }
}

extension FirstViewController: FirstViewControllerDelegate {
    func updateLoadingState(isLoading: Bool) {
        if isLoading {
            displaySpinner()
        } else {
            removeSpinner()
        }
    }
}

