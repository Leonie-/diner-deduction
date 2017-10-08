
import SpriteKit
/// Has a list of all the possible ingredients and all the possible positions for them to be in. Selects a designated number of ingredients from the total list randomly (currently this is always 3), and returns an array of tuples with information about their name, offsetX and offsetY.
/**
 Has a list of all the possible ingredients and all the possible positions for them to be in. Selects a designated number of ingredients from the total list randomly (currently this is always 3), and returns an array of tuples with information about their name, offsetX and offsetY.
 ### Parameters used on init(): ###
 * `totalIngredients` is the number of ingredients to randomly select (currently this is always passed in as 3).
 * `arrayShuffler` is an instance of the `ArrayShufflerProtocol`. It has been dependency injected to make it easier to unit test if automated tests are added at a later date.
 */
class IngredientsListGenerator {
    /// Creates an empty array of tuples to be populated with ingredient data on .init()
    var generate: Array<(String,CGFloat,CGFloat)> = []
    /// Generate an array with ingredient data
    init(totalIngredients: Int, arrayShuffler: ArrayShufflerProtocol) {
        
        let totalIngredients = totalIngredients
        let allIngredients: Array<(String)> = ["tomato", "pepper", "pineapple", "pepperoni", "mushroom", "olive"]
        let allIngredientPositions = [
            (offsetX: 140 as CGFloat, offsetY: 250 as CGFloat),
            (offsetX: 140 as CGFloat, offsetY: 180 as CGFloat),
            (offsetX: 550 as CGFloat, offsetY: 250 as CGFloat),
            (offsetX: 550 as CGFloat, offsetY: 180 as CGFloat)

        ];

        let shuffledIngredients = arrayShuffler.shuffle(array: allIngredients) as! Array<String>
        let ingredientsSlice:ArraySlice<String> = shuffledIngredients[0...totalIngredients]
        let chosenIngredients = Array<String>(ingredientsSlice)
        
        var ingredientCount = 0
        for ingredient in chosenIngredients {
            generate.append((
                type: ingredient,
                offsetX: allIngredientPositions[ingredientCount].offsetX,
                offsetY: allIngredientPositions[ingredientCount].offsetY
            ))
            ingredientCount += 1
        }
    }
    
}
