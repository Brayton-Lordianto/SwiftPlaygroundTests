
import Foundation
import SwiftUI

let getBadgesLink  = "http://127.0.0.1:8000/get_badge_info"

class Gallery: ObservableObject {
    @Published var badges = [Badge]()
    
    init() {
        // load the badges
        self.loadBadges()
    }
    
    func loadBadges() {
        guard let url = URL(string: getBadgesLink) else{
            print("url not working")
            return
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            // based on this, it seems to work
            let task = URLSession.shared.dataTask(with: request) {
                data, response, error in
                if (data == nil) { print("nil")}
//                print(String(data: data!, encoding: .utf8)!)
                let s = try! JSONDecoder().decode([Badge].self, from: data!)
                print(s)
                self.badges = s
            }
            task.resume()
        }
    }
}

struct Badge: Identifiable, Codable {
    var id: String { imageURL.description }
    var imageURL: URL
    var date: String
    var hackathon: String
    var hackathonLink: URL
    var issuedBy: String
    var message: String
}

let g = Gallery()
