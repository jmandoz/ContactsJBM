//
//  ContactDetailViewController.swift
//  ContactsJBM
//
//  Created by Jason Mandozzi on 7/12/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    //landing pad
    var contact: Contact? {
        didSet {
            loadViewIfNeeded()
            guard let contact = contact else {return}
            nameTextField.text = contact.name
            phoneNumberTextField.text = "\(contact.phoneNumber)"
            emailTextField.text = contact.email
        }
    }
    
    //Text Field Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Button Action
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
            let phoneNumber = Int(phoneNumberTextField.text ?? ""),
            let email = emailTextField.text else {return}
        if let contact = contact {
            ContactController.shared.updateContact(contact: contact, name: name, phoneNumber: phoneNumber, email: email)
        } else {
            ContactController.shared.createContact(name: name, phoneNumber: phoneNumber, email: email) { (_) in
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}
