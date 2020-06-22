//
//  CurrencyModel.swift
//  CurrencyConverter
//
//  Created by VJ's iMAC on 22/06/20.
//  Copyright © 2020 Deuglo. All rights reserved.
//

import Foundation


class ratesModel {
    var base: String?
    var date: String?
    var rates: NSDictionary?
    
    init(base: String?, date: String?, rates: NSDictionary?) {
        self.base = base
        self.date = date
        self.rates = rates
    }

}
