#  Cards 

If you are not familiar with the concept of material cards [check them out](https://material.io/design/components/cards.html#cards-usage)

## Storyboard
The Storyboard portion of this is simple. Add a ```UIView```  to the area that you want to be ocupied by your card. Then change its class to ```MaterialCardView``` and you should see the container and your card appear on the Storyboard. It is nothing too exciting to start, but you will notice a lot of additional options will appear in the Attribute Inspector

### Storyboard Inspectables

* Corner Radius - Pretty self explanitory 

#### Divide
The "divide" (subject to change) is the idea that often the card is divided into two vertical areas using a different background image or color to create this seperation
* Divide Offset - If the offset is not set, the divide automatically aligns at the top
* Divide Height - The height of the divide
* Divide Color - The background color of the divide
* Divide Image - Rather have a background image than a plain colored divide? Use the divide image

#### Image 
* Image
* Image Height - The height of the image 
* Image Width - The width of the image 
* Image Alignment - In lieu of listing the different alignments, check out the ```ImageAlignment``` enum for the differnet alignments or flip through values 0-6 to see what happens
* Image Style - Current styles  are 0. normal, 1. circle, 2. roundedCorners (all other values default to 0)
* Image Vert Offset - The vertical offset from the location determined by the image alignment
* Image Horz Offset - The horizontal offset from the location determined by the image alignment

#### Header
* Header - ```String``` displayed as the header 
* Header Color - Color of the header text
* Header Size - Font size for the header
* Header Alignment -  In lieu of listing the different alignments, check out the ```ImageAlignment``` enum for the differnet alignments or flip through values 0-6 to see what happens
* Header Vert Offset - The vertical offset from the location determined by the header alignment
* Header Horz Offset - The horizontal offset from the location determined by the header alignment

#### Subheader
* Subheader - ```String``` displayed as the header 
* Subheader Color - Color of the subheader text
* Subheader Size - Font size of the subheader

#### Content Description
* Content Description - The content description is meant to be a lengthier text that gives details about what you intend the card to convey 
* Content Description Offset - In the future, content description should have an alignment, similiar to the header, but for now it always aligns under the divider and can be moved using this offset
* Content Description Size - The font size of the content description
* Content Description Color - The color of the content description text 

### Adding Custom Content
I hope to improve this in the future, but for now you can either subclass the ```MaterialCardView``` class or add a subview in the storyboard 

## Types 
Different types of cards can be created as subclasses of the ```MaterialCardView```. Custom content can be added or defaults for the Inspectables can be added to create a certain look without having to modify the Inspectable values every time you add one to a storyboard.

### MaterialSocialCardView
The ```MaterialSocialCardView``` is intended to have the look and feel of a posted article on social media. It very closes mimics some of the default cards described by material design documentation

### Custom Cards
Unfortunately, we only have this one type of card right now, but you can use ```MaterialSocialCardView``` as a model to create your own custom card

