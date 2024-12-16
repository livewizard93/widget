//
//  ViewController.swift
//  WidgetSample
//
//  Created by dev on 12/15/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let helper = DBHelper()
        let data = helper.read(month: 11, day: 14)
        print("data: \(data)")
    }
    
    func insertData(helper: DBHelper) {
        helper.insert(
            id: "28bbe674-2134-43c2-8ee7-2bf0077d7a86",
            user_id: "24e2c6d9-1159-4a66-8da2-2eed954181c8",
            created_at: "2024-12-10 21:56:20",
            modified_at: "2024-12-10 21:56:20",
            synced_at: "",
            category: "Birthday",
            kind_alias: "GenericBirthday",
            subkind: "",
            calendar_id: "",
            calendar_event_id: "",
            derived_from_id: "",
            person_id: "73f2560c-f34d-4bd9-8196-c91a894fa0f4",
            date: Date(),
            day: 14,
            month: 11,
            year_of_birth: 2018,
            first_name: "Martin",
            last_name: "",
            nickname: "",
            relationship: "",
            photo_uri: "",
            gender: "unknown",
            action_alias: "None",
            action_registered_at: "",
            action_completed_at: "",
            action_metadata: ""
        )
    }
}

