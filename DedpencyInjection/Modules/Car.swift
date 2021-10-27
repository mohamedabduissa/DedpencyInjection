//
//  Car.swift
//  DedpencyInjection
//
//  Created by Mabdu on 13/07/2021.
//

import Foundation


// MARK: - ...  Depndency injection make flexbility use diffrent object that confirm the contract
protocol Car {
    var brand: String { get }
}
class UserCar {
    let car: Car
    
    init(car: Car) {
        self.car = car
    }
}
