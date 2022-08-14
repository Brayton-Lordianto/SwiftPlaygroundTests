//: [Previous](@previous)

// did not work
//import Foundation
//
//let str : String = "http://google.com?test=toto&test2=titi"
//let url = URL(string: str)!
//
//let task = URLSession.shared.dataTask(with: url) { data, response, error in
//    if let error = error { return }
//
//    print("hi")
//    // process the data
//    if let data = data,
//       let string = String(data: data, encoding: .utf8) {
//        print(string)
//    }
//    print("world \(String(data: data!, encoding: .utf8))")
//}
//
//print("hello")
//task.resume()
