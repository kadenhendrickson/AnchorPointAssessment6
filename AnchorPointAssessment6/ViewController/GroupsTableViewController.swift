//
//  GroupsTableViewController.swift
//  AnchorPointAssessment6
//
//  Created by Kaden Hendrickson on 6/14/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addPersonButtonTapped(_ sender: UIBarButtonItem) {
        presentAddPersonAlertController()
    }

    @IBAction func randomizeButtonTapped(_ sender: Any) {
        PersonController.shared.shufflePeople()
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return PersonController.shared.data.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PersonController.shared.data[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        let person = PersonController.shared.data[indexPath.section][indexPath.row]
        cell.textLabel?.text = person.name
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        
            let person = PersonController.shared.data[indexPath.section][indexPath.row]
            PersonController.shared.deletePerson(person: person)
            //tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        }
    }

    func presentAddPersonAlertController() {
        let alertController = UIAlertController(title: "Add Person", message: "add someone new to the list", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "put a name here..."
            textField.keyboardType = .default
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = alertController.textFields?.first?.text, !name.isEmpty else {return}
           PersonController.shared.addPerson(name: name)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
}

