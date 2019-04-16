//
//  EventsListViewController.swift
//  JudgementDay
//
//  Created by Mackenzie Hampel on 4/4/19.
//  Copyright © 2019 Weber State. All rights reserved.
//
import UIKit
import Foundation
class EventsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var events = [ "A", "B"]
    @IBOutlet weak var tableView: UITableView!
    var dataSource = CompetitionListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: String(describing: EventCell.self), bundle: nil), forCellReuseIdentifier: String(describing: EventCell.self))
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
 
    @IBAction func didSelectBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
          let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventCell.self), for: indexPath) as! EventCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //for that event load competitions that are associated and then segue
        //self.dataSource.competitions = getCompetitionsForEvent(event: events[indexPath.row])
     //   performSegue(withIdentifier: "CompetitionListViewController", sender: self)
        
        let storyboard = UIStoryboard(name: "CompetitionAndScoreCard", bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "CompetitionListViewController") as! CompetitionListViewController
        self.present(controller, animated: true, completion: nil)
       // self.navigationController?.pushViewController(controller, animated: true)
        
    }

    //TODO: return all competitions
    
}
