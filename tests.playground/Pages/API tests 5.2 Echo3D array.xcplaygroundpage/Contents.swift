// core concepts: semaphore to wait for it to finish


import Foundation

class dataUsdzFileManager {
    static var directoryPath: URL {
        try! FileManager.default.url(for: .documentDirectory,in: .userDomainMask,appropriateFor: nil,create: false)
    }
    
    static func getPathIfExists(fileName: String) -> (URL, Bool) {
        // setup the url to save in
        let savedPath = directoryPath
            .appendingPathComponent(fileName)
        
        // clear the temp first
        FileManager.default.clearTmpDirectory()
        
        // check if already exists
        print("DEBUG: searching for " + savedPath.description)
        let fileDoesExist = FileManager.default.fileExists(atPath: savedPath.path)
        if fileDoesExist { print("DEBUG: " + fileName + " exists"); return (savedPath, true) }
        print("DEBUG: \(fileName) is not found/cached")
        
        return (savedPath, false)
    }
}

extension FileManager {
    // clear temp so there are no conflicts with the temporary directory
    func clearTmpDirectory() {
        do {
            let tmpDirectory = try contentsOfDirectory(atPath: NSTemporaryDirectory())
            try tmpDirectory.forEach {[unowned self] file in
                let path = String.init(format: "%@%@", NSTemporaryDirectory(), file)
                try self.removeItem(atPath: path)
            }
        } catch {
            print(error)
        }
    }
}

struct DataModel {
    let filename: String
    let storageFileID: String
    let description: String
    var pathToDownloaded: URL {
        dataUsdzFileManager.getPathIfExists(fileName: self.filename).0
    }
}

var models = [DataModel]()

func getDataAsNSDict(api_key: String = "weathered-sun-1162", completion: @escaping (NSDictionary?) -> ()) {
    let urlString = "https://console.echoar.xyz/query?key=" + api_key
    guard let url = URL(string: urlString) else{ print("DEBUG: NO URL FOUND"); return }
    
    let sem = DispatchSemaphore.init(value: 0)
    let task = URLSession.shared.dataTask(with: url) {
        data, response, error in
        guard let data = data else { print("DEBUG: NO DATA FOUND"); return }
        
        do {
            let aDictionary : NSDictionary? = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            if let actualDictionary = aDictionary?["db"] as? NSDictionary {
                completion(actualDictionary)
                print(actualDictionary)
            }
            
            else {
                print("no db")
                completion(nil)
            }
        } catch { completion(nil) }
        
        defer { sem.signal() }
    }
    
    task.resume()
    sem.wait()
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
        models.append(data)
        
    }
    
    // once everything is done, then give the signal
}


getDataAsNSDict(completion: encodeIntoModel)
//print(models)
//print("BREAK")
//print(models[0].pathToDownloaded)
//print(models.map {$0.filename})
