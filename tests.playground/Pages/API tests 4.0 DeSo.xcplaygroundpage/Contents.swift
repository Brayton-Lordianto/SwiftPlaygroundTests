

import Foundation


// this works giving data to flask!
struct Request: Codable {
    let UserPublicKeyBase58Check: String
    let ReaderPublicKeyBase58Check: String
    let IsForSale: Bool
    let IsPending: Bool
    init(_ i: String, _ j: String, _ k: Bool, _ l: Bool) {
        UserPublicKeyBase58Check = i
        ReaderPublicKeyBase58Check = j
        IsForSale = k
        IsPending = l
    }
}

func post(to urlString: String, _ data: Int) {
    guard let url = URL(string: urlString) else{
        print("no link")
        return
    }
    
    do {
        let requestObject = Request("BrayLord","BrayLord",false,false)
        let data = try? JSONEncoder().encode(requestObject)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        // based on this, it seems to work
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
//            print(String(data: data!, encoding: .utf8)!)
            let x = response as! HTTPURLResponse
            print(String(data: data!, encoding: .utf8)!)
//            print(response ?? "no")
            print(error ?? "none")
        }
        task.resume()
    }
    
}

post(to: "https://identity.deso.org/api/v0/get-nfts-for-user", 3)
