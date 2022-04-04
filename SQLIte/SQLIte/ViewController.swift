//
//  ViewController.swift
//  SQLIte
//
//  Created by Алексей Макаров on 04.04.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func createTable() {
        print("CREATE TAPPED")
        
    }
    @IBAction func insertUser(_ sender: Any) {
        print("INSERT TAPPED")
        let alert = UIAlertController(title: "Insert User", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Name" }
        alert.addTextField { (tf) in tf.placeholder = "Email" }
        let action = UIAlertAction(title: "Submit", style: .default) { (_) in
            guard let name = alert.textFields?.first?.text,
                  let email = alert.textFields?.last?.text
            else { return }
            print(name)
            print(email)
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func listUsers(_ sender: Any) {
        print("LIST TAPPED")
    }
    @IBAction func updateUser(_ sender: Any) {
        print("UPDATE TAPPED")
        let alert = UIAlertController(title: "Update User", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "User ID" }
        alert.addTextField { (tf) in tf.placeholder = "Email" }
        let action = UIAlertAction(title: "Submit", style: .default) { (_) in
            guard let userIdString = alert.textFields?.first?.text,
                let userId = Int(userIdString),
                let email = alert.textFields?.last?.text
                else { return }
            print(userIdString)
            print(email)
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func deleteUser(_ sender: Any) {
        print("DELETE TAPPED")
        let alert = UIAlertController(title: "Update User", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "User ID" }
        let action = UIAlertAction(title: "Submit", style: .default) { (_) in
            guard let userIdString = alert.textFields?.first?.text,
                let userId = Int(userIdString)
                else { return }
            print(userIdString)
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

