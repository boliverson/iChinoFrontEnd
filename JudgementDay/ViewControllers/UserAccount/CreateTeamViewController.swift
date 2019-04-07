//
//  CreateTeamViewController.swift
//  JudgementDay
//
//  Created by Mackenzie Hampel on 4/6/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import Foundation
import UIKit

class CreateTeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var teamMembers =  ["A", "B", "C"]//[String]()
    var registeredParticipants = ["D", "E", "F"]//[String]()
    @IBOutlet weak var tableViewTeam: UITableView!
    
    @IBOutlet weak var tableViewRegisteredParticipants: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //Could not load NIB in bundle: 'NSBundle' with name
        tableViewTeam.register(UINib(nibName: String(describing: TeamMemberCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TeamMemberCell.self))
        tableViewRegisteredParticipants.register(UINib(nibName: String(describing: RegisteredParticipantCell.self), bundle: nil), forCellReuseIdentifier: String(describing: RegisteredParticipantCell.self))
        
        self.tableViewRegisteredParticipants.delegate = self
        self.tableViewRegisteredParticipants.dataSource = self
        self.tableViewTeam.delegate = self
        self.tableViewTeam.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableViewTeam {
            return teamMembers.count
        } else {
            return registeredParticipants.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableViewTeam {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TeamMemberCell.self), for: indexPath) as! TeamMemberCell
            
            
            //tableView.reloadData()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RegisteredParticipantCell.self), for: indexPath) as! RegisteredParticipantCell
            
          
            //tableView.reloadData()
            return cell
        }
    }
    
}
