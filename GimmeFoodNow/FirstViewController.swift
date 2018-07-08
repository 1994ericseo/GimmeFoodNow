//
//  ViewController.swift
//  GimmeFoodNow
//
//  Created by Eric Seo on 7/5/18.
//  Copyright © 2018 Eric Seo. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var viewModel: FirstViewModel? {
        didSet {
            setupView()
        }
    }
    
    lazy var findMeFoodButton: UIButton = { [unowned self] in
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
            return button
        }
        return UIButton()
    }()
    
    init(viewModel: FirstViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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


}

