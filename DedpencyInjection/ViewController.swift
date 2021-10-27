//
//  ViewController.swift
//  DedpencyInjection
//
//  Created by Mabdu on 13/07/2021.
//

import UIKit
import HashableEqutable
import AnonymousClosure
import CaseIterableModule
import GCD
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user1 = UserCar(car: Honda())
        let user2 = UserCar(car: BMW())
        let user3 = UserCar(car: Mazda())
        print(user1.car, user2.car, user3.car)
        // Do any additional setup after loading the view.
        
        setupEqutable()
        setupHashable()
        getAnonymous()
        
        print(APPLE.AllCases().count)
        
        runGCD()
    }
}



// MARK: - ...  Equtable
extension ViewController {
    func setupEqutable() {
        let product1 = Product(option: Option(name: "name", value: "mac"))
        let product2 = Product(option: Option(name: "name", value: "mac"))
        
        print(product1 == product2)
    }
}


// MARK: - ...  Hashable
extension ViewController {
    func setupHashable() {
        var dic = [Product: [Option]]()
        
        let product1 = Product(option: Option(name: "name", value: "mac"))
        dic[product1] = [Option(name: "name", value: "mac"), Option(name: "price", value: "1000")]
        
        print(dic[product1]?.first?.name, dic[product1]?.first?.value)
    }
}



// MARK: - ...  Anonymous closure
extension ViewController {
    func getAnonymous() {
        let table = View().table
        //print(table)
    }
}


// MARK: - ...  GCD
extension ViewController {
    func runGCD() {
        //GCDQ.Queues().mainQueue()
        //GCDQ.Queues().background()
        //GCDQ.Queues().customQueue(type: .serial)
        //GCDQ.Queues().dispatchGroup()
        //GCDQ.Queues().dispatchSemaphores()
        //GCDQ.Queues().raceConditions()
        GCDQ.Queues().QueueQOS()
    }
}
