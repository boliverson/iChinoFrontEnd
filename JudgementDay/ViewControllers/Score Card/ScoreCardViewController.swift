//
//  ScoreCardViewController.swift
//  JudgementDay
//
//  Created by Mackenzie Hampel on 4/3/19.
//  Copyright © 2019 Weber State. All rights reserved.
//
import UIKit
import Foundation
class ScoreCardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //TODO: broken adding and saving stuff
    
    var descriptions = [String]()
    var maxValues = [String]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: String(describing: ScoreCardCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ScoreCardCell.self))
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ScoreCardCell.self), for: indexPath) as! ScoreCardCell
        
        cell.maxValue?.text = maxValues[indexPath.row]
        cell.userDescription?.text = descriptions[indexPath.row]
        descriptions.insert(cell.userDescription?.text ?? "", at: indexPath.row)
        maxValues.insert(cell.maxValue?.text ?? "", at: indexPath.row)
        
        //tableView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            descriptions.remove(at: indexPath.row)
            maxValues.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    @IBAction func didSelectAddCell(_ sender: Any){
        //broken
        descriptions.append("")
        maxValues.append("")
        tableView.reloadData()
    }
    
    @IBAction func didSelectCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didSelectCreateScoreCard(_ sender: Any) {
        
        
    }
}
