//
//  ObserverSceneWorker.swift
//  CombineApp1
//
//  Created by Mac on 02.11.2019.
//  Copyright (c) 2019 Lammax. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Combine
import CoreGraphics

class StringSubscriber: Subscriber {
    typealias Input = String
    typealias Failure = ObserverScene.MyError

    func receive(subscription: Subscription) {
        subscription.request(.max(2)) //backpressure
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print("Received value:", input)
        return .max(1)
    }
    
    func receive(completion: Subscribers.Completion<ObserverScene.MyError>) {
        print("Completed")
    }
    
}


class ObserverSceneWorker {
  
    func runObserver() {
    //        runObserver1()
    //        runObserver2()
    //        runObserver3()
            runObserver4()
//        runObserver5()
        runObserver6()

    }
    
    private func runObserver1() {
        let notification = Notification.Name("NotificationO1")
        let center = NotificationCenter.default
        
        /*let observer*/ _ = center.addObserver(forName: notification, object: nil, queue: OperationQueue()) { (notification) in
            print("Notification received")
        }
        
        center.post(name: notification, object: nil)
        
        center.removeObserver(notification)
    }
    
    private func runObserver2() {
        let notification = Notification.Name("NotificationO2")
        let publisher = NotificationCenter.default.publisher(for: notification, object: nil)
        let subscription = publisher.sink { _ in
            print("Notification received 2")
        }
        subscription.cancel()
        NotificationCenter.default.post(name: notification, object: nil)

    }

    private func runObserver3() {
        let publisher = ["A", "B", "C","D","E","F","G","H","I","J","K"].publisher
        let subscriber = StringSubscriber()
        //publisher.subscribe(subscriber)
        
    }

    private func runObserver4() { //Subjects
        let subscriber = StringSubscriber()
        let subject = PassthroughSubject<String, ObserverScene.MyError>()
        subject.subscribe(subscriber)
        
        let subscription = subject.map(\.count) .sink(receiveCompletion: { (completion) in
            print("received completion fron sink")
        }) { (val) in
            print("received value fron sink",val)
        }
        
        subject.send("L")
        subject.send("ABC")
        
        subscription.cancel()
        
        subject.send("E")
        subject.send("F")
    }
    
    private func runObserver5() { //Type eraser
        let publisher = PassthroughSubject<Int, Never>().eraseToAnyPublisher()
        print(publisher.self)
    }
    
    private func runObserver6() { //Transformation operators
        //Collect
        /*let sValues = ["A", "B", "C","D","E","F","G","H","I","J","K"]
        sValues.publisher.sink {
            print($0)
        }
        sValues.publisher.collect().sink {
            print($0)
        }
        sValues.publisher.collect(2).sink {
            print($0)
        }*/
        
        //Map
        /*let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        let iValues = [12, 434, 6768, 24, 5, 7788]
        iValues.publisher.map{ formatter.string(from: NSNumber(integerLiteral: $0)) ?? "" }.sink{ print($0) }*/
        
        //Map keypath
        let publisherCGP = PassthroughSubject<CGPoint, Never>()
        let subscription = publisherCGP.map(\.x, \.y).sink { print("X is \($0), Y is \($1)") }
        publisherCGP.send(CGPoint(x: 1, y: 2))
        publisherCGP.send(CGPoint(x: 3, y: 4))
        subscription.cancel()
        
        //Flatmap
        let citySchool = ObserverScene.School(with: "Best school", and: 777)
        let school = CurrentValueSubject<ObserverScene.School, Never>(citySchool)
        let subscription2 = school
            .flatMap({
                $0.noOfStudents
            })
            .sink {
                print($0)
            }
        
        let townSchool = ObserverScene.School(with: "High school", and: 555)
        school.value = townSchool
        
        citySchool.noOfStudents.value += 1
        townSchool.noOfStudents.value += 1

        
    }
    
}
