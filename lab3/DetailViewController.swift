//
//  DetailViewController.swift
//  lab3
//
//  Created by Eli Pinkus on 11/2/17.
//  Copyright © 2017 Eli Pinkus. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var info: String?
    @IBOutlet weak var details: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let info_string = info
        {
            details.text = info_string
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
