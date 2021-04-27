//
//  RealmManager.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 11.04.2021.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private let realm: Realm
    
    private init?() {
        
        let configurator = Realm.Configuration(schemaVersion: 1, deleteRealmIfMigrationNeeded: true)
        
        guard let realm = try? Realm(configuration: configurator) else {
            return nil
        }
        
        self.realm = realm
        
        print(realm.configuration.fileURL ?? "")
        
    }
    
    func add<DBType: Object>(object: DBType) throws {
        try realm.write {
            realm.add(object)
        }
    }
    
    func add<DBType: Object>(objects: [DBType]) throws {
        try realm.write {
            realm.add(objects, update: .all)
        }
    }
    
    func getObjects<DBType: Object>() -> Results<DBType> {
        return realm.objects(DBType.self)
    }
    
    func delete<DBType: Object>(object: DBType) throws {
        try realm.write {
            realm.delete(object)
        }
    }
    
    func deleteAll<DBType: Object>(object: DBType) throws {
        try realm.write {
            realm.deleteAll()
        }
    }
}

extension Results {
    func toArray() -> [Element] {
        return compactMap {$0}
    }
}
