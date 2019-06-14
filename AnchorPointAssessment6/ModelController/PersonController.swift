//
//  PersonController.swift
//  AnchorPointAssessment6
//
//  Created by Kaden Hendrickson on 6/14/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class PersonController {
    
    private init() {
        //people = loadFromPersistentStore()
    }
    //sharedInstance
    static let shared = PersonController()
    //SOT
    var people: [Person] = []
   
    var data: [[Person]]?  {
        var dataArray: [[Person]] = []
        let people = PersonController.shared.people
         var counter = 0
        if people.count > 1 && people.count % 2 == 0 {
            while counter < people.count {
                var array: [Person] = []
                array.append(people[counter])
                array.append(people[counter + 1])
                dataArray.append(array)
                counter += 2
            }
        } else if people.count > 1 {
            while counter < people.count - 1 {
                var array: [Person] = []
                array.append(people[counter])
                array.append(people[counter + 1])
                dataArray.append(array)
                counter += 2
            }
            let array = [people[people.count-1]]
            dataArray.append(array)
        } else {
            while counter < people.count {
                var array: [Person] = []
                array.append(people[counter])
                dataArray.append(array)
                counter += 1
            }
        }
        return dataArray
    }

    func addPerson(name: String) {
        let person = Person(name: name)
        self.people.append(person)
        //saveToPersistentStore()
    }
    
    func deletePerson(person: Person) {
        guard let index = people.firstIndex(of: person) else {return}
        people.remove(at: index)
        //saveToPersistentStore()
    }
    
    func shufflePeople() {
        self.people.shuffle()
        //saveToPersistentStore()
    }
    
    private func fileUrl() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "AnchorPointAssessment6.json"
        let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentsDirectoryURL
    }
    
    func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(people)
            let url = fileUrl()
            try data.write(to: url)
        } catch {
            print("There was an error: \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() -> [Person] {
        let jsonDecoder = JSONDecoder()
        do {
            let url = fileUrl()
            let data = try Data(contentsOf: url)
            let people = try jsonDecoder.decode([Person].self, from: data)
            return people
        } catch {
            print("there was an error loading data: \(error.localizedDescription)")
        }
        return []
    }
}
