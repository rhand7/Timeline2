//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Michael Huber Jr on 4/6/17.
//  Copyright © 2017 operation thirteenOne. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var counter: Int = 0

    @IBAction func addNameTapped(_ sender: Any) {
        counter += 1
        let name = "Name \(counter)"
        PersonController.shared.create(name: name)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - TableView Datasource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.shared.people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let person = PersonController.shared.people[indexPath.row]
        cell.textLabel?.text = person.name
        return cell
    }

}

