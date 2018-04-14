//
//  TopCardsVC.swift
//  CashBackCheatSheetPro
//
//  Created by Ruslan Suvorov on 4/2/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit

enum TopCardsViewModelItemType {
    case imageTitleIssuer
    case cashBack
}

protocol TopCardsViewModelItem {
    var type: TopCardsViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
    var card: Card { get }
}

class TopCardsViewImageTitleIssuerItem: TopCardsViewModelItem {
    let type: TopCardsViewModelItemType = .imageTitleIssuer
    let sectionTitle: String = " "
    let rowCount: Int = 1
    var card: Card
    
    var img: UIImage
    var title: String
    var issuer: String
    
    
    init( img: UIImage, title: String, issuer: String, card: Card ){
        self.img = img
        self.title = title
        self.issuer = issuer
        self.card = card
    }
}

class TopCardsViewCashBackItem: TopCardsViewModelItem {
    let type: TopCardsViewModelItemType = .cashBack
    let sectionTitle: String = ""
    var rowCount: Int {
        return cashBacks.count
    }
    var card: Card
    
    var cashBacks: [CashBack]
    
    init( cashBacks: [CashBack], card: Card ) {
        self.cashBacks = cashBacks
        self.card = card
    }
}
    

class TopCardsVC: UIViewController {
    
    var tableData = [TopCardsViewModelItem]()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        compileViewData()
    }
    
    func compileViewData(){
        for card in Data.shared.topCards {

            let imageTitleIssuerItem = TopCardsViewImageTitleIssuerItem(img: card.img, title: card.title, issuer: card.issuer, card: card )
            tableData.append( imageTitleIssuerItem )
            
            let cashBacksItem = TopCardsViewCashBackItem( cashBacks: card.topInCategory, card: card )
            tableData.append( cashBacksItem )
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CardDetailsVC
        
        if sender as? IndexPath != nil {
            let indexPath = sender as! IndexPath
            destination.card = tableData[indexPath.section].card
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TopCardsVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow( at: indexPath, animated: true )
        performSegue( withIdentifier: "CardDetails2", sender: indexPath )
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableData[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableSectionData = tableData[indexPath.section]
        
        switch tableSectionData.type {
        case .imageTitleIssuer:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TopCardsImageTitleIssuerCell", for: indexPath) as? TopCardsImageTitleIssuerCell {
                let i = tableSectionData as! TopCardsViewImageTitleIssuerItem
                cell.img.image = i.img
                cell.title.text = i.title
                cell.subtitle.text = i.issuer
                return cell
            }
            
        case .cashBack:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TopCardsCashBackCell", for: indexPath) as? TopCardsCashBackCell {
                let i = tableSectionData as! TopCardsViewCashBackItem
                cell.title.text = i.cashBacks[indexPath.row].category.title
                cell.details.text = "\(i.cashBacks[indexPath.row].rate)%"
                return cell
            }
        }
        return UITableViewCell()
    }
}
