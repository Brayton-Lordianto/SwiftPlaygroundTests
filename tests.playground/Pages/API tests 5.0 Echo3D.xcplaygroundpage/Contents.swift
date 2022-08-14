
import Foundation

// worked getting everything as a simple dictionary
let str = "https://console.echoar.xyz/query?key=weathered-sun-1162"


guard let url = URL(string: str) else{
    print("cannot get url")
    fatalError()
}

let task = URLSession.shared.dataTask(with: url){
    data, response, error in
    if let data = data {
//        print(String(data: data, encoding: .utf8))
    }
    
    
    
    let aDictionary : NSDictionary? = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
    
    if let actualDictionary = aDictionary?["db"] as? NSDictionary {
        print(actualDictionary.allKeys)
    }
    
    else {
        print("no ans")
    }
    

    
    
}

task.resume()
