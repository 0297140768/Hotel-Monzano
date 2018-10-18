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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        let fitstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
    }
}
