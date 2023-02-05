#  PetFinder

You will need to have a developer api key in order to work on this project.

To obtain the key:
      
    visit: https://www.petfinder.com/developers/
    Signup as a developer and receive back CLIENT_ID & CLIENT_SECRET values.
    
Create a local xcconfig file inside the PetFinder directory: 
    
projectDir/PetFinder/PetfinderApiConfig.xcconfig
    
    example:
        //
        //  PetfinderApiConfig.xcconfig
        //  PetFinder
        //
        //  Created by Justin Maronde on 9/19/22.
        //

        // Configuration settings file format documentation can be found at:
        // https://help.apple.com/xcode/#/dev745c5c974
        CLIENT_ID = "_CLIENT_ID_PLACEHOLDER_"
        CLIENT_SECRET = "_CLIENT_SECRET_PLACEHOLDER_"

    The file should never be included in the source code and is currently already included in our global .gitignore
    
Credit to:
Vitaly Gorbachev - Cat Icon
deemakaksina - Dog Icon
Freepik - Rabbit, Horse, Bird, Cow, Guinea Pig Icons
Those Icons - Fish Icon
