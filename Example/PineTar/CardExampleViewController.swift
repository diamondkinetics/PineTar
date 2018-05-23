//
//  ViewController.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/2/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
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
//            let view = UINib.init(nibName: "DetailContent", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
            let view = DetailContentTableView(frame: CGRect.zero, style: UITableViewStyle.plain)
            let vc = DetailsVC(sendingCard: card, cardConfig: config, contentView: view)
            self.present(vc, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
