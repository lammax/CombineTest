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
//            runObserver4()
//        runObserver5()
//        runObserver6()
        runObserver7()

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
        /*let publisherCGP = PassthroughSubject<CGPoint, Never>()
        let subscription = publisherCGP.map(\.x, \.y).sink { print("X is \($0), Y is \($1)") }
        publisherCGP.send(CGPoint(x: 1, y: 2))
        publisherCGP.send(CGPoint(x: 3, y: 4))
        subscription.cancel()*/
        
        //Flatmap
        /*let citySchool = ObserverScene.School(with: "Best school", and: 777)
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
        townSchool.noOfStudents.value += 1*/
        
        //replaceNil
        /*["A", "B", nil, "C"]
            .publisher
            .replaceNil(with: "-")
            .map { $0 ?? "" }
            .sink {
                print($0)
            }*/
        
        //replaceEmpty
        /*let empty = Empty<Int, Never>()
        empty
        .replaceEmpty(with: 1)
        .sink(
            receiveCompletion: { print($0) },
            receiveValue: { print($0) }
        )*/
        
        //scan operator
        /*let publisher = (1...10).publisher
        publisher.scan([]) { numbers, val -> [Int] in
            numbers + [val]
        }.sink { print($0) }*/
        
        //filter operator
        /*let numbers = (1...20).publisher
        numbers
            .filter { $0 % 2 == 0 }
            .sink { print($0) }*/
        
        //removeDuplicates
        /*let words = "apple apple melon apple cucumber apple peach apple cherry".components(separatedBy: " ").publisher
        words.removeDuplicates().sink {print($0)}*/
        
        //compactMap
        /*let strings = ["2", "b", "0.2", "-", "123"].publisher
        strings
            .compactMap { Float($0) }
            .sink { print($0) }*/
        
        //ignoreOutput
        /*let numbers = (1...5000).publisher
        numbers
            .ignoreOutput()
            .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })*/
        
        //first operator
        /*let numbers = (1...9).publisher
        numbers.first(where: { $0 % 2 == 0 })
        .sink(receiveValue: { print($0) })*/

        //last operator
        /*let numbers = (1...9).publisher
        numbers.last(where: { $0 % 2 == 0 })
        .sink(receiveValue: { print($0) })*/
        
        //dropFirst operator
        /*let numbers = (1...9).publisher
        numbers.dropFirst()
        .sink(receiveValue: { print($0) })*/

        //dropWhile operator
        /*let numbers = (1...9).publisher
        numbers.drop(while: { $0 != 5 })
        .sink(receiveValue: { print($0) })*/

        //dropWhile operator
        /*let isReady = PassthroughSubject<Void, Never>()
        let taps = PassthroughSubject<Int, Never>()

        let cancel = taps.drop(untilOutputFrom: isReady).sink {
            print($0)
        }
            
        (1...10).forEach { n in
            taps.send(n)
            if n == 5 {
                isReady.send()
            }
        }*/
        
        //prefix operator
        /*let numbers = (1...9).publisher
        numbers.prefix(5)
        .sink(receiveValue: { print($0) })*/
        
        //operators challenge
        let numbers = (1...100).publisher
        numbers
            .dropFirst(50)
            .prefix(20)
            .filter { $0 % 2 == 0 }
            .sink { print($0) }

    }
    
    private func runObserver7() { //Combining operators
        //prepend
        /*let numbers = (1...5).publisher
        let numbers2 = (500...510).publisher
        
        numbers
            .prepend(6...10)
            .prepend(-1, -2)
            .prepend([12,43])
            .prepend(numbers2)
            .sink { print($0) }*/
        
        //append
        /*let numbers = (1...5).publisher
        let numbers2 = (500...510).publisher

        numbers
           .append(6...10)
           .append(-1, -2)
           .append(numbers2)
           .sink { print($0) }*/
        
        //switchToLatest
        /*let publisher1 = PassthroughSubject<String, Never>()
        let publisher2 = PassthroughSubject<String, Never>()
        
        let publishers = PassthroughSubject<PassthroughSubject<String, Never>, Never>()
        
        let cancel = publishers.switchToLatest().sink { print($0) }
        
        publishers.send(publisher1)
        publisher1.send("P1 - V1")
        
        publishers.send(publisher2)
        publisher2.send("P2 - V1")
        publisher1.send("P1 - V2")
        publisher2.send("P2 - V2")*/
        
        //switchToLatest: 2nd example
        /*let images = ["denver", "houston", "seattle"]
        var index = 0
        let taps = PassthroughSubject<Void, Never>()
        
        let cancelable = taps.map { _ in
            self.getImage(images: images, index: index)
        }.print().switchToLatest().sink {
            print($0)
        }
        
        taps.send()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            index += 1
            taps.send()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
            index += 1
            taps.send()
        }*/
        
        //cancelable.cancel()
        
        //merge
        let pub1 = PassthroughSubject<Int, Never>()
        let pub2 = PassthroughSubject<Int, Never>()
        let pub3 = PassthroughSubject<String, Never>()

        let publication = pub1.merge(with: pub2).sink { (val) in
            print(val)
        }
        
        pub2.send(5)
        pub1.send(6)

    }
    
    func getImage(images: [String], index: Int) -> AnyPublisher<UIImage?, Never> {
        return Future<UIImage?, Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                promise(.success(UIImage(named: images[index])))
            }
        }.print().map { $0 }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
}
