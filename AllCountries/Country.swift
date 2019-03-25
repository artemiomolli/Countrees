//
//  Country.swift
//  AllCountries
//
//  Created by Артём Гуральник on 3/25/19.
//  Copyright © 2019 Guralnyk Artem. All rights reserved.
//

import Foundation

struct Country {
    
    var countryName: String!
    var countryBorders: String!
    
    init(name: String, borders: String) {
        
        countryName = name
        countryBorders = borders
    }
    
}
