import UIKit

struct GeoCache
{
    var title: String
    var details: String
    var creator: String
    var reward: String
    
    init(_ title: String, _ details: String, _ creator: String,_ reward: String)
    {
        self.title = title
        self.details = details
        self.creator = creator
        self.reward = reward
    }
    
    init?(fromDictionary dict: [String:String])
    {
        let keys: [String] = Array(dict.keys)
        if keys.contains("title") && keys.contains("details") && keys.contains("creator") && keys.contains("reward")
        {
            self.title = dict["title"]!
            self.details = dict["details"]!
            self.creator = dict["creator"]!
            self.reward = dict["reward"]!
            
        }
        else
        {
            return nil
        }
    }
    
    var dictionary: [String: String]
    {
        get
        {
            var result = [String: String]()
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
        result.append(cache.dictionary)
    }
    
    let defaults = UserDefaults.standard
    defaults.set(result, forKey: "caches")
    defaults.synchronize()
}


