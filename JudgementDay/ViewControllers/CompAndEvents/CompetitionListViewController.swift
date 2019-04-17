//
//  CompetitionListViewController.swift
//  JudgementDay
//
//  Created by Mackenzie Hampel on 4/4/19.
//  Copyright © 2019 Weber State. All rights reserved.
//
import UIKit
import Foundation
class CompetitionListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var startDateTime: UILabel!
    @IBOutlet weak var endDateTime: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var competitions = [Competition]()
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: String(describing: CompetitionCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CompetitionCell.self))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        competitions = EntityInteractor.getAllCompetitionsForEvent(eventID: String(describing: event?.serverKey), context: context) as! [Competition]
        
        setUpUI()
    }
    
    func setUpUI() -> Void {
        eventName.text = event?.name != nil ? event?.name : ""
        location.text = event?.location != nil ? event?.location : ""
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM d, yyyy - h:mm a"
        startDateTime.text = event?.startDate != nil ? dateFormat.string(from: event?.startDate! as Date? ?? Date()) : ""
        endDateTime.text = event?.endDate != nil ? dateFormat.string(from: event?.endDate! as Date? ?? Date()) : ""
    }
    @IBAction func didSelectBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func didSelectCreateComp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "CompetitionAndScoreCard", bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "CreateCompetitionViewController") as! CreateCompetitionViewController
        controller.event = self.event
        
        self.present(controller, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CompetitionCell.self), for: indexPath) as! CompetitionCell
        cell.selectionStyle = .none
        cell.setUpCell(comp: competitions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //TODO: user selects row and then maybe an alert view popsup and say would you like to register as a competitior a judge or nevermind
        let alertController = UIAlertController(title: title, message: "How would you like to register for this competition?", preferredStyle:UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "As Judge", style: UIAlertAction.Style.default)
        { action -> Void in
            // Put your code here //registers user as judge for that competition at that indexpath.row
        })
        
        alertController.addAction(UIAlertAction(title: "As Competitor", style: UIAlertAction.Style.default)
        { action -> Void in
            // Put your code here //registers user as competitor for that competition at that indexpath.row
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default)
        { action -> Void in
            // Put your code here //does nothing dismiss alert
        })
        self.present(alertController, animated: true, completion: nil)

        
    }
    //TODO: return all competitions
    
}
