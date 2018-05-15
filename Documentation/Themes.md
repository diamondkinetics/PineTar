#  Themes

Defining a Theme makes this library's UI components conform to colors and fonts defined by you. 

## Simple Theme
The first option is to use a ```SimpleTheme```. Simply create a ```struct``` that conforms to the ```SimpleTheme``` protocol XCode will prompt you to define the following
* ```primaryColor: UIColor``` - The color used for almost every component
* ```backgroundColor: UIColor``` - The background color throughout the application
* ```highlightColor: UIColor``` - used as a bright splash of color used in small places
* ```font: UIFont``` - what font will be used in all of our UI Components
* ```textColor: UIColor``` - probably doesn't merit explination

## Theme
If you want a little bit more control over colors, but still want us to do the work you can conform to a ```Theme``` instead of a  ```SimpleTheme```. Now you are forced to define 

* ```titleColor: UIColor``` - Want your titles to stick out? Make them a different color!
* ```textHighlightColor: UIColor``` - Usually text on buttons, tabs, etc., will use the highlightColor. Deviate from this with ```textHightlightColor```
* ```buttonsAreHighlightColor: Bool``` - Does your buttons being your ```primaryColor``` not quite work out? Well use this to make buttons use your ```hightlightColor```. Works great for darker themes

## Applying Themes
Applying your theme is simple! Simply use the following line with your own theme
```
ThemeManager.setTheme(theme: MyTheme())
```
Generally, this can be applied in ```didFinishLaunchingWithOptions``` so that it can be applied throughout your application. Don't forget that you can use the ```ThemeManager``` in your own custom components.

## Storyboard Support
Unfortunately, in order to get your custom theme to show up in Storyboard, you will have to create your own custom superclass to our components. All these classes will need is to be ```@IBDesignable``` class that sets your theme in ```prepareForInterfaceBuilder```



