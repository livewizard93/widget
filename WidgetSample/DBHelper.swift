//
//  DBHelper.swift
//  WidgetSample
//
//  Created by dev on 12/15/24.
//

import Foundation
import SQLite3

class DBHelper
{
    init()
    {
        db = openDatabase()
//        dropTable()
        createTable()
//        insertData()
    }

    let dbPath: String = "celebrations.db"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE celebrations (id text PRIMARY KEY NOT NULL, user_id text NOT NULL, created_at text DEFAULT CURRENT_TIMESTAMP, modified_at text DEFAULT CURRENT_TIMESTAMP, synced_at text, category text NOT NULL DEFAULT 'Birthday', kind_alias text NOT NULL DEFAULT 'None', subkind text, calendar_id text, calendar_event_id text, derived_from_id text, person_id text NOT NULL, date Date, day integer, month integer, year_of_birth integer, first_name text NOT NULL, last_name text, nickname text, relationship text DEFAULT Null, photo_uri text, gender text NOT NULL DEFAULT 'unknown', action_alias text NOT NULL DEFAULT 'None', action_registered_at text, action_completed_at text, action_metadata text DEFAULT '{}');"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("celebration table created.")
            } else {
                print("celebration table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func dropTable() {
        let dropTableString = "DROP TABLE celebrations;"
        var dropTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, dropTableString, -1, &dropTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(dropTableStatement) == SQLITE_DONE
            {
                print("celebration table dropped.")
            } else {
                print("celebration table could not be dropped.")
            }
        } else {
            print("DROP TABLE statement could not be prepared.")
        }
        sqlite3_finalize(dropTableStatement)
    }
    
    func insert(
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
        let persons = read()
        for p in persons
        {
            if p.id == id
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO celebrations (id, user_id, created_at, modified_at, synced_at, category, kind_alias, subkind, calendar_id, calendar_event_id, derived_from_id, person_id, date, day, month, year_of_birth, first_name, last_name, nickname, relationship, photo_uri, gender, action_alias, action_registered_at, action_completed_at, action_metadata) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (id as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (user_id as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (created_at as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (modified_at as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (synced_at as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (category as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (kind_alias as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (subkind as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 9, (calendar_id as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 10, (calendar_event_id as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 11, (derived_from_id as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 12, (person_id as NSString).utf8String, -1, nil)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = formatter.string(from: date)
            sqlite3_bind_text(insertStatement, 13, (dateString as NSString).utf8String, -1, nil)
            
            sqlite3_bind_int(insertStatement, 14, Int32(day))
            sqlite3_bind_int(insertStatement, 15, Int32(month))
            sqlite3_bind_int(insertStatement, 16, Int32(year_of_birth))
            sqlite3_bind_text(insertStatement, 17, (first_name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 18, (last_name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 19, (nickname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 20, (relationship as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 21, (photo_uri as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 22, (gender as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 23, (action_alias as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 24, (action_registered_at as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 25, (action_completed_at as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 26, (action_metadata as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                let errmsg = String(cString: sqlite3_errmsg(db))

                print("Could not insert row. \(errmsg)")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [Celebration] {
        let queryStatementString = "SELECT * FROM celebrations";
        var queryStatement: OpaquePointer? = nil
        var list : [Celebration] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let user_id = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let created_at = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let modified_at = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let synced_at = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let category = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let kind_alias = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let subkind = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                let calendar_id = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
                let calendar_event_id = String(describing: String(cString: sqlite3_column_text(queryStatement, 9)))
                let derived_from_id = String(describing: String(cString: sqlite3_column_text(queryStatement, 10)))
                let person_id = String(describing: String(cString: sqlite3_column_text(queryStatement, 11)))
                let dateString = String(describing: String(cString: sqlite3_column_text(queryStatement, 12)))
                let dayValue = sqlite3_column_int(queryStatement, 13)
                let monthValue = sqlite3_column_int(queryStatement, 14)
                let year_of_birth = sqlite3_column_int(queryStatement, 15)
                let first_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 16)))
                let last_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 17)))
                let nickname = String(describing: String(cString: sqlite3_column_text(queryStatement, 18)))
                let relationship = String(describing: String(cString: sqlite3_column_text(queryStatement, 19)))
                let photo_uri = String(describing: String(cString: sqlite3_column_text(queryStatement, 20)))
                let gender = String(describing: String(cString: sqlite3_column_text(queryStatement, 21)))
                let action_alias = String(describing: String(cString: sqlite3_column_text(queryStatement, 22)))
                let action_registered_at = String(describing: String(cString: sqlite3_column_text(queryStatement, 23)))
                let action_completed_at = String(describing: String(cString: sqlite3_column_text(queryStatement, 24)))
                let action_metadata = String(describing: String(cString: sqlite3_column_text(queryStatement, 25)))

                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date = formatter.date(from: dateString)
                
                list.append(
                    Celebration(
                        id: id,
                        user_id: user_id,
                        created_at: created_at,
                        modified_at: modified_at,
                        synced_at: synced_at,
                        category: category,
                        kind_alias: kind_alias,
                        subkind: subkind,
                        calendar_id: calendar_id,
                        calendar_event_id: calendar_event_id,
                        derived_from_id: derived_from_id,
                        person_id: person_id,
                        date: date!,
                        day: Int(dayValue),
                        month: Int(monthValue),
                        year_of_birth: Int(year_of_birth),
                        first_name: first_name,
                        last_name: last_name,
                        nickname: nickname,
                        relationship: relationship,
                        photo_uri: photo_uri,
                        gender: gender,
                        action_alias: action_alias,
                        action_registered_at: action_registered_at,
                        action_completed_at: action_completed_at,
                        action_metadata: action_metadata
                    )
                )
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return list
    }
//    
//    func deleteByID(id:Int) {
//        let deleteStatementStirng = "DELETE FROM person WHERE Id = ?;"
//        var deleteStatement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
//            sqlite3_bind_int(deleteStatement, 1, Int32(id))
//            if sqlite3_step(deleteStatement) == SQLITE_DONE {
//                print("Successfully deleted row.")
//            } else {
//                print("Could not delete row.")
//            }
//        } else {
//            print("DELETE statement could not be prepared")
//        }
//        sqlite3_finalize(deleteStatement)
//    }
    
    func readTodayData(date: Date) -> (note: String, photo: String){
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
        
        print("month = \(calendarDate.month!)")
        print("day = \(calendarDate.day!)")
        
        let queryStatementString = "SELECT * FROM celebrations WHERE month=\(calendarDate.month!) AND day=\(calendarDate.day!);";
        var queryStatement: OpaquePointer? = nil
        var list : [Celebration] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let user_id = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let created_at = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let modified_at = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let synced_at = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let category = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let kind_alias = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let subkind = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                let calendar_id = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
                let calendar_event_id = String(describing: String(cString: sqlite3_column_text(queryStatement, 9)))
                let derived_from_id = String(describing: String(cString: sqlite3_column_text(queryStatement, 10)))
                let person_id = String(describing: String(cString: sqlite3_column_text(queryStatement, 11)))
                let dateString = String(describing: String(cString: sqlite3_column_text(queryStatement, 12)))
                let dayValue = sqlite3_column_int(queryStatement, 13)
                let monthValue = sqlite3_column_int(queryStatement, 14)
                let year_of_birth = sqlite3_column_int(queryStatement, 15)
                let first_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 16)))
                let last_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 17)))
                let nickname = String(describing: String(cString: sqlite3_column_text(queryStatement, 18)))
                let relationship = String(describing: String(cString: sqlite3_column_text(queryStatement, 19)))
                let photo_uri = String(describing: String(cString: sqlite3_column_text(queryStatement, 20)))
                let gender = String(describing: String(cString: sqlite3_column_text(queryStatement, 21)))
                let action_alias = String(describing: String(cString: sqlite3_column_text(queryStatement, 22)))
                let action_registered_at = String(describing: String(cString: sqlite3_column_text(queryStatement, 23)))
                let action_completed_at = String(describing: String(cString: sqlite3_column_text(queryStatement, 24)))
                let action_metadata = String(describing: String(cString: sqlite3_column_text(queryStatement, 25)))

                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date = formatter.date(from: dateString)
                
                list.append(
                    Celebration(
                        id: id,
                        user_id: user_id,
                        created_at: created_at,
                        modified_at: modified_at,
                        synced_at: synced_at,
                        category: category,
                        kind_alias: kind_alias,
                        subkind: subkind,
                        calendar_id: calendar_id,
                        calendar_event_id: calendar_event_id,
                        derived_from_id: derived_from_id,
                        person_id: person_id,
                        date: date!,
                        day: Int(dayValue),
                        month: Int(monthValue),
                        year_of_birth: Int(year_of_birth),
                        first_name: first_name,
                        last_name: last_name,
                        nickname: nickname,
                        relationship: relationship,
                        photo_uri: photo_uri,
                        gender: gender,
                        action_alias: action_alias,
                        action_registered_at: action_registered_at,
                        action_completed_at: action_completed_at,
                        action_metadata: action_metadata
                    )
                )
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        
        // Prepare Data.
        var note = ""
        var photo = ""
        
        if list.count > 0 {
            list.forEach { item in
                if item.category == "Birthday" {
                    note += "🥳 \(item.first_name) - birthday\r\n"
                }
                else if item.category == "Nameday" {
                    note += "🥳 \(item.first_name) - name day\r\n"
                }
                
                if item.photo_uri.count > 0 {
                    photo = item.photo_uri
                }
            }
        }
        
        print("note = \(note)")
        print("photo = \(photo)")
        return (note, photo)
    }
    
    func insertData() {
        insert(
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
        insert(
            id: "406d3ba6-9540-4805-a75e-c04fa6f11deb",
            user_id: "24e2c6d9-1159-4a66-8da2-2eed954181c8",
            created_at: "2024-12-10 21:57:06",
            modified_at: "2024-12-10 21:57:06",
            synced_at: "",
            category: "Birthday",
            kind_alias: "FamilyMemberBirthday",
            subkind: "Son",
            calendar_id: "",
            calendar_event_id: "",
            derived_from_id: "",
            person_id: "ff57964d-5b8c-456b-834e-4c4d9cca6deb",
            date: Date(),
            day: 16,
            month: 12,
            year_of_birth: 2002,
            first_name: "Tobias",
            last_name: "",
            nickname: "",
            relationship: "Son",
            photo_uri: "https://picsum.photos/id/582/600/300",
            gender: "unknown",
            action_alias: "None",
            action_registered_at: "",
            action_completed_at: "",
            action_metadata: ""
        )
        insert(
            id: "70d358d7-3e52-4600-b6c8-027b5de4160e",
            user_id: "24e2c6d9-1159-4a66-8da2-2eed954181c8",
            created_at: "2024-12-11 10:19:25",
            modified_at: "2024-12-11 10:19:25",
            synced_at: "",
            category: "Nameday",
            kind_alias: "NameDay",
            subkind: "Son",
            calendar_id: "",
            calendar_event_id: "",
            derived_from_id: "",
            person_id: "ff57964d-5b8c-456b-834e-4c4d9cca6deb",
            date: Date(),
            day: 16,
            month: 12,
            year_of_birth: 2002,
            first_name: "Sarah",
            last_name: "",
            nickname: "",
            relationship: "Son",
            photo_uri: "https://picsum.photos/id/64/600/300",
            gender: "unknown",
            action_alias: "None",
            action_registered_at: "",
            action_completed_at: "",
            action_metadata: ""
        )
    }
}
