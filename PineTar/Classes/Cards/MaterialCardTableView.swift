//
//  PineTar
//  TabTableViewController.swift
//
//  Created by Tommy Martin on 5/3/18.
//  Copyright (c) 2018-present, Diamond Kinetics
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
