//
//  ViewController.swift
//  UIPlayground
//
//  Created by Tommy Martin on 5/2/18.
//  Copyright © 2018 Diamond Kinetics. All rights reserved.
//

import UIKit
import PineTar

class CardExampleViewController: UIViewController, CardAnimatorSource {    
    @IBOutlet weak var tableView: MaterialCardTableView!
    var sendingCard: MaterialCardView?
    
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

// TODO: Yea http://tobiashelmri.ch/swift,/ios/2016/12/08/hiding-the-status-bar-smoothly-in-ios-10.html
//class VC: UIViewController {
//    //  TODO: hide status bar on
//    var statusBarShouldBeHidden = false
//
//    func doStuff(hide: Bool) {
//        statusBarShouldBeHidden = hide
//
//        UIView.animate(withDuration: 0.25) {
//          self.setNeedsStatusBarAppearanceUpdate()
//        }
//    }
//
//    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
//        return .slide
//    }
//
//    override var prefersStatusBarHidden: Bool {
//        return statusBarShouldBeHidden
//    }
//}

