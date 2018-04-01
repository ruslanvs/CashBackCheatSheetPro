//
//  DetailsVC.swift
//  CashBackCheatSheetPro
//
//  Created by Ruslan Suvorov on 3/31/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    
//    let card: Card

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
        

        cell.label.text = "\(indexPath.row) asdf asdf asdf asd asdf sdf asd adsf adf adsf adsf ad adsf adf asd fasd faasdf asdf safd."
        
        
        return cell
    }
}
