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
    @IBOutlet weak var btnCreateComp: UIButton!
    @IBOutlet weak var btnUsersComp: UIButton!
    @IBOutlet weak var btnCreateEvent: UIView!
    
    @IBOutlet weak var UserEmailTxt: UILabel!
    @IBOutlet weak var UserFirstNameTxt: UILabel!
    @IBOutlet weak var UserLastNameTxt: UILabel!
    @IBOutlet weak var lblNameHeader: UILabel!
    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    var blurEffectView: UIVisualEffectView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentUser != nil {
            UserEmailTxt.text = currentUser?.email
            UserFirstNameTxt.text = currentUser?.firstName
            UserLastNameTxt.text = currentUser?.lastName
            lblNameHeader.text =
                currentUser?.firstName
        }
        NotificationCenter.default.addObserver(self, selector: #selector(showEventListVC), name: .eventAllActiveDownloadedNotification, object: nil)
    }

    @IBAction func didClickSearchEvents(_ sender: Any) {
        //Put the request in the background and show the activity indicator
        //Download all active events and then show EventsListViewController
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        startActivityIndicator(blur: blurEffectView, ai: activityIndicator)
        DispatchQueue.global(qos: .background).async {
            let DE = DownloadEvent()
            DE.downloadActiveEvents()
        }
    }
    
    @IBAction func didClickCreateEvent(_ sender: Any) {
    }
    
    @IBAction func didClickYourCompetitions(_ sender: Any) {
    }
    
    @objc func showEventListVC() -> Void {
        DispatchQueue.main.async {
            self.stopActivityIndicator(blur: self.blurEffectView, ai: self.activityIndicator)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "EventsList") as! EventsListViewController
            self.present(controller, animated: true, completion: nil)
        }
    }
}
