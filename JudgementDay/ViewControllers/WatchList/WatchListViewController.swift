//
//  WatchListViewController.swift
//  JudgementDay
//
//  Created by Mackenzie Hampel on 4/6/19.
//  Copyright © 2019 Weber State. All rights reserved.
//
import UIKit
import Foundation
class WatchListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var competitorsList = [String]()
    var competitorScores = [String]() //maybe doubles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competitorsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Person 1"
        return cell
    }
    @IBAction func didSelectBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
