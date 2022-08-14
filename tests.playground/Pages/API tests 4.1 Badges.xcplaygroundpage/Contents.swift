import Foundation
class Badge: Identifiable, Codable {
    var id: String { imageURL.description }
    var imageURL: String
    var date: String
    var hackathonLink: URL
    var issuedBy: String
    var message: String
    init(imageURL: String, date: String, hackathonLink: URL, issuedBy: String, message: String) {
        self.imageURL = imageURL
        self.date = date
        self.hackathonLink = hackathonLink
        self.issuedBy = issuedBy
        self.message = message
    }
}

func post(to urlString: String, _ data: [String:String]) {
    guard let url = URL(string: urlString) else{return}
    
    do {
//        let data = try? JSONEncoder().encode(data)
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
//        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // based on this, it seems to work
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if (data == nil) { print("nil")}
//            print(String(data: data!, encoding: .utf8)!)
            let s = try! JSONDecoder().decode([Badge].self, from: data!)
            print(s)
//            print(response ?? "no")
//            print(error ?? "none")
        }
        task.resume()
    }
    
}

let getBadgesLink  = "http://127.0.0.1:8000/get_badge_info"

struct val { var badges = [Badge]() }

var arr = [Badge]()

func decodeBadgesData(userScreenName: String = "bl3321") -> [Badge] {
    guard let url = URL(string: getBadgesLink) else{ return [] }
//    var badges = [Badge]()
//    var v = val()

    do {
//        let data = try? JSONEncoder().encode(data)
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
//        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // based on this, it seems to work
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if (data == nil) { print("nil")}
//            print(String(data: data!, encoding: .utf8)!)
            let s = try! JSONDecoder().decode([Badge].self, from: data!)
//            print(s)
            arr = s
//            badges = s
//            v.badges = s
//            print(v.badges[0].imageURL)
//            for badge in s {
//                badges.append(Badge(imageURL: badge.imageURL, date: badge.date, hackathonLink: badge.hackathonLink, issuedBy: badge.issuedBy, message: badge.message))
//            }
//            print(badges)
//            print(response ?? "no")
//            print(error ?? "none")
        }
//        print(badges)
//        print(v.badges)
        task.resume()
    }
    return []
}

(decodeBadgesData())
DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    // Put your code which should be executed with a delay here
    print(arr)
}
//post(to: "http://127.0.0.1:8000/get_badge_info", ["devpostScreenName":"bl3321"])
