//
//  Contact.swift
//  ContactsJBM
//
//  Created by Jason Mandozzi on 7/12/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import Foundation
import CloudKit

//Creating the Contact Class
class Contact {
    //Class Porperties
    var name: String
    var phoneNumber: Int
    var email: String
    //CloudKit Properties
    let ckRecordID: CKRecord.ID
    
    //Designated Initializer
    init(name: String, phoneNumber: Int, email: String, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.ckRecordID = ckRecordID
    }
    
    //Creating a Contact object from the Cloud
    convenience init?(ckRecord: CKRecord) {
        guard let name = ckRecord[ContactConstants.nameKey] as? String,
        let phoneNumber = ckRecord[ContactConstants.phoneNumberKey] as? Int,
            let email = ckRecord[ContactConstants.email] as? String else {return nil}
        self.init(name: name, phoneNumber: phoneNumber, email: email, ckRecordID: ckRecord.recordID)
    }
}

//Creating a record from our Contact to send to the cloud
extension CKRecord {
    convenience init(contact: Contact) {
        self.init(recordType: ContactConstants.TypeKey, recordID: contact.ckRecordID)
        self.setValue(contact.name, forKey: ContactConstants.nameKey)
        self.setValue(contact.phoneNumber, forKey: ContactConstants.phoneNumberKey)
        self.setValue(contact.email, forKey: ContactConstants.email)
    }
}

//Magic Strings - Keys
struct ContactConstants {
    static let TypeKey = "Contact"
    static let nameKey = "name"
    static let phoneNumberKey = "phoneNumber"
    static let email = "email"
}
