//
//  ProfileDataHelper.swift
//  ContactMe
//
//  Created by royli on 05/12/2019.
//  Copyright © 2019 IPL-Master. All rights reserved.
//

import Foundation
import SQLite

class ProfileDataHelper: DataHelperProtocol {
    
    static let TABLE_NAME = "Profiles"
    
    static let table = Table(TABLE_NAME)
    static let dbId = Expression<Int64>("id")
    static let dbName = Expression<String?>("name")
    static let dbLastName = Expression<String?>("lastname")
    static let dbPhone = Expression<String?>("phone")
    static let dbDateOfBirth = Expression<String?>("dateofbirth")
    static let dbGender = Expression<String?>("gender")
    static let dbCarieer = Expression<String?>("carieer")
    static let dbJob = Expression<String?>("job")
    static let dbInsterest = Expression<String?>("insterest")
    static let dbAvatar = Expression<String?>("avatar")
    static let dbMondayFreeStartTime = Expression<String?>("mondayFreeStartTime")
    static let dbMondayFreeEndTime = Expression<String?>("mondayFreeEndTime")
    static let dbTuesdayFreeStartTime = Expression<String?>("tuesdayFreeStartTime")
    static let dbTuesdayFreeEndTime = Expression<String?>("tuesdayFreeEndTime")
    static let dbWednesdayFreeStartTime = Expression<String?>("wednesdayFreeStartTime")
    static let dbWednesdayFreeEndTime = Expression<String?>("wednesdayFreeEndTime")
    static let dbThursdayFreeStartTime = Expression<String?>("thursdayFreeStartTime")
    static let dbThursdayFreeEndTime = Expression<String?>("thursdayFreeEndTime")
    static let dbFridayFreeStartTime = Expression<String?>("fridayFreeStartTime")
    static let dbFridayFreeEndTime = Expression<String?>("fridayFreeEndTime")
    static let dbSaturdayFreeStartTime = Expression<String?>("saturdayFreeStartTime")
    static let dbSaturdayFreeEndTime = Expression<String?>("saturdayFreeEndTime")
    static let dbSundayFreeStartTime = Expression<String?>("sundayFreeStartTime")
    static let dbSundayFreeEndTime = Expression<String?>("sundayFreeEndTime")
    static let dbConnectionId = Expression<Int64>("connectionId")
    
    
    
    typealias T = Profile
    
    static func createTable() throws {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        do {
            let _ = try DB.run( table.create(ifNotExists: true) {t in
                t.column(dbId, primaryKey: true)
                t.column(dbName)
                t.column(dbLastName)
                t.column(dbPhone)
                t.column(dbDateOfBirth)
                t.column(dbGender)
                t.column(dbCarieer)
                t.column(dbJob)
                t.column(dbInsterest)
                t.column(dbAvatar)
                t.column(dbMondayFreeStartTime)
                t.column(dbMondayFreeEndTime)
                t.column(dbTuesdayFreeStartTime)
                t.column(dbTuesdayFreeEndTime)
                t.column(dbWednesdayFreeStartTime)
                t.column(dbWednesdayFreeEndTime)
                t.column(dbThursdayFreeStartTime)
                t.column(dbThursdayFreeEndTime)
                t.column(dbFridayFreeStartTime)
                t.column(dbFridayFreeEndTime)
                t.column(dbSaturdayFreeStartTime)
                t.column(dbSaturdayFreeEndTime)
                t.column(dbSundayFreeStartTime)
                t.column(dbSundayFreeEndTime)
                t.foreignKey(dbConnectionId, references: table, dbId, delete: .setNull)
                
            })
            
        } catch _ {
            // Error throw if table already exists
        }
        
    }
    
