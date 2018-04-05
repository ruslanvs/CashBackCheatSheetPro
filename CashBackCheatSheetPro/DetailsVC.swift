//
//  DetailsVC.swift
//  CashBackCheatSheetPro
//
//  Created by Ruslan Suvorov on 3/31/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    
    weak var card: Card?
    
    var tableData = [String]()

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        if let card = card {
            self.title = card.title
            img.image = card.img
            tableData.append( card.issuer )
//            tableData.append( c.title )
            for cashBack in card.cash_backs {
                tableData.append("\(cashBack.category.title), \(cashBack.rate)%")
                tableData.append("\(cashBack.notes)")
            }
            tableData.append( card.annualFee )
//            tableData.append( card.cashBackTerms )
//            tableData.append( card.linkToApply )
//            tableData.append( card.otherTerms )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
        
//        cell.label.text = "\(indexPath.row) asdf asdf asdf asd asdf sdf asd adsf adf adsf adsf ad adsf adf asd fasd faasdf asdf safd."
        cell.label.text = tableData[indexPath.row]
        
        return cell
    }
}
