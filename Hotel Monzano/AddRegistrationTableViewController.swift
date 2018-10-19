//
//  AddRegistrationTableViewController.swift
//  Hotel Monzano
//
//  Created by Татьяна on 18.10.2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var chekInDateLabel: UILabel!
    @IBOutlet weak var chekInDatePicker: UIDatePicker!
    @IBOutlet weak var chekOutDateLabel: UILabel!
    @IBOutlet weak var chekOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var adultsLabel: UILabel!
    @IBOutlet weak var adultsStepper: UIStepper!
    @IBOutlet weak var childrenStepper: UIStepper!
    @IBOutlet weak var childrenLabel: UILabel!
    
    @IBOutlet weak var wiFiLabel: UILabel!
    @IBOutlet weak var wiFiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel!

    var adultsCounter: Int = 2
    var childrenCounter: Int = 1
    var roomType:RoomType? {
        didSet {
            if let roomType = roomType {
                roomTypeLabel.text = roomType.shortName
            } else {
                roomTypeLabel.text = "не установлен"
            }
        }
    }
    
    var roomTypes: [RoomType] = []
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)

    var isCheckInDatePickerShow: Bool = false {
        didSet {
            chekInDatePicker.isHidden = !isCheckInDatePickerShow
        }
    }
    
    var isCheckOutDatePickerShow: Bool = false {
        didSet {
            chekOutDatePicker.isHidden = !isCheckOutDatePickerShow
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        chekInDatePicker.minimumDate = midnightToday
        chekInDatePicker.date = midnightToday
        
        wiFiSwitch.isOn = false
        wiFiLabel.isHidden = true
        
        roomType = nil
        
        updateDateViews()
        updatePeopleViews()
        
        roomTypes = RoomType.createRooms()
    }
    
    func updateDateViews()  {
        chekOutDatePicker.minimumDate = chekInDatePicker.date.addingTimeInterval(60 * 60 * 24)
        
        let dateFarmatter = DateFormatter()
        dateFarmatter.dateStyle = .medium
        
        chekInDateLabel.text = dateFarmatter.string(from: chekInDatePicker.date)
        chekOutDateLabel.text = dateFarmatter.string(from: chekOutDatePicker.date)
        
    }
    
    func updatePeopleViews() {
        adultsStepper.value = Double(adultsCounter)
        childrenStepper.value = Double(childrenCounter)
        
        adultsLabel.text = Int(adultsStepper.value).description
        childrenLabel.text = Int(childrenStepper.value).description
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            if isCheckInDatePickerShow {
                return 216
            } else {
                return 0
            }
        case checkOutDatePickerCellIndexPath:
            if isCheckOutDatePickerShow {
                return 216
            } else {
                return 0
            }
        default:
            return 44
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row - 1):
            if isCheckInDatePickerShow {
                isCheckInDatePickerShow = false
            } else if isCheckOutDatePickerShow {
                isCheckOutDatePickerShow = false
                isCheckInDatePickerShow = true
            } else {
                isCheckInDatePickerShow = true
            }
            
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row - 1):
            if isCheckOutDatePickerShow {
                isCheckOutDatePickerShow = false
            } else if isCheckInDatePickerShow {
                isCheckInDatePickerShow = false
                isCheckOutDatePickerShow = true
            } else {
                isCheckOutDatePickerShow = true
            }
        default:
            isCheckInDatePickerShow = false
            isCheckOutDatePickerShow = false
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        if indexPath.section == 4 {
            performSegue(withIdentifier: "showRoomType", sender: roomTypes)
        }
        

    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = chekInDatePicker.date
        let checkOutDate = chekOutDatePicker.date
        let adults = adultsLabel.text ?? ""
        let children = childrenLabel.text ?? ""
        let wifi = wiFiSwitch.isOn ? "wi-fi нужен ($10)" : "Без wi-fi"
        
        print(firstName)
        print(lastName)
        print(email)
        print(checkInDate)
        print(checkOutDate)
        print(adults)
        print(children)
        print(wifi)
        print(roomType?.shortName ?? "Тип комнаты не выбран")

    }
    
    
    @IBAction func datePickerValueChanger(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    
    @IBAction func oneClickerAdultsSteppre(sender: UIStepper) {
        adultsCounter = Int(sender.value)
        adultsLabel.text = adultsCounter.description
    }

    
    @IBAction func oneClickerChildrenSteppre(sender: UIStepper) {
        childrenCounter = Int(sender.value)
        childrenLabel.text = childrenCounter.description
    }
    
    @IBAction func wiFiSwitchTapped(sender: UISwitch) {
        self.view.endEditing(true)
        wiFiLabel.isHidden = !sender.isOn
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if segue.identifier == "showRoomType",
            let roomTypes = sender as? [RoomType] {
            let nc = segue.destination as! UINavigationController
            let vc = nc.topViewController as! RoomListTableViewController
            
            vc.roomTypes = roomTypes
        }
    }
    
    @IBAction func unwindToRegistrationTable(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindShowRoomType",
            let sourceVC = segue.source as? RoomListTableViewController,
            let selectedRow = sourceVC.tableView.indexPathForSelectedRow?.row
            else { return }
        
        roomType = roomTypes[selectedRow]
        
        
    }
 
    @IBAction func endEditTextField(_ sender: UITextField) {
        self.view.endEditing(true)
    }
}
