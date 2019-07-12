//
//  ContactController.swift
//  ContactsJBM
//
//  Created by Jason Mandozzi on 7/12/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    //Declare the database
    let privateDB = CKContainer.default().privateCloudDatabase
    
    //Shared Instance
    static let shared = ContactController()
    
    //Source of Truth
    var contacts: [Contact] = []
    
//MARK: -CRUD
    //Create a contact
    func createContact(name: String, phoneNumber: Int, email: String, completion: @escaping (Contact?) -> Void) {
        //Create a new contact
        let newContact = Contact(name: name, phoneNumber: phoneNumber, email: email)
        //Create our CKRecord
        let newRecord = CKRecord(contact: newContact)
        //save to our privateDB
        privateDB.save(newRecord) { (record, error) in
            //handle the error
            if let error = error {
                print("Error saving the record : \(error.localizedDescription)")
                completion(nil)
                return
            }
            //unwrapping the saved record
            guard let record = record else {return}
            //unwrapping and recreating our contact the was saved
            guard let contact = Contact(ckRecord: record) else {completion(nil) ; return}
            //append to our SOT only once we've confirmed that it's been saved correctly
            self.contacts.append(contact)
            //complete with contact
            completion(contact)
        }
    }
    //Read (fetch) contacts
    func fetchAllContacts(completion: @escaping ([Contact]?) -> Void) {
        //predicate for our query for our perform function
        let predicate = NSPredicate(value: true)
        //query for our perform function
        let query = CKQuery(recordType: ContactConstants.TypeKey, predicate: predicate)
        //performing the fetch from the DB
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            //handle the error
            if let error = error {
                print("Error fetching the records: \(error.localizedDescription)")
                completion(nil)
                return
            }
            //unwrapping our records
            guard let records = records else {completion(nil) ; return}
            //iterate through the array of contacts
            let contacts: [Contact] = records.compactMap({Contact(ckRecord: $0)})
            //set our SOT to our fetched contacts
            self.contacts = contacts
            //complete with contacts
            completion(contacts)
        }
    }
    //Update contacts
    func updateContact(contact: Contact, name: String, phoneNumber: Int, email: String) {
        contact.name = name
        contact.phoneNumber = phoneNumber
        contact.email = email
        
        let recordToSave = CKRecord(contact: contact)
        CloudKitController.shared.update(record: recordToSave, database: privateDB) { (success) in
            if success {
                print("updates Contact succesfully")
            }
        }
    }
}
