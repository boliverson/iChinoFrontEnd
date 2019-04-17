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
   
    var events = [Event]()
    @IBOutlet weak var tableView: UITableView!
    var dataSource = CompetitionListViewController()
    var selectedIndex = 0
    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    var blurEffectView: UIVisualEffectView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: String(describing: EventCell.self), bundle: nil), forCellReuseIdentifier: String(describing: EventCell.self))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        events = EntityInteractor.getAllActiveEntities(entityName: "Event", context: context) as! [Event]
        
        NotificationCenter.default.addObserver(self, selector: #selector(showCompListVC(notification:)), name: .competitionsForEventDownloadedNotification, object: nil)
        
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
        cell.setUpCell(event: events[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedIndex = indexPath.row
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        startActivityIndicator(blur: blurEffectView, ai: activityIndicator)
        DispatchQueue.global(qos: .background).async {
            let DC = DownloadCompetition()
            DC.downloadCompetitionsForEvent(eventId: self.events[indexPath.row].serverKey)
        }
    }

    @objc func showCompListVC(notification: Notification) -> Void {
        
        DispatchQueue.main.async {
            self.stopActivityIndicator(blur: self.blurEffectView, ai: self.activityIndicator)
            let storyboard = UIStoryboard(name: "CompetitionAndScoreCard", bundle: nil)
            
            let controller = storyboard.instantiateViewController(withIdentifier: "CompetitionListViewController") as! CompetitionListViewController
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            controller.event = context.object(with: self.events[self.selectedIndex].objectID) as? Event
            
            self.present(controller, animated: true, completion: nil)
        }
    }
    
}
