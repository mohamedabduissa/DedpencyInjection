//
//  DispatchQuoue.swift
//  GCD
//
//  Created by Mabdu on 15/07/2021.
//

import Foundation

public class GCDQ {
    
    public init() {
        
    }

}


extension GCDQ {
    
    public class Queues {
        public init() {
            
        }
    }
}

extension GCDQ.Queues {
    public func mainQueue() {
        DispatchQueue.main.async {
            print("Main async 1")
        }
        // MARK: - ...  Make deadlock !!!!! error
        //            DispatchQueue.main.sync {
        //                print("Main async 2")
        //            }
        DispatchQueue.main.async {
            print("Main async 4")
        }
        DispatchQueue.main.async {
            print("Main async 5")
        }
    }
}

extension GCDQ.Queues {
    public enum CUSTOM {
        
        // MARK: - ...  serial queue is running in one thread only doesn't care the async or sync
        case serial
        // MARK: - ...  concurrent queue is running in multi thread its care about the async or sync
        case concurrent
    }
    public func background() {
        DispatchQueue.global(qos: .background).async {
            print("background task async 1")
        }
       
        DispatchQueue.global(qos: .background).async {
            print("background task async 2")
        }
        DispatchQueue.global(qos: .background).async {
            print("background task async 3")
        }
        DispatchQueue.global(qos: .background).async {
            print("background task async 4")
        }
        
        // MARK: - ...  the queue that run sync as first of async
        DispatchQueue.global(qos: .background).sync {
            print("background task sync 1")
        }
    }

    
    public func customQueue(_ label: String = "CUSTOM", type: CUSTOM) {
        var queue: DispatchQueue
        if type == .serial {
            queue = .init(label: label)
        } else {
            queue = .init(label: label, attributes: .concurrent)
        }
        

        
        queue.async {
            print("background task async 1")
        }
        queue.async {
            print("background task async 2")
        }
        queue.async {
            print("background task async 3")
        }
        queue.sync {
            sleep(1)
            print("background task sync 1")
        }
        queue.async {
            print("background task async 4")
        }
        queue.async {
            print("background task async 5")
        }
       
        queue.async {
            print("background task async 6")
        }
       
        
    }
    
    public func dispatchGroup() {
        let group = DispatchGroup()
        group.enter()
        print("work item 1")
        sleep(1)
        print("work item 2")
        sleep(1)
        group.leave()
        group.notify(queue: .global()) {
            print("group finished")
        }
    }
    
    public func dispatchSemaphores() {
        let semaphores = DispatchSemaphore(value: 1)
        
        var queue: DispatchQueue
        queue = .init(label: "CUSTOM", attributes: .concurrent)
        semaphores.wait()
        queue.async {
            defer { semaphores.signal() }
            print("Async 1")
            sleep(1)
        }
        queue.async {
            defer { semaphores.signal() }
            print("Async 2")
        }
        queue.async {
            defer { semaphores.signal() }
            print("Async 3")
        }
        queue.async {
            defer { semaphores.signal() }
            print("Async 4")
        }
    }
    
    public func QueueQOS() {
        let high = DispatchQueue.global(qos: .userInteractive)
        let medium = DispatchQueue.global(qos: .userInitiated)
        let low = DispatchQueue.global(qos: .background)
        let semaphore = DispatchSemaphore(value: 1)
        
        high.async {
            // Wait 2 seconds just to be sure all the other tasks have enqueued
            Thread.sleep(forTimeInterval: 2)
            semaphore.wait()
            defer { semaphore.signal() }
            print("High priority task is now running")
        }
        for i in 1 ... 10 {
            medium.async {
                let waitTime = Double(exactly: arc4random_uniform(7))!
                print("Running medium task \(i)")
                Thread.sleep(forTimeInterval: waitTime)
            }
        }
        low.async {
            semaphore.wait()
            defer { semaphore.signal() }
            print("Running long, lowest priority task")
            Thread.sleep(forTimeInterval: 5)
        }
        
    }
}


extension GCDQ.Queues {
    public func raceConditions() {
        var queue: DispatchQueue
        queue = .init(label: "CUSTOM", attributes: .concurrent)
        var _x: Int = 0
        var x: Int {
            get {
                return queue.sync {
                    return _x
                }
            } set {
                queue.async(flags: .barrier) {
                    _x = _x + newValue
                }
            }
        }
        queue.async {
            print(x)
            x += 1
        }
        queue.async {
            print(x)
            x += 1
        }
        queue.async {
            print(x)
            x += 1
        }
        queue.async {
            print(x)
            x += 1
        }
        queue.async {
            print(x)
            x += 1
        }
        queue.async {
            print(x)
            x += 1
        }
        queue.async {
            print(x)
            x += 1
        }
        queue.async {
            print(x)
            x += 1
        }
        queue.async {
            print(x)
            x += 1
        }
    }
}
