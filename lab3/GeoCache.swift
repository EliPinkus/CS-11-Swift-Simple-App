import UIKit

struct GeoCache
{
    var id: Int
    var title: String
    var details: String
    var creator: String
    var reward: String
    
    init(_ title: String, _ details: String, _ creator: String,_ reward: String, _ id: Int)
    {
        self.title = title
        self.details = details
        self.creator = creator
        self.reward = reward
        self.id = id
    }
    
    init?(fromDictionary dict: [String:Any])
    {
        let keys: [String] = Array(dict.keys)
        if keys.contains("title") && keys.contains("details") && keys.contains("creator") && keys.contains("reward")
        {
            self.id = dict["id"] as! Int
            self.title = dict["title"] as! String
            self.details = dict["details"] as! String
            self.creator = dict["creator"] as! String
            self.reward = dict["reward"] as! String
            
        }
        else
        {
            return nil
        }
    }
    
    var dictionary: [String: Any]
    {
        get
        {
            var result = [String: Any]()
            result["title"] = self.title
            result["details"] = self.details
            result["creator"] = self.creator
            result["reward"] = self.details
            
            return result
        }
    }
    
    var desription: String
    {
        get
        {
            return self.title + ": located at " + self.details + " with reward " + self.reward + " \n" + "Created By " + self.creator
        }
    }
    
}
func loadCachesFromDefaults()->[GeoCache]?
{
    let defaults = UserDefaults.standard
    if let caches = defaults.array(forKey: "caches")
    {
        var result: [GeoCache] = [GeoCache]()
        for cache in caches
        {
            result.append(GeoCache(fromDictionary: cache as! [String : String])!)
        }
        return result
    }
    else
    {
        return nil
    }
    
    
}

func saveCachesToDefaults(_ caches: [GeoCache])
{
    var result:[[String: String]] = [[String:String]]()
    for cache in caches
    {
        result.append(cache.dictionary as! [String : String])
    }
    
    let defaults = UserDefaults.standard
    defaults.set(result, forKey: "caches")
    defaults.synchronize()
}

func sendCacheToServer(_ cache: GeoCache)
{
    let target = URL(fileURLWithPath: "http://localhost:5000/createCache")
    var request = URLRequest(url: target)
    request.httpMethod = "POST"
    let data = try? JSONSerialization.data(withJSONObject: cache.dictionary)
    request.httpBody = data
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: request, completionHandler:
    {
        data, response, error in
        if let error = error {
            print(error.localizedDescription ?? "Some kind of error")
            return
        }
        print(response)
        print(data)
    })
    
    task.resume()
}

func loadCachesFromServer(onComplete: @escaping ([GeoCache]) -> ())
{
    var result = [GeoCache]()
    let target = URL(fileURLWithPath: "http://localhost:5000/getCaches")
    var request = URLRequest(url: target)
    request.httpMethod = "GET"
    let task = URLSession.shared.dataTask(with: request, completionHandler:
    {
        data, response, error in
        if let error = error {
            print(error.localizedDescription ?? "Some kind of error")
            return
        }
        print(response)
        print(data)
        let candidates = try? JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
        if let caches = candidates as? [[String:Any]]
        {
            for cache in caches
            {
                result.append(GeoCache(fromDictionary: cache)!)
            }
        }
        onComplete(result)
    })
    
    task.resume()
}

func randomCacheId() -> Int
{
    return Int(arc4random())
}

