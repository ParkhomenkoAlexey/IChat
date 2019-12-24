//
//  FriendsListTableViewController.swift
//  IChat
//
//  Created by Алексей Пархоменко on 24.12.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit
import Firebase

class FriendsListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    @objc func handleLogout() {
        print("123")
        try! Auth.auth().signOut()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }


}
