
import SpriteKit
/**
 The Customer selects the correct ingredients from a list of the available ingredients. It listens for the "PizzaSubmitted" event, compares the submitted ingredients to the correct ingredients, then posts either a "GameWon" or "GameFailed" notification. Please note that "GameFailed" is not the same as "GameLost" - "GameFailed" denotes an incorrect guess and the game continues. Only the expired timer posts a "GameLost" notification.
 ### Parameters used on init(): ###
 * `ingredients` is an array of the ingredients available to the customer.
 * `totalIngredients` is the number of ingredients the player needs to be add to make a guess.
 * `arrayShuffler` is an instance of the `ArrayShufflerProtocol`. It has been dependency injected to make it easier to unit test if automated tests are added at a later date.
 */
class Customer {
    /// Correct ingredients as a set.
    private var correctIngredients: Set<String>
    ///
    init(ingredients: Array<(String,CGFloat,CGFloat)>, totalIngredients: Int, arrayShuffler: ArrayShufflerProtocol) {
        
        let totalIngredients = totalIngredients - 1
        
        if (totalIngredients > ingredients.count) {
            print("Number to select was longer than the total list of ingredients")
        }
        
        func getIngredientType(type:String, offsetX:CGFloat, offsetY:CGFloat) -> String {
            return type
        }
        
	    let ingredientsByType = ingredients.map(getIngredientType)
        let shuffledIngredientsByType = arrayShuffler.shuffle(array: ingredientsByType) as! Array<String>
        let ingredientsSlice:ArraySlice<String> = shuffledIngredientsByType[0...totalIngredients]
        correctIngredients = Set<String>(ingredientsSlice)

        print("The correct ingredients are...", correctIngredients)

        NotificationCenter.default.addObserver(self, selector: #selector(checkIngredients), name:Notification.Name("PizzaSubmitted"), object: nil)
    }
    /// This method is called in response to receiving a `PizzaSubmitted` notification, and posts either a `GameWon` or `GameFailed` notification depending on if the guess is correct or not.
    @objc func checkIngredients(_ notification: Notification) {
        if let ingredientsToCheck = notification.userInfo?["currentIngredients"] as? Set<String> {
            print("Ingredients you picked are...", ingredientsToCheck)
            if ingredientsToCheck == correctIngredients {
                NotificationCenter.default.post(name:Notification.Name("GameWon"), object: nil)
            }
            else {
                let itemsCorrect:Set<String> = ingredientsToCheck.intersection(correctIngredients)
                NotificationCenter.default.post(name:Notification.Name("GameFailed"), object: nil, userInfo: [
                    "numberOfItemsCorrect": itemsCorrect.count,
                    "itemsGuessed": ingredientsToCheck
                ])
            }
        }
    }
}
