//
//  RestaurantViewController.swift
//  GimmeFoodNow
//
//  Created by Eric Seo on 7/28/18.
//  Copyright © 2018 Eric Seo. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {
    
    let viewModel: RestaurantViewModel

    init(viewModel: RestaurantViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = viewModel.name
    }

}
