import Foundation

// trying to do a post request
struct Item: Codable {
    struct Headers: Codable {
        let Host: String
    }
    let method: String
    let headers: Headers
}

func get(from urlString: String = "https://httpbin.org/anything/hi") {
    guard let url = URL(string: urlString) else{return}

    let task = URLSession.shared.dataTask(with: url){
        data, response, error in
        
        let decoder = JSONDecoder()

        if let data = data,
           let decoded = try? decoder.decode(Item.self, from: data),
           let str = String(data: data, encoding: .utf8)
        {
            // MARK: only difference is decoding the data as an array of items
//            print(str)
//            print(decoded)
        } else { print(error) }
    }
    task.resume()
}

func post(to urlString: String = "https://httpbin.org/anything/hi") {
    guard let url = URL(string: urlString) else{return}
    
    let json: [String:Any] = ["Test": "2", "Test2": "hi"]
    
    do {
        let data = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // based on this, it seems to work
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            print(String(data: data!, encoding: .utf8)!)
            print(response)
            print(error)
        }
        task.resume()
    }
    
}

post()
get()
