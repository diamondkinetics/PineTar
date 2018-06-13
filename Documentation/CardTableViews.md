#  Card Table View

Frequently when you are presenting a card, you do not want just one. You want a list a similiar looking cards. The ```MaterialCardTableView``` allows you to do so simply

## Storyboard
The storyboard is pretty simple. Add a ```UITableView``` to your ```UIViewController``` and change its class to ```MaterialCardTableView```. Then create a cell with the identifier "cell". Add a ```MaterialCardView``` as a subview and customize it however you want.

## Code

Within your ```UIViewController``` you'll need an outlet to your table view
```
@IBOutlet weak var tableView: MaterialCardTableView!
```
In order to add content to your table view, you will have to set ```data``` on your ```MaterialCardTableView``` instance with an array of ```MaterialCardConfig```s. In order to do this you will want to get the default config (the look of your card as defined in the Storyboard). As long as you have a ```MaterialCardView``` in the cell on your storyboard, the line below will automatically get your config.

```
let baseConfig = tableView.getDefaultCardConfig()
```

Once you have this configuration, you can use it to create custom configs for each cell you want to display. You can modify and of the ```MaterialCardView``` inspectables using the ```MaterialCardConfig``` ```copyWithUpdates``` function as below

```
let config1 = baseConfig.copyWithUpdates(dividerConfig: DividerConfig.init(divideImage: image), headerConfig: HeaderConfig(header: title))
```

Set the  ```MaterialCardTableView``` data with the custom configs for each cell
```
tableView.data = [config1, config2, config3, config4, config5]
```

If you want to change the height of each cell, you can modify it as follows. Otherwise it will default to 300
```
tableView.cellHeight = 150
```

## DetailVC 
You will notice in the example application that if you press on a ```MaterialCardView``` within my any ```CardTableView``` it will transistion into a view with the contents of the ```MaterialCardView``` as the header. Using PineTar, you can get that transistion for free, utilizing a ```DetailPresentingVC```.  ```DetailPresentingVC``` is a protocol made to extend your ```UIViewController``` that adds the following property to your ```UIViewController```

```
var animatorSource: CardAnimatorSourceVC?
```

Theis property is used to provide information needed for the animation to ```DetailVC```. ```CardAnimatorSourceVC``` is the ```UIViewController``` whose status bar you would want to hide as you transition into the ```DetailVC```. In the example case, it is ```TabVCExample```, but in a non-tabbed example it would be the current ```UIViewController```. In the example app, ```TabExampleVC``` is a ```CardAnimatorSourceVC``` and as you initialize the ```UIViewControllers``` to load into your tab view, adding the below code hides ```TabExampleVC```'s status bar. Note that for the best animation results, you should add  ```View controller-based status bar appearance``` with the value ```YES``` to your Info.plist.

```
vc.animatorSource = self
```

Finally, you can use the ```DetailPresentingVC``` function to show the ```DetailVC```. For example if you want to present ```DetailVC``` when a card in a ```MaterialCardTableView``` is pressed:

```
tableView.cardPressedAction = {card in
    let view = UINib(nibName: "DetailContent", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    self.presentDetailVC(fromCard: card, withContentView: view)
}
```
