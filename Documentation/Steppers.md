#  Steppers

Steppers are an interesting one. Midway through my implementation of a Material-like stepper, Google revamped its Material Design documentation and pulled all mention of a Stepper. I would like to think that Google has things somewhat together, and if they pulled their support there is a good reason to do so. So, no fun link to the material website here and a word of caution. This is my interpretation of the stepper concept and a deviation from strict material. It is intended as a way to deviate from traditional forms and make gathering user input less daunting.

## Storyboard 
The Storyboard portion of this is simple. Add a ```UIView```  to the area that you want to be ocupied by your stepper. Generally, I think this would be the entire safe area of the ```UIViewController```. Then change its class to ```MaterialStepperView```. Unfortunately something in the Storyboard setup is broken so nothing appears as of now.

## Code
Once again, the code setup is minimal! First, add an outlet to your ```MaterialStepperView```

```
@IBOutlet weak var stepperView: MaterialStepperView!
```

Upon setup, you are going to need to do three things to customize your stepper. First, set the ```vc``` property of your ```stepperView``` to the current ```UIViewController```. This gives the stepper access to view controller level functions.
```
stepperView.vc = self
```

Next, you should add a completion for your stepper. After the user has completed giving all the requested information, this action will be performed. You get the results as a ```[Any?]``` that contains all of the information you requested.

```
stepperView.completion = {results in
    self.navigationController?.popViewController(animated: true)
}
```

Finally, you will need to specify what information you need to collect! this is done by adding ```Step```s to your ```stepperView```. Right now, we have four types of steps (as shown below). Custom steps can be created by superclassing the ```Step``` class. Examples can be seen in ```Step.swift```

```
let step1 = TextStep(skippable: false, text: "Full Name")
let step2 = ImageStep(skippable: false , text: "Profile Image")
let step3 = DateStep(skippable: true, text: "Birth Date") 
let step4 = NumberStep(skippable: false, text: "A number is needed")

stepperView.steps = [step1, step2, step3, step4]
```


## Example
Check out ```StepperExampleVC``` for help