    static func insert(item: T) throws -> Int64 {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if (item.name != "") {
            let insert = table.insert(dbName <- item.name?.datatypeValue, dbLastName <- item.lastName?.datatypeValue,dbPhone <- item.phone?.datatypeValue, dbDateOfBirth <- item.dateOfBirth?.datatypeValue, dbGender <- item.gender?.datatypeValue, dbCarieer <- item.carieer?.datatypeValue,dbJob <- item.job?.datatypeValue, dbInsterest <- item.insterest?.datatypeValue, dbAvatar <- item.avatar?.datatypeValue, dbMondayFreeStartTime <- item.mondayFreeStartTime?.datatypeValue, dbMondayFreeEndTime <- item.mondayFreeEndTime?.datatypeValue, dbTuesdayFreeStartTime <- item.tuesdayFreeStartTime?.datatypeValue, dbTuesdayFreeEndTime <- item.tuesdayFreeEndTime?.datatypeValue, dbWednesdayFreeStartTime <- item.wednesdayFreeStartTime?.datatypeValue, dbWednesdayFreeEndTime <- item.wednesdayFreeEndTime?.datatypeValue, dbTuesdayFreeStartTime <- item.tuesdayFreeStartTime?.datatypeValue, dbThursdayFreeEndTime <- item.tuesdayFreeEndTime?.datatypeValue, dbFridayFreeStartTime <- item.fridayFreeStartTime?.datatypeValue, dbFridayFreeEndTime <- item.fridayFreeEndTime?.datatypeValue, dbSaturdayFreeStartTime <- item.saturdayFreeStartTime?.datatypeValue, dbSaturdayFreeEndTime <- item.saturdayFreeEndTime?.datatypeValue, dbSundayFreeStartTime <- item.sundayFreeStartTime?.datatypeValue, dbSundayFreeEndTime <- item.sundayFreeEndTime?.datatypeValue, dbConnectionId <- item.connectionId)
            do {
                let rowId = try DB.run(insert)
                guard rowId > 0 else {
                    throw DataAccessError.Insert_Error
                }
                return rowId
            } catch _ {
                throw DataAccessError.Insert_Error
            }
        }
        throw DataAccessError.Nil_In_Data
        
    }
    
    static func update(item: T) throws -> Int {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if (item.id != 0) {
            
            let entity = table.filter(dbId == item.id)
            
            let update = entity.update(dbName <- item.name?.datatypeValue, dbLastName <- item.lastName?.datatypeValue,dbPhone <- item.phone?.datatypeValue, dbDateOfBirth <- item.dateOfBirth?.datatypeValue, dbGender <- item.gender?.datatypeValue, dbCarieer <- item.carieer?.datatypeValue,dbJob <- item.job?.datatypeValue, dbInsterest <- item.insterest?.datatypeValue, dbAvatar <- item.avatar?.datatypeValue, dbMondayFreeStartTime <- item.mondayFreeStartTime?.datatypeValue, dbMondayFreeEndTime <- item.mondayFreeEndTime?.datatypeValue, dbTuesdayFreeStartTime <- item.tuesdayFreeStartTime?.datatypeValue, dbTuesdayFreeEndTime <- item.tuesdayFreeEndTime?.datatypeValue, dbWednesdayFreeStartTime <- item.wednesdayFreeStartTime?.datatypeValue, dbWednesdayFreeEndTime <- item.wednesdayFreeEndTime?.datatypeValue, dbTuesdayFreeStartTime <- item.tuesdayFreeStartTime?.datatypeValue, dbThursdayFreeEndTime <- item.tuesdayFreeEndTime?.datatypeValue, dbFridayFreeStartTime <- item.fridayFreeStartTime?.datatypeValue, dbFridayFreeEndTime <- item.fridayFreeEndTime?.datatypeValue, dbSaturdayFreeStartTime <- item.saturdayFreeStartTime?.datatypeValue, dbSaturdayFreeEndTime <- item.saturdayFreeEndTime?.datatypeValue, dbSundayFreeStartTime <- item.sundayFreeStartTime?.datatypeValue, dbSundayFreeEndTime <- item.sundayFreeEndTime?.datatypeValue, dbConnectionId <- item.connectionId)
            do {
                let rowId = try DB.run(update)
                guard rowId > 0 else {
                    throw DataAccessError.Insert_Error
                }
                return rowId
            } catch _ {
                throw DataAccessError.Insert_Error
            }
        }
        throw DataAccessError.Nil_In_Data
        
    }
    
