#  Themes

Defining a Theme makes this library's UI components conform to colors and fonts defined by you. These themes are meant to be an implementation of [Material Design's color system](https://material.io/design/color/the-color-system.html).

## Simple Theme
The first option is to use a ```SimpleTheme```. Simply create a ```struct``` that conforms to the ```SimpleTheme``` protocol and XCode will prompt you to define the following
* ```primaryColor: UIColor``` - The color used for almost every component
* ```backgroundColor: UIColor``` - The background color throughout the application
* ```onPrimaryColor: UIColor``` - The color used for text or symbols that appear somewhere with a primary color backgroun. It should be readable against your primary color
* ```onBackgroundColor: UIColor``` - The color used for text or symbols that appear somewhere with a backgroundColor background
* ```font: UIFont``` - The font that will be used in all library UI Components

## Theme
If you want a little bit more control over colors, but still want us to do the work you can conform to a ```Theme``` instead of a  ```SimpleTheme```. Now you are forced to define 

* ```secondaryColor: UIColor?``` -  The secondary color is meant to complement your primary color for smaller components
* ```surfaceColor: UIColor``` - Your surface color is the default background color for your raised surfaces, such as cards 
* ```errorColor: UIColor``` - If there are issues in your application, the user can be alerted in a consistent manner using the error color to highlight the issue
* ```onSurfaceColor: UIColor``` - on surface color is a color used for text or symbols that appear somewhere with a surface color background. It should be readable against your surface color
* ```onErrorColor: UIColor``` - see above, just think error color
* ```onSecondaryColor: UIColor?``` - see above, just think secondary color

## Applying Themes
Applying your theme is simple! Simply use the following line with your own theme
```
ThemeManager.setTheme(theme: MyTheme())
```
In order to get more out of your secondary color, try setting ```useSecondaryColorForButtons``` to true
```
ThemeManager.useSecondaryColorForButtons = true
```

Generally, these can be applied in ```didFinishLaunchingWithOptions``` so that it can be applied throughout your application. Don't forget that you can use the ```ThemeManager``` in your own custom components.

## Storyboard Support
Unfortunately, in order to get your custom theme to show up in Storyboard, you will have to create your own custom superclass to our components. All these classes will need is to be ```@IBDesignable``` class that sets your theme in ```prepareForInterfaceBuilder```



