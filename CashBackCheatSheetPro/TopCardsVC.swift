//
//  TopCardsVC.swift
//  CashBackCheatSheetPro
//
//  Created by Ruslan Suvorov on 4/2/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit

class TopCardsVC: UIViewController {
    
    var tableData = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        for card in Data.shared.topCards {
            tableData.append("\(card.issuer)")
            tableData.append("\(card.title) is top in:")

            for cashBack in card.topInCategory {
                tableData.append("\(cashBack.rate)% - \(cashBack.category.title)")
            }
            tableData.append("")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TopCardsVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopCardCell", for: indexPath)
        
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }
}
