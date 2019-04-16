//
//  ScoreCardViewController.swift
//  JudgementDay
//
//  Created by Mackenzie Hampel on 4/3/19.
//  Copyright © 2019 Weber State. All rights reserved.
//
import UIKit
import Foundation

struct ScoreItem {
    var userDescription: String
    var maxValue: String
}

class ScoreCardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DataTransfer {

    //TODO: broken adding and saving stuff
    var dataArray = ["A", "B", "C"]
    var scoreItems = [ScoreItem]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: String(describing: ScoreCardCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ScoreCardCell.self))
        if scoreItems.count == 0 {
            scoreItems.append(ScoreItem(userDescription: "", maxValue: ""))
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.allowsSelection = false
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ScoreCardCell.self), for: indexPath) as! ScoreCardCell
        
        cell.maxValue?.text = scoreItems[indexPath.row].maxValue
        cell.userDescription?.text = scoreItems[indexPath.row].userDescription
      //  scoreItems.append(ScoreItem.init(userDescription: cell.userDescription?.text ?? "", maxValue: cell.maxValue?.text ?? ""))
        cell.delegate = self

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
         scoreItems.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    

    @IBAction func didSelectAddCell(_ sender: Any){
        tableView.reloadData()
    }
    
    @IBAction func didSelectCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didSelectCreateScoreCard(_ sender: Any) {
        
        
    }
    func sendDataToScoreCard(userDescription: String, maxValue: String) {
        scoreItems.append(ScoreItem.init(userDescription: userDescription, maxValue: maxValue))
    }
    
}