    static func delete (item: T) throws -> Void {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let query = table.filter(dbId == item.id)
        do {
            let tmp = try DB.run(query.delete())
            guard tmp == 1 else {
                throw DataAccessError.Delete_Error
            }
        } catch _ {
            throw DataAccessError.Delete_Error
        }
    }
    
    static func find(idobj: Int64) throws -> T? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let query = table.filter(dbId == idobj)
        let items = try DB.prepare(query)
        for item in  items {
            
            let entity = T()
            entity.id = item[dbId]
            entity.name = item[dbName]
            entity.lastName = item[dbLastName]            
            entity.phone = item[dbPhone]
            entity.dateOfBirth = item[dbDateOfBirth]
            entity.gender = item[dbGender]
            entity.carieer = item[dbCarieer]
            entity.job = item[dbJob]
            entity.insterest = item[dbInsterest]
            entity.avatar = item[dbAvatar]
            entity.mondayFreeStartTime = item[dbMondayFreeStartTime]
            entity.mondayFreeEndTime = item[dbMondayFreeEndTime]
            entity.tuesdayFreeStartTime = item[dbTuesdayFreeStartTime]
            entity.tuesdayFreeEndTime = item[dbTuesdayFreeEndTime]
            entity.wednesdayFreeStartTime = item[dbWednesdayFreeStartTime]
            entity.wednesdayFreeEndTime = item[dbWednesdayFreeEndTime]
            entity.thursdayFreeStartTime = item[dbThursdayFreeStartTime]
            entity.thursdayFreeEndTime = item[dbThursdayFreeEndTime]
            entity.fridayFreeStartTime = item[dbFridayFreeStartTime]
            entity.fridayFreeEndTime = item[dbFridayFreeEndTime]
            entity.saturdayFreeStartTime = item[dbSaturdayFreeStartTime]
            entity.saturdayFreeEndTime = item[dbSundayFreeEndTime]
            entity.sundayFreeStartTime = item[dbSundayFreeStartTime]
            entity.sundayFreeEndTime = item[dbSundayFreeEndTime]
            entity.connectionId = item[dbConnectionId]
            
            return entity
        }
        
        return nil
    }
    
    static func findAll() throws -> [T]? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var retArray = [T]()
        let items = try DB.prepare(table)
        for item in items {
            
            let entity = T()
            entity.id = item[dbId]
            entity.name = item[dbName]
            entity.lastName = item[dbLastName]
            entity.phone = item[dbPhone]
            entity.dateOfBirth = item[dbDateOfBirth]
            entity.gender = item[dbGender]
            entity.carieer = item[dbCarieer]
            entity.job = item[dbJob]
            entity.insterest = item[dbInsterest]
            entity.avatar = item[dbAvatar]
            entity.mondayFreeStartTime = item[dbMondayFreeStartTime]
            entity.mondayFreeEndTime = item[dbMondayFreeEndTime]
            entity.tuesdayFreeStartTime = item[dbTuesdayFreeStartTime]
            entity.tuesdayFreeEndTime = item[dbTuesdayFreeEndTime]
            entity.wednesdayFreeStartTime = item[dbWednesdayFreeStartTime]
            entity.wednesdayFreeEndTime = item[dbWednesdayFreeEndTime]
            entity.thursdayFreeStartTime = item[dbThursdayFreeStartTime]
            entity.thursdayFreeEndTime = item[dbThursdayFreeEndTime]
            entity.fridayFreeStartTime = item[dbFridayFreeStartTime]
            entity.fridayFreeEndTime = item[dbFridayFreeEndTime]
            entity.saturdayFreeStartTime = item[dbSaturdayFreeStartTime]
            entity.saturdayFreeEndTime = item[dbSundayFreeEndTime]
            entity.sundayFreeStartTime = item[dbSundayFreeStartTime]
            entity.sundayFreeEndTime = item[dbSundayFreeEndTime]
            entity.connectionId = item[dbConnectionId]
            
            retArray.append(entity)
        }
        return retArray
    }
    
}
