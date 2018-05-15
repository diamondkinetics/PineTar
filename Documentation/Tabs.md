#  Tabs

If you are not familiar with material design tabs, [check them out](https://material.io/design/components/cards.html)

## Storyboard

### Adding the Tabs
The Storyboard portion of this is simple. Add a ```UIView```  to the area that you want to be ocupied by your tabs and the content dictated by the tabs. Then change its class to ```MaterialTabViewContainer``` and you should see the container and your tabs appear on the Storyboard!

### Adding the Content
In the storyboard, any content that you want in your tabs should be in seperate a ```UIViewController``` 

## Code
In the ```UIViewController``` containing your ```MaterialTabViewContainer```  add an outlet to your tab container
```
@IBOutlet weak var tabContainer: MaterialTabViewContainer!
```

Your ```UIViewController``` will have to conform to the ```MaterialTabViewDelegate``` protocol in order to add any content to your ```MaterialTabViewContainer```. Adding the following line should be all that is needed.

```
var viewController: UIViewController {return self}
```

You cannot add any tabs until you set your add a delegate to your ```MaterialTabViewContainer```
```
tabContainer.delegate = self
```

Finally, you can add ```UIViewControllers``` to your  ```MaterialTabViewContainer``` using its ```addViewControllers``` function. Below is an example from ```TabVCExample```

``` 
private func addViewControllersToTabContainer() {
    let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.init(for: type(of: self)))
    let vc = storyboard.instantiateViewController(withIdentifier: "SocialTileExample")
    let vc2 = storyboard.instantiateViewController(withIdentifier: "SimpleTileExample")
    let vc3 = storyboard.instantiateViewController(withIdentifier: "SocialTileExample")
    tabContainer.addViewControllers(controllers: [vc2, vc, vc3], labels: ["Item One", "Item Two", "Item Three"])
}
```



## Example
Check out ```TabVCExample``` for help
