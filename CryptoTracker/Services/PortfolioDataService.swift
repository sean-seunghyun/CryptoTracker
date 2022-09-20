//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/19.
//

import Foundation
import CoreData

class PortfolioDataService{
    let container: NSPersistentContainer
    let entityName: String = "PortfolioEntity"
    
    @Published var savedPortfolios: [PortfolioEntity] = []
    
    static let instance = PortfolioDataService()
    
    private init(){
        container = NSPersistentContainer(name: "PortfolioContainer")
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("error loading container: \(error)")
            }
            print("description: \(description)")
            print("success loading container")
        }
        
        getPortfolios()
    }
    
    // MARK: - PUBLIC
    func updatePortfolio(coin: Coin, amount: Double){

        if let savedCoin = savedPortfolios.first(where: { $0.coinID == coin.id }){
        
            if amount > 0{
                update(entity: savedCoin, amount: amount)
            }else{
                remove(entity: savedCoin)
            }
            
        }else{
            add(coin: coin, amount: amount)
        }
        
    }
    
    // MARK: - PRIVATE
    private func getPortfolios(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do{
            savedPortfolios = try container.viewContext.fetch(request)
        }catch let error{
            print("error fetching portfolios: \(error.localizedDescription)")
        }
    }
    
    private func add(coin: Coin, amount: Double){
        let newPortfolio = PortfolioEntity(context: container.viewContext)
        newPortfolio.coinID = coin.id
        newPortfolio.amount = amount
        applyChanges()
    }
    
    private func saveData(){
        do{
            try container.viewContext.save()
        }catch let error {
            print("error savind data: \(error.localizedDescription)")
        }
    }
    
    private func applyChanges(){
        saveData()
        getPortfolios()
    }
    
    private func update(entity: PortfolioEntity, amount: Double){
        entity.amount = amount
        applyChanges()
    }
    
    private func remove(entity: PortfolioEntity){
        container.viewContext.delete(entity)
        applyChanges()
    }
    
}
