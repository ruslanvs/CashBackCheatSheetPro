//
//  HomeVC.swift
//  CashBackCheatSheetPro
//
//  Created by Ruslan Suvorov on 3/30/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit

class Card {
    
    let img: UIImage
    let title: String
    let desc: String
    let annualFee: String
    let cashBackTerms: String
    let linkToApply: String
    let otherTerms: String
    
    init( img: UIImage, title: String, desc: String, annualFee: String, cashBackTerms: String, linkToApply: String, otherTerms: String ) {
        self.img = img
        self.title = title
        self.desc = desc
        self.annualFee = annualFee
        self.cashBackTerms = cashBackTerms
        self.linkToApply = linkToApply
        self.otherTerms = otherTerms
    }
}

class Category {
    let title: String
    var cardArr = [Card]()
    init(title: String){
        self.title = title
    }
    func add( card: Card ) -> Category {
        self.cardArr.append( card )
        return self
    }
}

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var allCardsArr = [Card]()
    var allCategoriesArr = [Category]()
    weak var selectedCat: Category?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        combineData()
        selectedCat = allCategoriesArr[0]

        
    }
    
    func combineData(){
        
        let amex_blue_cash_preffered = Card(img: #imageLiteral(resourceName: "amex-blue-cash-preferred"), title: "Blue Cash Preferred", desc: "Great for groceries and gas. Generally cool.", annualFee: "$95", cashBackTerms: "6% cash back at U.S. supermarkets (on up to $6,000 per year in purchases, then 1%). 3% cash back at U.S. gas stations and at select U.S. department stores, 1% back on other purchases.", linkToApply: "https://www.americanexpress.com/us/credit-cards/card-application/apply/amex-everyday-preferred-credit-card/25330-10-0?pmccode=", otherTerms: "Terms Apply")
        
        let amex_blue_cash_everyday = Card(img: #imageLiteral(resourceName: "amex-blue-cash-everyday"), title: "Blue Cash Everyday", desc: "Less cool than preffered, but has no annual fee", annualFee: "No annual fee", cashBackTerms: "3% cash back at U.S. supermarkets (on up to $6,000 per year in purchases, then 1%). 2% cash back at U.S. gas stations and at select U.S. department stores, 1% back on other purchases.", linkToApply: "https://www.americanexpress.com/us/credit-cards/card-application/apply/blue-cash-everyday-credit-card/25330-10-0?pmccode=", otherTerms: "APR: 0% for 15 months on purchases and balance transfers, then a variable rate, currently 14.49% to 25.49%.")
        
        let discover_it = Card(img: #imageLiteral(resourceName: "discover-it"), title: "Discover it", desc: "Desription for Discover it", annualFee: "No annual fee", cashBackTerms: "APR - JUN 2018 - Grocery Stores. Earn 5% Cashback Bonus at Grocery Stores from April - June 2018, on up to $1,500 in purchases when you activate. Earn 5% cash back at different places each quarter like gas stations, grocery stores, restaurants, Amazon.com, or wholesale clubs up to the quarterly maximum each time you activate. Earn 1% unlimited cash back automatically on all other purchases.", linkToApply: "https://www.discovercard.com/application/apply?srcCde=GAYP&mboxPage=product_consumer_it", otherTerms: "A first-year cash back match for new cardmembers")
        
        let chase_freedom = Card(img: #imageLiteral(resourceName: "chase-freedom"), title: "Chase Freedom", desc: "Description for Chase Freedom", annualFee: "No annual fee", cashBackTerms: "APR - JUN 2018 - Grocery Stores, not including Walmart and Target. Earn 5% cash back on up to $1,500 in combined purchases in bonus categories each quarter you activate", linkToApply: "https://applynow.chase.com/FlexAppWeb/renderApp.do?SPID=FQYC&CELL=6TKX&PROMO=DF01", otherTerms: "0% intro APR for 15 months from account opening on purchases and balance transfers.† Same page link to Pricing and Terms After that, 16.24%–24.99% variable APR.")
        
        let citi_double_cash = Card(img: #imageLiteral(resourceName: "citi-double-cash"), title: "Citi® Double Cash Card", desc: "Dedcription for Citi Double Cash Card", annualFee: "No annual fee", cashBackTerms: "Earn cash back on your purchases with one of Citi's best cash back credit cards. The Citi Double Cash card lets you earn cash back twice — 1% unlimited on purchases and an additional 1% as you pay for those purchases.", linkToApply: "https://www.citicards.com/cards/credit/application/flow.action?app=UNSOL&t=t&sc=4T5ZMEH8&m=31A8L10203W&B=M&ID=3000&uc=H28&ProspectID=PR4pg4EY6vJwsZH22S04ezIAgxhuPiRB&intc=7~7~66~1~PDP~1~citi-double-cash-credit-card~4T5ZMEH831A8L10203W&cmv=426&pid=142&walletSegment=C171_02&rCode=I000", otherTerms: "Terms Apply")
        
        let wells_fargo_cash_wise = Card(img: #imageLiteral(resourceName: "wells-fargo-cash-wise"), title: "Wells Fargo Cash Wise", desc: "Description for Wells Cargo Cash Wise", annualFee: "No annual fee", cashBackTerms: "Earn unlimited 1.5% cash rewards on purchases", linkToApply: "https://www.wellsfargo.com/wf/product/apply?prodSet=APP2K&prodCode=CC-CW&sub_channel=WEB&vendor_code=WF", otherTerms: "Terms apply")
        
        let capital_one_savor_dining_rewards = Card(img: #imageLiteral(resourceName: "capital-one-savor-rewards-dining"), title: "Savor Dining Rewards", desc: "Description for Savor Dining Rewards", annualFee: "No annual fee", cashBackTerms: "Earn unlimited 3% cash back on dining, 2% on groceries and 1% on all other purchases", linkToApply: "https://applynow.capitalone.com/?productId=2739", otherTerms: "0% intro APR for 9 months; 15.74% - 24.49% variable APR after that")
        
        
        let allCards = Category(title: "All Cards")
        allCategoriesArr.append(allCards)
        allCards.add(card: citi_double_cash).add(card: wells_fargo_cash_wise).add(card: amex_blue_cash_preffered).add(card: amex_blue_cash_everyday).add(card: discover_it).add(card: chase_freedom).add(card: capital_one_savor_dining_rewards)

        
        let groceries = Category(title: "Grocery Stores")
        allCategoriesArr.append(groceries)
        groceries.add(card: amex_blue_cash_preffered).add(card: amex_blue_cash_everyday).add(card: citi_double_cash)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destination = segue.destination
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //>> how to make selection disappear with animation when user gets back to this screen?
        performSegue(withIdentifier: "CardDetails", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let category = selectedCat {
            return category.cardArr.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableCell
        
        cell.img.image = selectedCat!.cardArr[indexPath.row].img
        cell.label.text = selectedCat!.cardArr[indexPath.row].title
//        cell.label.text = "\(indexPath.row)"
        
        return cell
    }
}

extension HomeVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allCategoriesArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(allCategoriesArr[row].title)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCat = allCategoriesArr[row]
        tableView.reloadData()
    }
    
}



