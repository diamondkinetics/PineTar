//
//  SocialExampleViewController.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/8/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import Foundation
import UIKit
import PineTar

class SocialExampleViewController: UIViewController, StatusBarHandler {
    @IBOutlet weak var tableView: MaterialCardTableView!
    var animatorSource: CardAnimatorSourceVC!
    var sendingCard: MaterialCardView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
        let baseConfig = tableView.getDefaultCardConfig()
        let titles = ["Philly Phanatic Eats a Hot Dog", "A Very Nice Field", "Two Guys by a River"]
        let descriptions = ["In an interesting turn of events, Philly Phantic, a resident of South Philadelphia consumes questionable meat",
                            "A very nice field, not Citizens Bank but I guess it will do",
                            "In a very touching story, two men stand close to a river so that they can take a photo"]
        let authors = ["Tom Martin", "P. Phanatic", "N. Field"]
        let images = [#imageLiteral(resourceName: "phinatic"), #imageLiteral(resourceName: "image"), #imageLiteral(resourceName: "justin")]
        let authImages = [#imageLiteral(resourceName: "justin"), #imageLiteral(resourceName: "phinatic"), #imageLiteral(resourceName: "image")]
        var data: [MaterialCardConfig] = []
        
        for i in 0..<titles.count {
            let title = titles[i]
            let author = authors[i]
            let image = images[i]
            let authImage = authImages[i]
            let description = descriptions[i]
            
            data.append(baseConfig.copyWithUpdates(dividerConfig: DividerConfig(divideImage: image), imageConfig: ImageConfig(image: authImage), headerConfig: HeaderConfig.init(header: title, subheader: author), descriptionConfig: DescriptionConfig(contentDescription: description)))
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
