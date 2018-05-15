//
//  TabTableViewController.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/3/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit

// NOTE: Two courses of action if they want to have a more control, create own delegate or override specific functions
public class MaterialCardTableView: UITableView {
    public var cardPressedAction: ((MaterialCardView) -> Void)?
    public var data: [MaterialCardConfig]!
    public var cellHeight: CGFloat = 300
    public var cellReuseIdentifier: String = "cell"
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        delegate = self
        dataSource = self
        backgroundColor = ThemeManager.backgroundColor
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.separatorStyle = .none
    }
    
    // TODO: Support multiple configs
    public func getDefaultCardConfig() -> MaterialCardConfig {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellReuseIdentifier) else {fatalError("Unable to dequeue cell with identifier \(cellReuseIdentifier)")}
        
        let card: MaterialCardView
        let cards = cell.contentView.subviews.filter{$0 is MaterialCardView} as! [MaterialCardView]
        
        guard cards.count != 0 else {
            fatalError("Cannot create a MaterialCardTableView with cells that do not have cards in them!")
        }
        
        card = cards[0]
        
        return MaterialCardConfig.init(card: card)
    }
}

extension MaterialCardTableView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data == nil {
            fatalError("Need to set data for MaterialCardTableView or create a custom delegate and datasource")
        }
        
        return data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.contentView.backgroundColor = ThemeManager.backgroundColor
        cell.selectionStyle = .none
        let card: MaterialCardView
        let cards = cell.contentView.subviews.filter{$0 is MaterialCardView} as! [MaterialCardView]
        
        guard cards.count != 0 else {
            fatalError("Cannot create a MaterialCardTableView with cells that do not have cards in them!")
        }
        
        card = cards[0]
        card.cardPressedAction = self.cardPressedAction
        let config = data[indexPath.row]
        card.update(forConfig: config)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
