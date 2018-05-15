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

class SocialExampleViewController: UIViewController, CardAnimatorSource {
    @IBOutlet weak var tableView: MaterialCardTableView!
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
            self.performSegue(withIdentifier: "PRESENT_DETAILS", sender: card)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PRESENT_DETAILS" {
            let vc = segue.destination as! DetailsVC
            let config = MaterialCardConfig(card: sender as! MaterialCardView)
            vc.cardConfig = config
        }
    }
}
