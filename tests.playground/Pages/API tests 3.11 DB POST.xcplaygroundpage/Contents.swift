
import Foundation


// this works giving data to flask!
struct TestItem: Codable {
    let sometext: String
    let somenum: Int
    init(sometext: String, somenum: Int) {
        self.sometext = sometext
        self.somenum = somenum
    }
}

func post(to urlString: String, _ data: TestItem) {
    guard let url = URL(string: urlString) else{return}
    
    do {
        let data = try? JSONEncoder().encode(data)
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // based on this, it seems to work
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            print(String(data: data!, encoding: .utf8)!)
            print(response ?? "no")
            print(error ?? "none")
        }
        task.resume()
    }
    
}

post(to: "http://127.0.0.1:4000/test_post", TestItem(sometext: "hi", somenum: 23))
