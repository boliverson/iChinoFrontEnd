//
//  CreateEventViewController.swift
//  JudgementDay
//
//  Created by Mackenzie Hampel on 4/10/19.
//  Copyright © 2019 Weber State. All rights reserved.
//

import UIKit
import CoreData
import SwiftyPickerPopover

class CreateEventViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var creatEventView: UIView!
    @IBOutlet weak var whenHeight2: NSLayoutConstraint!
    //  @IBOutlet weak var whenHeight: NSLayoutConstraint!
    @IBOutlet weak var whereHeight: NSLayoutConstraint!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    var blurEffectView: UIVisualEffectView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    var startDate: Date?
    var endDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //  self.txtLastName.delegate = self
        self.txtStartDate.delegate = self
        
    }
    @IBAction func didSelectCreate(_ sender: Any) {
        if txtName.text != "" && txtLocation.text != "" && txtStartDate.text != "" && txtEndDate.text != ""{
            blurEffectView = UIVisualEffectView(effect: blurEffect)
            startActivityIndicator(blur: blurEffectView, ai: activityIndicator)
            DispatchQueue.global(qos: .background).async {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let event = Event.init(entity: NSEntityDescription.entity(forEntityName: "Event", in: context)!, insertInto: context)
                event.name = self.txtName.text
                event.location = self.txtLocation.text
                event.startDate = self.startDate as NSDate?
                event.endDate = self.endDate as NSDate?
                
                do {
                    try context.save()
                } catch{
                    print("Unexpected error: \(error).")
                }
                
                event.syncWithServer()
                DispatchQueue.main.async {
                    self.stopActivityIndicator(blur: self.blurEffectView, ai: self.activityIndicator)
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        } else {
            let alert = UIAlertController(title: "Almost There", message: "Please fill out all fields to create an event.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func didSelectCancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.whereHeight.constant = 64.0
        self.creatEventView.isHidden = false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.whereHeight.constant = 64.0
        self.creatEventView.isHidden = false
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
     
        if(self.txtStartDate == textField) {
            textField.resignFirstResponder()
            let datePicker = DatePickerPopover(title: "Event Start Date")
                .setDateMode(.dateAndTime)
                .setSelectedDate(Date())
                .setDoneButton(action: {popover, selectedDate in
                    let dateFormat = DateFormatter()
                    dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
                    self.startDate = dateFormat.date(from: String(describing: selectedDate))
                    dateFormat.dateFormat = "MMM d, yyyy - h:mm a"
                    self.txtStartDate.text = dateFormat.string(from: self.startDate!)
                })
            datePicker.appear(originView: textField, baseViewController: self)
        } else if(self.txtEndDate == textField){
            textField.resignFirstResponder()
            let datePicker = DatePickerPopover(title: "Event End Date")
                .setDateMode(.dateAndTime)
                .setSelectedDate(Date())
                .setDoneButton(action: {popover, selectedDate in
                    let dateFormat = DateFormatter()
                    dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
                    self.endDate = dateFormat.date(from: String(describing: selectedDate))
                    dateFormat.dateFormat = "MMM d, yyyy - h:mm a"
                    self.txtEndDate.text = dateFormat.string(from: self.endDate!)
                })
            datePicker.appear(originView: textField, baseViewController: self)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
     if(self.txtStartDate == textField) {
            //self.whenHeight2.constant = 64.0
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    
}
