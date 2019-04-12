FoodOnClick

1.    Introduction 

“Food on Click” iOS application is about providing nearest restaurants suggestion for selected food item. You can find restaurants by clicking the pictures of food or uploading the picture in an app. This way if you are unaware of one food item then it will tell you the name of that food item and by selecting the option restaurants, it will yield information.

2.    Requirements
2.1    Frame Works
•    CoreData
•    CoreML

2.2    CoreML model
•    Food101.mlmodel

3.    Files includes with this project
3.1    Swift Files
•    HomeViewController.swift
•    HistroyViewController.swift
•    RestaurantViewController.swift
•    Searches+CoreDataClass.swift
•    Searches+CoreDataProperties.swift
•    UIImage+PixelBuffer.swift
•    PersistenceService.swift
•    AppDelegate.swift

3.2    Coredata Files
•    FoodOnClickDataModel.xcdatamodeld

4.    How to run
•    Install the pod file.
•    Place the Food101.mlmodel file in the root FoodOnClick project folder.
•    Open FoodOnClick.xcworkspace file and build the project.

5.    How to use
•    Click on the button “Pick a food”
•    Select an option between “taking a photo” or “uploading a photo”
•    If selected option is “taking a photo”, user will be redirect to camera and click a picture of the food item.
•    If selected option is “uploading a photo”, user will be redirected to photo gallery where he/she can pick a food item.
•    After picking the photo, user can now see the selected image on the home screen with the predicted name of it.
•    Now user can click button named restaurant and will see the nearest restaurants near him/her where the food item is offered.
•    User can also see the list of his/her previous searches by clicking the button named “Recent Searches”
