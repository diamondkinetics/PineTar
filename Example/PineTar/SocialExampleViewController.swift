//
//  PineTar_Example
//  SocialExampleViewController.swift
//
//  Created by Tommy Martin on 5/8/18.
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
        let images = [#imageLiteral(resourceName: "woman"), #imageLiteral(resourceName: "plane"), #imageLiteral(resourceName: "tree")]
        let authImages = [#imageLiteral(resourceName: "tree"), #imageLiteral(resourceName: "woman"), #imageLiteral(resourceName: "plane")]
        var data: [MaterialCardConfig] = []
        
        for i in 0..<titles.count {
            let title = titles[i]
            let author = authors[i]
            let image = images[i]
            let authImage = authImages[i]
            let description = descriptions[i]
            
            data.append(baseConfig.copyWithUpdates(dividerConfig: DividerConfig(divideImage: image), imageConfig: ImageConfig(image: authImage), headerConfig: HeaderConfig.init(header: title, subheader: author), descriptionConfig: DescriptionConfig(contentDescription: description)))
        }
        
        tableView.cellHeight = 275
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
