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
    }
 
    @IBAction func didSelectBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = events[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //for that event load competitions that are associated and then segue
        //
        //self.dataSource.competitions = getCompetitionsForEvent(event: events[indexPath.row])
     //   performSegue(withIdentifier: "CompetitionListViewController", sender: self)
        
    }

    //TODO: return all competitions
    
}
