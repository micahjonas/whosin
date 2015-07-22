//
//  Location.swift
//  whosin
//
//  Created by Micha Schwendener on 22/07/15.
//  Copyright (c) 2015 Micha Schwendener. All rights reserved.
//

import Foundation



class Location {
    var address : String
    var lat : Double
    var lng : Double
    
    init(address : String, lat: Double, lng :Double){
        self.lat = lat
        self.address = address
        self.lng = lng
    
    }
    
    convenience init(){
        self.init(address: "", lat: Double(0), lng: Double(0))
    }
}