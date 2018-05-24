//
//  DetailContentTableView.swift
//  PineTar_Example
//
//  Created by Tommy Martin on 5/23/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import PineTar

class DetailContentTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        self.backgroundColor = ThemeManager.backgroundColor
        self.delegate = self
        self.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        cell.textLabel?.text = "This is cell \(indexPath.row)"
        cell.backgroundColor = ThemeManager.backgroundColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
