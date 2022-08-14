//: [Previous](@previous)

import Foundation
import Combine

let companies: Future<[String], Error> = Future { promixe in
    promixe(.success(["Apple", "Google", "Microsoft"]))
}


// for async

// Just Publisher = a single value
    //never fails
