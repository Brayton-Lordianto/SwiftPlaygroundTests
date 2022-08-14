//: [Previous](@previous)

import Foundation
import Combine
import PlaygroundSupport

let pub: Timer.TimerPublisher =
Timer.publish(every: 0.1, tolerance: nil, on: .main, in: .common, options: nil)

let connectedPub: Publishers.Autoconnect<Timer.TimerPublisher> = pub.autoconnect()

let subscription: AnyCancellable = connectedPub
    .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)
//    .scan(0, { count, output in
//        return count + 1
//    })
//    .filter({ count in
//        count > 1
//    })
    .sink { (completion) in
        print("completion: \(completion)")
    } receiveValue: { (output) in
        print("output \(output)")
    }

//var nullableSub: AnyCancellable? = connectedPub
//    .sink { (completion: Subscribers.Completion<Timer.TimerPublisher.Failure>) in
//        print("completion: \(completion)")
//    } receiveValue: { (output: Timer.TimerPublisher.Output) in
//        print("output \(output)")
//    }

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    subscription.cancel()
//    nullableSub = nil
}
