//import UIKit
//
//// no work.
//
//struct FilmSummary: Codable {
//  let count: Int?
//  let results: [Film]?
//}
//
//struct Film: Codable {
//  let title: String
//  let episodeId: Int
//  
//  enum CodingKeys: String, CodingKey {
//    case title
//    case episodeId = "episode_id"
//  }
//  
//  init(title: String,
//       episodeId: Int) {
//    self.title = title
//    self.episodeId = episodeId
//  }
//}
//
//
//let url = URL(string: "https://www.swapi.co/api/films")
//
//// data task to process the request
//let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//    // if any errors; error is of type Error?
//    if let error = error {
//      print("Error accessing swapi.co: \(error)")
//      return
//    }
//    
//    // response is firsly in type URLResonse?
//    // httpurlresponse allows us to get states like status codes and headers
//    guard let httpResponse = response as? HTTPURLResponse,
//          // 200 to 299 are OK. anything else is error.
//          (200...299).contains(httpResponse.statusCode) else {
//        print("Error with the response, unexpected status code: \(response)")
//        return
//    }
//
//    // now you can do what you want with the data: Data?
//    // print(data)! yields ____ bytes; you have to do something with the data, such as json decoding it
//    //    if let JSONString = String(data: data!, encoding: String.Encoding.utf8) {
//    //       print(JSONString)
//    //    }
//    // this shows the jsondata is all fine.
//
//    print("hi")
//    if let data = data,
//       let filmSummary = try? JSONDecoder().decode(FilmSummary.self, from: data) {
//        
//        print(filmSummary.count)
//        print("hi")
//    }
//
//})
//
//task.resume()
