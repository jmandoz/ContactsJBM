//
//  ContactListTableViewController.swift
//  ContactsJBM
//
//  Created by Jason Mandozzi on 7/12/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       updateViews(completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    //function for updating the views to the main thread
    func updateViews(completion: ((Bool) -> Void)?) {
        ContactController.shared.fetchAllContacts { (contacts) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                completion?(contacts != nil)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactController.shared.contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        let contact = ContactController.shared.contacts[indexPath.row]
        cell.textLabel?.text = contact.name
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let destinationVC = segue.destination as? ContactDetailViewController
            let contact = ContactController.shared.contacts[indexPath.row]
            destinationVC?.contact = contact
        }
    }
}
