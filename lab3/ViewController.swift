//
//  ViewController.swift
//  lab3
//
//  Created by Eli Pinkus on 10/25/17.
//  Copyright © 2017 Eli Pinkus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var counter: Int = 0
    var caches: [GeoCache] = [GeoCache]()
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var detailsField: UITextField!
    
    @IBOutlet weak var rewardField: UITextField!
    @IBOutlet weak var creatorField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBAction func addGeoCache(_ sender: Any)
    {
        if titleField.text! != "" && detailsField.text! != "" && creatorField.text! != "" && rewardField.text! != ""
        {
            let newCache = GeoCache(titleField.text!,detailsField.text!,creatorField.text!,rewardField.text!)
            caches.append(newCache)
            saveCachesToDefaults(caches)
            
        }
        else
        {
            descriptionField.text = "error"
        }
    }
    @IBAction func nextCache(_ sender: Any)
    {
        counter += 1
        if let init_caches = loadCachesFromDefaults()
        {
            caches = init_caches
            let cache: GeoCache = init_caches[counter % caches.count]
            print("counter " + counter.description)
            titleField.text = cache.title
            detailsField.text = cache.details
            creatorField.text = cache.creator
            rewardField.text = cache.reward
            descriptionField.text = cache.desription
            print("loaded " + caches.count.description)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionField.isUserInteractionEnabled = false
        if let init_caches = loadCachesFromDefaults()
        {
            caches = init_caches
            let init_cache: GeoCache = init_caches[counter % caches.count]
            print("counter " + counter.description)
            titleField.text = init_cache.title
            detailsField.text = init_cache.details
            creatorField.text = init_cache.creator
            rewardField.text = init_cache.reward
            descriptionField.text = init_cache.desription
            print("loaded " + caches.count.description)
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

