//
//  MainViewModel.swift
//  GimmeFoodNow
//
//  Created by Eric Seo on 7/5/18.
//  Copyright © 2018 Eric Seo. All rights reserved.
//

class FirstViewModel {
    let buttonTitle = "Find me food"
    
    func findMeFoodAction() {
        YelpSearchRequestSamples().searchWithLatLong(lat: 37.291459, long: -121.973994)
    }
}
