//
//  CelebrationRecord.swift
//  WidgetSample
//
//  Created by dev on 12/15/24.
//

import Foundation

class Celebration {
    var id: String = ""
    var user_id: String = ""
    var created_at: String = ""
    var modified_at: String = ""
    var synced_at: String = ""
    var category: String = ""
    var kind_alias: String = ""
    var subkind: String = ""
    var calendar_id: String = ""
    var calendar_event_id: String = ""
    var derived_from_id: String = ""
    var person_id: String = ""
    var date: Date = Date()
    var day: Int = 0
    var month: Int = 0
    var year_of_birth: Int = 0
    var first_name: String = ""
    var last_name: String = ""
    var nickname: String = ""
    var relationship: String = ""
    var photo_uri: String = ""
    var gender: String = ""
    var action_alias: String = ""
    var action_registered_at: String = ""
    var action_completed_at: String = ""
    var action_metadata: String = ""
    
    init(
        id: String,
        user_id: String,
        created_at: String,
        modified_at: String,
        synced_at: String,
        category: String,
        kind_alias: String,
        subkind: String,
        calendar_id: String,
        calendar_event_id: String,
        derived_from_id: String,
        person_id: String,
        date: Date,
        day: Int,
        month: Int,
        year_of_birth: Int,
        first_name: String,
        last_name: String,
        nickname: String,
        relationship: String,
        photo_uri: String,
        gender: String,
        action_alias: String,
        action_registered_at: String,
        action_completed_at: String,
        action_metadata: String
    )
    {
        self.id = id
        self.user_id = user_id
        self.created_at = created_at
        self.modified_at = modified_at
        self.synced_at = synced_at
        self.category = category
        self.kind_alias = kind_alias
        self.subkind = subkind
        self.calendar_id = calendar_id
        self.calendar_event_id = calendar_event_id
        self.derived_from_id = derived_from_id
        self.person_id = person_id
        self.date = date
        self.day = day
        self.month = month
        self.year_of_birth = year_of_birth
        self.first_name = first_name
        self.last_name = last_name
        self.nickname = nickname
        self.relationship = relationship
        self.photo_uri = photo_uri
        self.gender = gender
        self.action_alias = action_alias
        self.action_registered_at = action_registered_at
        self.action_completed_at = action_completed_at
        self.action_metadata = action_metadata
    }
}
