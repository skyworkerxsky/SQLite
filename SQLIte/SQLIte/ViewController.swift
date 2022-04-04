//
//  ViewController.swift
//  SQLIte
//
//  Created by Алексей Макаров on 04.04.2022.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    
    var database: Connection!
    
    let usersTable = Table("users")
    
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    let age = Expression<Int?>("age")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("testDB").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
        
    }
    
    @IBAction func createTable() {
        print("CREATE TAPPED")
        
        let createdTable = usersTable.create { table in
            table.column(id, primaryKey: true)
            table.column(name)
            table.column(email, unique: true)
            table.column(age)
        }
        
        do {
            try database.run(createdTable)
            
        } catch {
            print(error)
        }
        
    }
    @IBAction func insertUser(_ sender: Any) {
        print("INSERT TAPPED")
        let alert = UIAlertController(title: "Insert User", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Name" }
        alert.addTextField { (tf) in tf.placeholder = "Email" }
        let action = UIAlertAction(title: "Submit", style: .default) { [weak self] _ in
            guard let self = self,
                  let name = alert.textFields?.first?.text,
                  let email = alert.textFields?.last?.text
            else { return }
            print(name)
            print(email)
            
            let insert = self.usersTable.insert(self.name <- name, self.email <- email)
            
            do {
                try self.database.run(insert)
                
            } catch {
                print(error)
            }
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func listUsers(_ sender: Any) {
        print("LIST TAPPED")
        
        do {
            let users = try database.prepare(usersTable)
            for user in users {
                print("userId: \(user[self.id]), name: \(user[self.name]), email: \(user[self.email])")
            }
        } catch {
            print(error)
        }
    }
    @IBAction func updateUser(_ sender: Any) {
        print("UPDATE TAPPED")
        let alert = UIAlertController(title: "Update User", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "User ID" }
        alert.addTextField { (tf) in tf.placeholder = "Name" }
        alert.addTextField { (tf) in tf.placeholder = "Email" }
        let action = UIAlertAction(title: "Submit", style: .default) { [weak self] (_) in
            guard let self = self,
                  let userIdString = alert.textFields?.first?.text,
                  let userId = Int(userIdString),
                  let name = alert.textFields?[1].text,
                  let email = alert.textFields?.last?.text
            else { return }
            print(userIdString)
            print(name)
            print(email)
            
            let user = self.usersTable.filter(self.id == userId)
            let updateUser = user.update(self.name <- name, self.email <- email)
            do {
                try self.database.run(updateUser)
            } catch {
                print(error)
            }
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func deleteUser(_ sender: Any) {
        print("DELETE TAPPED")
        let alert = UIAlertController(title: "Update User", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "User ID" }
        let action = UIAlertAction(title: "Submit", style: .default) { [weak self] (_) in
            guard let self = self,
                  let userIdString = alert.textFields?.first?.text,
                  let userId = Int(userIdString)
            else { return }
            print(userIdString)
            
            let user = self.usersTable.filter(self.id == userId)
            let deleteUser = user.delete()
            do {
                try self.database.run(deleteUser)
            } catch {
                print(error)
            }
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func destroyDatabase() {
        print("DESTROY DATABASE")
    }
    
    private func destroyDatabase(db: Table) {
//        guard let path = db.path else { return }
//        do {
//            if FileManager.default.fileExists(atPath: path) {
//                try FileManager.default.removeItem(atPath: path)
//            }
//        } catch {
//            print("Could not destroy \(db) Database file.")
//        }
    }
}

