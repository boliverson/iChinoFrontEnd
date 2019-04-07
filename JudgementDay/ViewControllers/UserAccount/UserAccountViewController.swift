//
//  UserAccountViewController.swift
//  JudgementDay
//
//  Created by Mackenzie Hampel on 4/6/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import Foundation
import UIKit
class UserAccountViewController: UIViewController {
    @IBOutlet var bottomToolbar: UIToolbar!
    @IBOutlet var profileImg: UIImageView!
    @IBOutlet weak var btnCreateTeam: UIButton!
    @IBOutlet weak var btnCreateComp: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Testing")
        
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg.clipsToBounds = true
    }

    @IBAction func didSelectCreateTeam(_ sender: Any) {
        
    }
    @IBAction func didSelectCreateCompetition(_ sender: Any) {
   
    
    }
    
    
}
