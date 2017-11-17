//
//  ViewController.swift
//  lab3
//
//  Created by Eli Pinkus on 10/25/17.
//  Copyright © 2017 Eli Pinkus. All rights reserved.
//

import UIKit

class NewCacheViewController: UIViewController {
    var cache: GeoCache? = nil
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var detailsField: UITextField!
    
    @IBOutlet weak var rewardField: UITextField!
    @IBOutlet weak var creatorField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBAction func addGeoCache(_ sender: Any)
    {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionField.isUserInteractionEnabled = false
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancel(sender: UIBarButtonItem)
    {
        cache = nil
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if titleField.text! != "" && detailsField.text! != "" && creatorField.text! != "" && rewardField.text! != ""
        {
            let newCache = GeoCache(titleField.text!,detailsField.text!,creatorField.text!,rewardField.text!, randomCacheId())
            cache = newCache
        }
        else
        {
            descriptionField.text = "error"
        }
    }

}

