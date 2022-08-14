import Foundation

struct Item: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    // you can't have extra stuff else it won't work
    // let extra: Int
}

func decodeAPI(){
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else{return}

    let task = URLSession.shared.dataTask(with: url){
        data, response, error in
        
        let decoder = JSONDecoder()

        if let data = data{
            // MARK: only difference is decoding the data as an array of items
            do{
                let tasks = try decoder.decode([Item].self, from: data)
                tasks.forEach{ i in
                    print(i)
                }
            }catch{
                print(error)
            }
        }
    }
    task.resume()

}
decodeAPI()

