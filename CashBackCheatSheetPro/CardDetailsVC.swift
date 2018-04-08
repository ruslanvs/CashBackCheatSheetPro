//
//  CardDetailsVC.swift
//  CashBackCheatSheetPro
//
//  Created by Ruslan Suvorov on 3/31/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit

enum CardDetailsViewModelItemType {
    case titleAndIssuer
    case cashBack
    case annualFee
}

protocol CardDetailsViewModelItem {
    var type: CardDetailsViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}

class TitleAndIssuerItem: CardDetailsViewModelItem {
    let type: CardDetailsViewModelItemType = .titleAndIssuer
    let sectionTitle: String = "Main Info"
    let rowCount: Int = 1
    
    var title: String
    var issuer: String
    
    init( title: String, issuer: String ) {
        self.title = title
        self.issuer = issuer
    }
}

class CashBackItem: CardDetailsViewModelItem {
    let type: CardDetailsViewModelItemType = .cashBack
    let sectionTitle: String = "Cash Back"
//    var rowCount: Int = cashBacks.count
    var rowCount: Int { //>> Eli, this time just one line did not work
        return cashBacks.count
    }
    
    var cashBacks: [CashBack]
    
    init( cashBacks: [CashBack] ) {
        self.cashBacks = cashBacks
    }
}

class AnnualFeeItem: CardDetailsViewModelItem {
    let type: CardDetailsViewModelItemType = .annualFee
    let sectionTitle: String = "Annual Fee"
    let rowCount: Int = 1
    
    var annualFee: String
    
    init( annualFee: String ){
        self.annualFee = annualFee
    }
}


class CardDetailsVC: UIViewController {
    
    weak var card: Card?
    
    var items = [CardDetailsViewModelItem]()
    
//    var tableData = [String]()

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
        }

        compileViewData()
    }
    
    func compileViewData(){
        
        if let title = card?.title, let issuer = card?.issuer {
            let titleAndIssuerItem = TitleAndIssuerItem(title: title, issuer: issuer)
            items.append( titleAndIssuerItem )
        }
        
        let cashBacks = card?.cash_backs
        if !(card?.cash_backs.isEmpty)! {
            let cashBacksItem = CashBackItem( cashBacks: cashBacks! )
            items.append( cashBacksItem )
        }

        if let annualFee = card?.annualFee {
            let annualFeeItem = AnnualFeeItem(annualFee: annualFee)
            items.append( annualFeeItem )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CardDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = items[indexPath.section]
        
        switch item.type {
            
        case .titleAndIssuer:
            if let cell = tableView.dequeueReusableCell( withIdentifier: "CardDetailsTitleAndIssuerCell", for: indexPath ) as? CardDetailsTitleAndIssuerCell {
                let i = item as! TitleAndIssuerItem
                cell.title.text = i.title
                cell.subTitle.text = i.issuer
                
                return cell
            }
        case .cashBack:
            if let cell = tableView.dequeueReusableCell( withIdentifier: "CardDetailsCashBackCell", for: indexPath ) as? CardDetailsCashBackCell {
                let i = item as! CashBackItem
                cell.title.text = i.cashBacks[indexPath.row].category.title
                cell.detail.text = "\(i.cashBacks[indexPath.row].rate)%"
                cell.subTitle.text = i.cashBacks[indexPath.row].notes
                return cell
            }
            
        case .annualFee:
            if let cell = tableView.dequeueReusableCell( withIdentifier: "CardDetailsAnnualFeeCell", for: indexPath ) as? CardDetailsAnnualFeeCell {
                let i = item as! AnnualFeeItem
                cell.title.text = i.annualFee
                return cell
            }
        }
        return UITableViewCell()
    }
}













