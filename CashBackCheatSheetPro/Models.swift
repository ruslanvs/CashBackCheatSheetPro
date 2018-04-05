//
//  Models.swift
//  CashBackCheatSheetPro
//
//  Created by Ruslan Suvorov on 4/3/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit

class Card {

    let img: UIImage
    let title: String
    let issuer: String
    var cash_backs = [CashBack]()
    var select_cash_back_rate = Double()
    var select_cash_back_notes = String()
    var topInCategory = [CashBack]()
    let annualFee: String
    let cashBackTerms: String
    let linkToApply: String
    let otherTerms: String
    
    init( img: UIImage, title: String, issuer: String, annualFee: String, cashBackTerms: String, linkToApply: String, otherTerms: String ) {
        self.img = img
        self.title = title
        self.issuer = issuer
        self.annualFee = annualFee
        self.cashBackTerms = cashBackTerms
        self.linkToApply = linkToApply
        self.otherTerms = otherTerms
    }
    
    func addCashBack( cashBack: CashBack ) -> Card {
        self.cash_backs.append( cashBack )
        return self
    }
}

class Category {
    let title: String
    init(title: String){
        self.title = title
    }
}

class CashBack {
    let category: Category
    let rate: Double
    let notes: String
    
    init( category: Category, rate: Double, notes: String ){
        self.category = category
        self.rate = rate
        self.notes = notes
    }
}

class Data {
    
    static let shared = Data()
    
    var allCards = [Card]()
    var selectCards = [Card]()
    var topCards = [Card]()
    var allCategories = [Category]()
    var selectCategories = [Category]()
    var initialCategory: Category
    var generalCategory: Category
    
