//
//  ItemTableViewCell.swift
//  ShoppingList
//
//  Created by Marina Basaeva on 7/9/22.
//

import UIKit

protocol ItemCompletionDelegate: AnyObject {
    func itemCellButtonTapped (_ sender: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    // Properties
    var item: Item? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: ItemCompletionDelegate?
    
    func updateViews() {
        guard let item = item else {return}
        itemNameLabel.text = item.name
        if item.isComlete {
            completionButton.setBackgroundImage(UIImage(named: "complete"), for: .normal)
        } else {
            completionButton.setBackgroundImage(UIImage(named: "incomplete"), for: .normal)
        }
    }
    
    // Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        if let delegate = delegate {
            delegate.itemCellButtonTapped(self)
        }
    }
    
}//End of class
