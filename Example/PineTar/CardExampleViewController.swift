//
//  PineTar_Example
//  ViewController.swift
//
//  Created by Tommy Martin on 5/2/18.
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

import UIKit
import PineTar

class CardExampleViewController: UIViewController, StatusBarHandler {
    @IBOutlet weak var tableView: MaterialCardTableView!
    var sendingCard: MaterialCardView?
    var animatorSource: CardAnimatorSourceVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
        let baseConfig = tableView.getDefaultCardConfig()
        let titles = ["First Title", "Second Title", "Third Title", "Fourth Title", "Fifth Title"]
        let images = [#imageLiteral(resourceName: "image"), #imageLiteral(resourceName: "phinatic"), #imageLiteral(resourceName: "justin"), #imageLiteral(resourceName: "image"), #imageLiteral(resourceName: "phinatic")]
        var data: [MaterialCardConfig] = []
        
        for i in 0..<titles.count {
            let title = titles[i]
            let image = images[i]
            let config = baseConfig.copyWithUpdates(dividerConfig: DividerConfig.init(divideImage: image), headerConfig: HeaderConfig(header: title))
            data.append(config)
        }
        
        tableView.data = data
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUp()
    }
    
    func setUp() {
        tableView.cardPressedAction = {card in
            self.sendingCard = card
            
            // TODO: Wrap this inside of the pod
            let config = MaterialCardConfig(card: card)
            let view = UINib.init(nibName: "DetailContent", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
            let vc = DetailsVC(sendingCard: card, cardConfig: config, contentView: view)
            self.present(vc, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
