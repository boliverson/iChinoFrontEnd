//
//  UserListViewController.swift
//  JudgementDay
//
//  Created by Mackenzie Hampel on 4/15/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import Foundation
import UIKit

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}
