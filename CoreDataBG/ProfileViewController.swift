//
//  ProfileViewController.swift
//  CoreDataBG
//
//  Created by Ashutosh Kumar Jha on 5/13/16.
//  Copyright © 2016 Ashutosh Kumar Jha. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var profile: Person?

    override func viewDidLoad(){
        super.viewDidLoad()
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setup() {
        print("Comes to this view controller")
        
        nameLabel.text = "\(profile?.valueForKey("name") as? String)"
        ageLabel.text = "\(profile?.valueForKey("age") as? String)"
        //cityLabel.text = "\(profile?.valueForKey("name") as? String)"
    }
}
