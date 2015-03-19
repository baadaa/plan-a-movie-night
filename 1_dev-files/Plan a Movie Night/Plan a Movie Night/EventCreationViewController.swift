//
//  EventCreationViewController.swift
//  Plan a Movie Night
//
//  Created by Bumhan Yu on 3/11/15.
//  Copyright (c) 2015 Angel, Bumhan, Matthew, and Vishnu. All rights reserved.
//

import UIKit

class EventCreationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inviteButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    // Navigation bar buttons
    
    
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var eventDescription: UITextField!
    @IBOutlet weak var eventLocation: UITextField!
    @IBOutlet weak var eventDateAndTime: UIButton!
    @IBOutlet weak var dateAndTime: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    // input fields
    
    
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        warningLabel.hidden = true
        // warning message is hidden by default
        
        datePicker.hidden = true
        // datePicker is hidden by default until button tapped
        datePicker.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        eventDateAndTime.titleLabel?.text = "Pick Schedule"
        
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
        // Navigation Bar "Back" button should always say "BACK"
    }
    
    @IBAction func cancelEvent(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            //
        })
    }
    
    @IBAction func inviteButtonTapped(sender: AnyObject) {
        
        
        // check if all TextFields are NOT empty and datePicker is NOT pointing to past date first. 
        
        if eventTitle.text != "" && eventDescription.text != "" && eventLocation.text != "" && datePicker.date.compare(NSDate()) != NSComparisonResult.OrderedAscending {
            
            let thisEventTitle = eventTitle.text
            let thisEventDescription = eventDescription.text
            let thisEventLocation = eventLocation.text
            let thisEventDate = datePicker.date
            // final event information to persist.
            
            //
            //
            //
            // Code block for persisting user input goes here
            // Persisting data should happen before moving to the next view
            //
            //
            //
            
            performSegueWithIdentifier("inviteFriendsWhenCreatingEvent", sender: nil)
            
        } else {
            datePicker.hidden = true
            warningLabel.hidden = false
            
        }
        
        
    }
    
    @IBAction func pickScheduleButtonTapped(sender: AnyObject) {
//        if datePicker.hidden == false {
//            self.view.endEditing(true)
//            datePicker.hidden = true
//        } else {
            self.view.endEditing(true)
            datePicker.hidden = false
            
//        }
    
        warningLabel.hidden = true
    }
    
    func datePickerChanged(datePicker:UIDatePicker) {
        
        warningLabel.hidden = true
        
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        println(datePicker.date)
        dateAndTime.text = strDate
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        warningLabel.hidden = true
    }
    
    
    func textFieldShouldReturn (textField: UITextField) -> Bool {
        switch textField{
        case eventTitle:
            if eventTitle.text != "" {
                textField.resignFirstResponder()
                eventDescription.becomeFirstResponder()
            }
        case eventDescription:
            if eventDescription.text != "" {
                textField.resignFirstResponder()
                eventLocation.becomeFirstResponder()
            }
        case eventLocation:
            if eventLocation.text != "" {
                textField.resignFirstResponder()
                self.view.endEditing(true)
                datePicker.becomeFirstResponder()
                pickScheduleButtonTapped(self.view)
            }
        default:
            println()
        }
        return true
    }
}