    init(){
        
        let amex_blue_cash_preffered = Card(img: #imageLiteral(resourceName: "amex-blue-cash-preferred"), title: "Blue Cash Preferred®", issuer: "American Express", annualFee: "Annual fee: $95", cashBackTerms: "Cash back is received in the form of Reward Dollars that can be redeemed as a statement credit", linkToApply: "https://www.americanexpress.com/us/credit-cards/card-application/apply/amex-everyday-preferred-credit-card/25330-10-0?pmccode=", otherTerms: "Terms Apply")
        
        let amex_blue_cash_everyday = Card(img: #imageLiteral(resourceName: "amex-blue-cash-everyday"), title: "Blue Cash Everyday®", issuer: "American Express", annualFee: "No annual fee", cashBackTerms: "Cash back is received in the form of Reward Dollars that can be redeemed as a statement credit. Terms and limitations apply", linkToApply: "https://www.americanexpress.com/us/credit-cards/card-application/apply/blue-cash-everyday-credit-card/25330-10-0?pmccode=", otherTerms: "Terms Apply")
        
        let discover_it = Card(img: #imageLiteral(resourceName: "discover-it"), title: "Discover it", issuer: "Discover", annualFee: "No annual fee", cashBackTerms: "APR - JUN 2018 - Grocery Stores. Earn 5% Cashback Bonus at Grocery Stores from April - June 2018, on up to $1,500 in purchases when you activate. Earn 5% cash back at different places each quarter like gas stations, grocery stores, restaurants, Amazon.com, or wholesale clubs up to the quarterly maximum each time you activate. Earn 1% unlimited cash back automatically on all other purchases.", linkToApply: "https://www.discovercard.com/application/apply?srcCde=GAYP&mboxPage=product_consumer_it", otherTerms: "A first-year cash back match for new cardmembers")
        
        let chase_freedom = Card(img: #imageLiteral(resourceName: "chase-freedom"), title: "Freedom®", issuer: "Chase", annualFee: "No annual fee", cashBackTerms: "APR - JUN 2018 - Grocery Stores, not including Walmart and Target. Earn 5% cash back on up to $1,500 in combined purchases in bonus categories each quarter you activate", linkToApply: "https://applynow.chase.com/FlexAppWeb/renderApp.do?SPID=FQYC&CELL=6TKX&PROMO=DF01", otherTerms: "0% intro APR for 15 months from account opening on purchases and balance transfers.† Same page link to Pricing and Terms After that, 16.24%–24.99% variable APR.")
        
        let chase_freedom_ulimited = Card(img: #imageLiteral(resourceName: "chase-freedom-unlimited"), title: "Freedom Unlimited®", issuer: "Chase", annualFee: "No annual fee", cashBackTerms: "Earn unlimited 1.5% cash back on every purchase - it's automatic.", linkToApply: "https://creditcards.chase.com/cash-back-credit-cards/chase-freedom-unlimited?CELL=6TKX&IP3H=Y71UH0&SP4R=FH24R8&F42G=Y538C4", otherTerms: "0% intro APR for 12 months from account opening on purchases and balance transfers.† Same page link to Pricing and Terms After that, 14.24%–24.99% variable APR.† Same page link to Pricing and Terms Balance transfer fee is 5% of the amount transferred with a minimum of $5.")
        
        let citi_double_cash = Card(img: #imageLiteral(resourceName: "citi-double-cash"), title: "Double Cash", issuer: "Citi®", annualFee: "No annual fee", cashBackTerms: "Earn cash back on your purchases with one of Citi's best cash back credit cards. The Citi Double Cash card lets you earn cash back twice — 1% unlimited on purchases and an additional 1% as you pay for those purchases.", linkToApply: "https://www.citicards.com/cards/credit/application/flow.action?app=UNSOL&t=t&sc=4T5ZMEH8&m=31A8L10203W&B=M&ID=3000&uc=H28&ProspectID=PR4pg4EY6vJwsZH22S04ezIAgxhuPiRB&intc=7~7~66~1~PDP~1~citi-double-cash-credit-card~4T5ZMEH831A8L10203W&cmv=426&pid=142&walletSegment=C171_02&rCode=I000", otherTerms: "Terms Apply")
        
        let wells_fargo_cash_wise = Card(img: #imageLiteral(resourceName: "wells-fargo-cash-wise"), title: "Wells Fargo Cash Wise", issuer: "Description for Wells Cargo Cash Wise", annualFee: "No annual fee", cashBackTerms: "Earn unlimited 1.5% cash rewards on purchases", linkToApply: "https://www.wellsfargo.com/wf/product/apply?prodSet=APP2K&prodCode=CC-CW&sub_channel=WEB&vendor_code=WF", otherTerms: "Terms apply")
        
        let capital_one_savor_dining_rewards = Card(img: #imageLiteral(resourceName: "capital-one-savor-rewards-dining"), title: "Savor Dining Rewards", issuer: "Capital One", annualFee: "No annual fee", cashBackTerms: "Earn unlimited 3% cash back on dining, 2% on groceries and 1% on all other purchases", linkToApply: "https://applynow.capitalone.com/?productId=2739", otherTerms: "0% intro APR for 9 months; 15.74% - 24.49% variable APR after that")


        allCards += [citi_double_cash, wells_fargo_cash_wise, amex_blue_cash_preffered, amex_blue_cash_everyday, discover_it, chase_freedom, chase_freedom_ulimited, capital_one_savor_dining_rewards]
        
        let otherPurchases = Category(title: "Other Purchases")
        let groceries = Category(title: "Grocery Stores")
        let restCoffee = Category(title: "Restaurants & Coffee")
        let gas = Category(title: "Gas")
        let pharma = Category(title: "Pharmacies")
        let wholeSaleClubs = Category(title: "Wholesale Clubs")
        let selectDepStores = Category(title: "Select Department Stores")
        let taxi = Category(title: "Taxi")
        allCategories += [otherPurchases, groceries, restCoffee, gas, pharma, wholeSaleClubs, selectDepStores, taxi]
        initialCategory = allCategories[0]
        generalCategory = allCategories[0]
        
        let axprGr = CashBack(category: groceries, rate: 6, notes: "6% cash back at US supermarkets, on up to $6,000 per year in purchases (then 1%)")
        let axprGas = CashBack(category: gas, rate: 3, notes: "3% cash back at US gas stations")
        let axprSelDeptSt = CashBack(category: selectDepStores, rate: 3, notes: "3% cash back at select US department stores")
        let axprOther = CashBack(category: otherPurchases, rate: 1, notes: "")
        amex_blue_cash_preffered.addCashBack(cashBack: axprGr).addCashBack(cashBack: axprGas).addCashBack(cashBack: axprSelDeptSt).addCashBack(cashBack: axprOther)
        
        let axbeGr = CashBack(category: groceries, rate: 3, notes: "3% cash back at U.S. supermarkets, on up to $6,000 per year in purchases (then 1%)")
        let axbeGas = CashBack(category: gas, rate: 2, notes: "2% cash back at U.S. gas stations")
        let axbeSelDeptSt = CashBack(category: selectDepStores, rate: 2, notes: "2% cash back at select department stores")
        let axbeOther = CashBack(category: otherPurchases, rate: 1, notes: "1% on other purchases")
        amex_blue_cash_everyday.addCashBack(cashBack: axbeGr).addCashBack(cashBack: axbeGas).addCashBack(cashBack: axbeSelDeptSt).addCashBack(cashBack: axbeOther)
        
        let ctdcOther = CashBack(category: otherPurchases, rate: 2, notes: "")
        citi_double_cash.addCashBack(cashBack: ctdcOther)
        
        let dvitGr = CashBack(category: groceries, rate: 5, notes: "APR - JUN 2018")
        let dvitOther = CashBack(category: otherPurchases, rate: 1, notes: "")
        discover_it.addCashBack(cashBack: dvitGr).addCashBack(cashBack: dvitOther)
        
        let chfrGr = CashBack(category: groceries, rate: 5, notes: "APR - JUN 2018")
        let chfrOther = CashBack(category: otherPurchases, rate: 1, notes: "")
        chase_freedom.addCashBack(cashBack: chfrGr).addCashBack(cashBack: chfrOther)
        
        let chfuOther = CashBack(category: otherPurchases, rate: 1.5, notes: "")
        chase_freedom_ulimited.addCashBack(cashBack: chfuOther)
        
        let cosrDin = CashBack(category: restCoffee, rate: 3, notes: "")
        let cosrGr = CashBack(category: groceries, rate: 2, notes: "")
        let cosrOther = CashBack(category: otherPurchases, rate: 1, notes: "")
        capital_one_savor_dining_rewards.addCashBack(cashBack: cosrDin).addCashBack(cashBack: cosrGr).addCashBack(cashBack: cosrOther)
        
        let wfcwOther = CashBack(category: otherPurchases, rate: 1.5, notes: "")
        wells_fargo_cash_wise.addCashBack(cashBack: wfcwOther)
        
        selectAndSortCardsBy(category: initialCategory)
        selectTopCards()
        listSelectCategories()
    }
    
    func selectAndSortCardsBy( category: Category ){

        selectCards = []
        
        for card in allCards {
            for cb in card.cash_backs {
                if cb.category.title == category.title {
                    card.select_cash_back_rate = cb.rate
                    card.select_cash_back_notes = cb.notes
                    selectCards.append( card )
                }
            }
        }
        for card in allCards {
            var isSelect = false
            for selectCard in selectCards {
                if card.title == selectCard.title {
                    isSelect = true
                    break
                }
            }
            if isSelect == false {
                for cb in card.cash_backs {
                    if cb.category.title == generalCategory.title {
                        card.select_cash_back_rate = cb.rate
                        card.select_cash_back_notes = cb.notes
                        selectCards.append(card)
                        break
                    }
                }
            }
            isSelect = false
        }
        
        var didSort = true
        while didSort == true {
            didSort = false
            for i in 0..<(selectCards.count - 1)  {
                if selectCards[i].select_cash_back_rate < selectCards[i + 1].select_cash_back_rate {
                    let temp = selectCards[i]
                    selectCards[i] = selectCards[i + 1]
                    selectCards[i + 1] = temp
                    didSort = true
                }
            }
        }
    }
    
    func selectTopCards(){
        
        for category in allCategories {
            selectAndSortCardsBy(category: category)

            var isPresent = false
            for card in topCards {
                if card.title == selectCards[0].title {
                    isPresent = true
                    break
                }
            }
            
            for cashBack in selectCards[0].cash_backs {
                if cashBack.category.title == category.title {
                    selectCards[0].topInCategory.append( cashBack )
                }
            }

            if isPresent == false {
                topCards.append( selectCards[0] )
            }
        }
        
    }
    
    func listSelectCategories() {
        for card in allCards {
            
            var isPresent = false
            for cashBack in card.cash_backs {
                
                for category in selectCategories {
                    if cashBack.category.title == category.title {
                        isPresent = true
                        break
                    }
                }
                
                if isPresent == false {
                    selectCategories.append(cashBack.category)
                }
                
            }
        }
        
    }
}
