//
//  MainViewModel.swift
//  GimmeFoodNow
//
//  Created by Eric Seo on 7/5/18.
//  Copyright © 2018 Eric Seo. All rights reserved.
//

class FirstViewModel {
    let buttonTitle = "Find me food"
    
    weak var delegate: FirstViewControllerDelegate?
    
    func findMeFoodAction() {
        delegate?.updateLoadingState(isLoading: true)
        YelpSearchRequests().searchWithLatLong(lat: 37.291459, long: -121.973994) { [weak self] (data, error) in
            self?.delegate?.updateLoadingState(isLoading: false)
        }
    }
}
