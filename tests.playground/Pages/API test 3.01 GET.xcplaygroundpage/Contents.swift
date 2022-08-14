import Foundation

// this all works. how to call a GET request.
struct Item: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    // you can't have extra stuff else it won't work
    // let extra: Int
}

func callAPI(){
    // get the url
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else{
        return
    }

    // ask the team members to process the data
    let task = URLSession.shared.dataTask(with: url){
        data, response, error in
        
        // data received back is json
        if let data = data, let item = try? JSONDecoder().decode(Item.self, from: data), let str = String(data: data, encoding: .utf8) {
            print(str)
            print(item)
        }
    }

    task.resume()
}

callAPI()
print("hi")
