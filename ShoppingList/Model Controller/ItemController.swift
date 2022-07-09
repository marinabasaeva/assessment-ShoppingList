//
//  ItemController.swift
//  ShoppingList
//
//  Created by Marina Basaeva on 7/9/22.
//

import Foundation

class ItemController {
    //Singleton
    static let shared = ItemController()
    //Source of truth
    var items: [Item] = []
    
    func addItem(name: String) {
        let newItem = Item(name: name, isComplete: false)
        items.append(newItem)
        saveToPersistenceStore()
    }
    
    func toggleIsComplete(item: Item) {
        item.isComlete.toggle()
        saveToPersistenceStore()
    }
    
    func delete(item: Item) {
        guard let index = items.firstIndex(of: item) else {return}
        items.remove(at: index)
        saveToPersistenceStore()
    }
    
    //MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("ShoppingList.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(items)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error encoding item: \(error) -- \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistenceStore() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            items = try jsonDecoder.decode([Item].self, from: data)
        } catch {
            print("Error decoding data: \(error) -- \(error.localizedDescription)")
        }
    }

    
    
}//End of class
