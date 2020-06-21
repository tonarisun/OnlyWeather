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
    
    //MARK: - loadCurrentCity
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
    
    //MARK: - updateCurrentCity
    func updateCurrentCity(city: CurrentCity) {
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
    
    //MARK: - addItemToMyCities
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
    
    //MARK: - deleteCity
    func deleteCity(with id: String) {
        do {
            let realm = try Realm()
            let cities = realm.objects(City.self)
            if let city = cities.first(where: { (city) in
                city.cityID == id
            }) {
                realm.beginWrite()
                realm.delete(city)
                try realm.commitWrite()
            }
        }
        catch {
            print(error)
        }
    }
    
    //MARK: - createEmptyCurrentCity
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
