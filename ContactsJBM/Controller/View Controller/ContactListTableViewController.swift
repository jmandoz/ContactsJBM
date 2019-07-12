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
        ContactController.shared.fetchAllContacts { (success) in
            //Fetches the Contacts upon load
            self.updateViews()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    
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
