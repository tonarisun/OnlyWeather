//
//  RealmHelper.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 06.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    func loadCurrentCity() -> CurrentCity {
        var crnCity: CurrentCity?
        do {
            let realm = try Realm()
            crnCity = realm.objects(CurrentCity.self).first
        } catch {
            print(error)
        }
        if crnCity == nil {
            createEmptyCurrentCity()
            do {
                let realm = try Realm()
                crnCity = realm.objects(CurrentCity.self).first
            } catch {
                print(error)
            }
        }
        return crnCity!
    }
    
    func updateCurrentCity(city: City, currentCity: CurrentCity) {
        do {
            let realm = try Realm()
            let oldCity = realm.objects(CurrentCity.self)
            realm.beginWrite()
            realm.add(city, update: .all)
            realm.delete(oldCity)
            realm.add(currentCity)
            try realm.commitWrite()
        }
        catch {
            print(error)
        }
    }
    
    func addItemToMyCities(city: City) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(city, update: .all)
            try realm.commitWrite()
        }
        catch {
            print(error)
        }
    }
    
    func deleteCity(_ city: City) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.delete(city)
            try realm.commitWrite()
        }
        catch {
            print(error)
        }
    }
    
    private func createEmptyCurrentCity() {
        let city = CurrentCity()
        do {
            let realm = try Realm()
            let oldCity = realm.objects(CurrentCity.self)
            realm.beginWrite()
            realm.delete(oldCity)
            realm.add(city)
            try realm.commitWrite()
        }
        catch {
            print(error)
        }
    }
}
