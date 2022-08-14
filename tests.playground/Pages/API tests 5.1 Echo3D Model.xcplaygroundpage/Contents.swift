
import Foundation

struct DataModel {
    let filename: String
    let storageFileID: String
    let description: String
    var pathToDownloaded: String {
        ""
    }
}

func getDataAsNSDict(api_key: String = "weathered-sun-1162", completion: @escaping (NSDictionary?) -> ()) {
    let urlString = "https://console.echoar.xyz/query?key=" + api_key
    guard let url = URL(string: urlString) else{ print("DEBUG: NO URL FOUND"); return }
    
    let task = URLSession.shared.dataTask(with: url) {
        data, response, error in
        guard let data = data else { print("DEBUG: NO DATA FOUND"); return }
        
        do {
            let aDictionary : NSDictionary? = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            if let actualDictionary = aDictionary?["db"] as? NSDictionary {
                print(actualDictionary.allKeys)
                completion(actualDictionary)
            }
            
            else {
                print("no db")
                completion(nil)
            }
        } catch { completion(nil) }
    }
    
    task.resume()
}



func encodeIntoModel(_ data: NSDictionary?) {
    guard let data = data else { print("DEBUG: NO DICTIONARY COMPLETION"); return }
    
    let keys = data.allKeys
    for key in keys {
        let singleEntry = data[key]! as! NSDictionary
        
        // get data information as a data model
        guard
            let hologram = singleEntry["hologram"] as? NSDictionary,
            let filename = hologram["filename"] as? String,
            let storageID = hologram["storageID"] as? String
        else { print("DEBUG: NO FILE FOUND"); return }
        let additionalData = singleEntry["additionalData"] as? NSDictionary
        let description = additionalData?["entryComment"] as? String ?? "No Description"
        let data = DataModel(filename: filename, storageFileID: storageID, description: description)
        
        // store that data into a result
        print(data)
        
    }
}


getDataAsNSDict(completion: encodeIntoModel)


