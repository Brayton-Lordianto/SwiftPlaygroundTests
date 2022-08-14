import Foundation

// this works!
struct TestItem: Codable {
    let sometext: String
    let somenum: Int
}

let str = "http://127.0.0.1:4000/get_testdata"

func get(from urlString: String) {
    guard let url = URL(string: urlString) else{
        print("cannot get url")
        return
    }

    print("url passed")
    let task = URLSession.shared.dataTask(with: url){
        data, response, error in

        let decoder = JSONDecoder()

        if let data = data,
           let decoded = try? decoder.decode([TestItem].self, from: data),
           if let data = data,
        {
            print(str)
            print(decoded)
        } else { print(error) }
    }
    task.resume()
}

get(from: str)
