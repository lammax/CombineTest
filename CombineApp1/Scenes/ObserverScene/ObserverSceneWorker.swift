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
    
    var subscription: Cancellable?
    var subscription2: Cancellable?
    var anySubscription: AnyCancellable?
    


    func runObserver() {
    //        runObserver1()
    //        runObserver2()
    //        runObserver3()
//            runObserver4()
//        runObserver5()
//        runObserver6()
//        runObserver7()
//        runObserver8()
//        runObserver9()
//        runObserver10()
//        runObserver11()
        runObserver12()

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
       /* let pub1 = PassthroughSubject<Int, Never>()
        let pub2 = PassthroughSubject<Int, Never>()
        let pub3 = PassthroughSubject<String, Never>()

        let publication = pub1.merge(with: pub2).sink { (val) in
            print(val)
        }
        
        pub2.send(5)
        pub1.send(6)*/
        
        //combineLatest
        /*let pub1 = PassthroughSubject<Int, Never>()
        let pub2 = PassthroughSubject<String, Never>()
        
        let publication = pub1.combineLatest(pub2).sink { (tuple) in
            print(tuple)
        }
        
        pub1.send(1)
        pub2.send("a")
        pub1.send(2)
        pub2.send("b")
        pub1.send(3)
        pub2.send("c")
        pub1.send(4)
        pub2.send("d")*/
 
        //zip
        /*let pub1 = PassthroughSubject<Int, Never>()
        let pub2 = PassthroughSubject<String, Never>()
        
        let publication = pub1.zip(pub2).sink { (tuple) in
            print(tuple)
        }
        
        pub1.send(1)
        pub2.send("a")
        pub1.send(2)
        pub2.send("b")
        pub1.send(3)
        pub2.send("c")
        pub1.send(4)
        pub2.send("d")*/



    }
    
    /*func getImage(images: [String], index: Int) -> AnyPublisher<UIImage?, Never> {
        return Future<UIImage?, Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                promise(.success(UIImage(named: images[index])))
            }
        }.print().map { $0 }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }*/
    
    private func runObserver8() { //Sequence operators
        //min & max
        /*let publisher = [1, -3, 8, 23,-100, 1000].publisher
        publisher
            .min()
            .sink { print($0) }
        publisher
            .max()
            .sink { print($0) }*/
        
        //first & last
        /*let publisher = [1, -3, 8, 23,-100, 1000].publisher
        publisher
            .first()
            .sink { print($0) }
        publisher
            .first(where: { $0 > 9 })
            .sink { print($0) }
        publisher
            .last()
            .sink { print($0) }*/
        
        //output
        /*let publisher = ["A", "B", "C", "D"].publisher
        publisher.output(at: 2).sink{ print($0) }
        publisher.output(in: 0...2).sink{ print($0) }*/
        
        //count
        /*let publisher = ["A", "B", "C", "D"].publisher
        publisher.count().sink{ print($0) }
        let publisher1 = PassthroughSubject<Int, Never>()
        let cancel = publisher1.count().sink { print($0) }
        publisher1.send(1)
        publisher1.send(2)
        publisher1.send(completion: .finished)
        publisher1.send(3)
        publisher1.send(4)
        publisher1.send(completion: .finished)*/
        
        //contains
        /*let publisher = ["A", "B", "C", "D"].publisher
        publisher.contains("B").sink { print($0) }*/
        
        //allSatisfy
        /*let publisher = [1, -3, 8, 23,-100, 1000].publisher
        publisher
            .allSatisfy {$0 > 3}
            .sink { print($0) }*/
        
        //reduce
        /*let publisher = [1, -3, 8, 23,-100, 1000].publisher
        publisher
            .reduce(0, { $0 + $1 })
            .sink { print($0) }*/
        


        
    }
    
    private func runObserver9() { //Combine for networking
        // 1 - URLSession
        let cancellable = getPosts()
            .receive(on: DispatchQueue.global())
            .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
        // 2 - Codable support
        // 3 - Displaying posts on a table view
    }
    
    struct Post: Codable {
        let userId: Int
        let id: Int
        let title: String
        let body: String
    }
    
    func getPosts() -> AnyPublisher<[Post], Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            fatalError("Invalid url")
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }
    
    private func runObserver10() { //Debugging Combine
        //1 - Printing events
        /*let publisher = (1...20).publisher
        publisher
            .print("Debugging")
            .sink { print($0) }*/
        
        //2 - Acting on events - performing side effects
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            fatalError("Invalid url")
        }
        
        let request = URLSession.shared.dataTaskPublisher(for: url)
        anySubscription = request
            .handleEvents(
                receiveSubscription: { _ in print("Subscription received") },
                receiveOutput: { _, _ in print("Received output") },
                receiveCompletion: { _ in print("Received completion") },
                receiveCancel: { print("Received cancel") },
                receiveRequest: { _ in print("Received request") }
            )
            .sink(
                receiveCompletion: { print($0) },
                receiveValue: { (data, response) in
                    print(data)
                }
            )
            
            /*.map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()*/
        
        //3 - Using debugger
        //detached app
        
    }
    
    private func runObserver11() { //Combine timers
        // 1 - Using Run loop
        /*let runLoop = RunLoop.main
        subscription = runLoop.schedule(
            after: runLoop.now,
            interval: .seconds(2),
            tolerance: .milliseconds(100)
            ) {
                print("Timer fired")
            }
        runLoop.schedule(after: .init(Date(timeIntervalSinceNow: 3.0))) { [weak self] in
            print("subscription cancelled")
            self?.subscription?.cancel()
        }*/
        
        // 2 - Timer class
        /*anySubscription = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .scan(0) { counter, _ in
                counter + 1
        }
            .sink { (val) in
                print(val)
        }*/
        
        // 3 - Using DispatchQueue
        
        var counter = 0
        
        let queue = DispatchQueue.global(qos: .userInteractive)
        let sourceInt = PassthroughSubject<Int, Never>()
        
        subscription2 = queue.schedule(
            after: queue.now,
            interval: .seconds(1)) {
                sourceInt.send(counter)
                counter += 1
        }
        
        subscription = sourceInt.sink(receiveValue: { (val) in
            print(val)
        })
        
    }
    
    private func runObserver12() { //Resources in Combine
        // 1 - Understanding the problem
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            fatalError("Invalid url")
        }
        
        /*let request = URLSession.shared.dataTaskPublisher(for: url).map(\.data).print()
            
        subscription = request.sink(
            receiveCompletion: { _ in },
            receiveValue: { print($0) }
        )
        subscription2 = request.sink(
            receiveCompletion: { _ in },
            receiveValue: { print($0) }
        )*/

        // 2 - Share
        let request = URLSession.shared.dataTaskPublisher(for: url).map(\.data).print().share()

        subscription = request.sink(
            receiveCompletion: { _ in },
            receiveValue: { print($0) }
        )
        subscription2 = request.sink(
            receiveCompletion: { _ in },
            receiveValue: { print($0) }
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.anySubscription = request.sink(
                receiveCompletion: { _ in },
                receiveValue: { print($0) }
            )
        }


        // 3 - Multicast
        
    }
    
}
