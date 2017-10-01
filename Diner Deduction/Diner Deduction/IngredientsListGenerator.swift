
import SpriteKit

class IngredientsListGenerator {
    var generate: Array<(String,CGFloat,CGFloat)> = []
    
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
        
        print("The chosen ingredients are...", generate)
    }
    
}
