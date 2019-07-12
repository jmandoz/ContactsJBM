//
//  CloudKitController.swift
//  ContactsJBM
//
//  Created by Jason Mandozzi on 7/12/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import Foundation
import CloudKit

//creating a CloudKitController to organize code and reduce the ammount of clutter in the Controller
class CloudKitController {
    //shared instance
    static let shared = CloudKitController()
    
    //update record CloudKit function
    func update(record: CKRecord, database: CKDatabase, completion: @escaping (Bool) -> Void) {
        let operation = CKModifyRecordsOperation()
        operation.recordsToSave = [record]
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        operation.queuePriority = .high
        operation.completionBlock = {
            completion(true)
        }
        database.add(operation)
    }
}
