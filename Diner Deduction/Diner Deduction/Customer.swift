//
//  CoreGameLogic.swift
//  Diner Deduction
//
//  Created by Leonie Kenyon on 19/09/2017.
//  Copyright © 2017 Leonie Kenyon. All rights reserved.
//

import SpriteKit

class Customer {
    private var correctIngredients: Set<String>
    
    init(ingredients: Array<(String,CGFloat)>, totalIngredients: Int, arrayShuffler: ArrayShufflerProtocol) {
        
        let totalIngredients = totalIngredients - 1
        
        if (totalIngredients > ingredients.count) {
            print("Number to select was longer than the total list of ingredients")
        }
        
        func getIngredientType(type:String, offsetX:CGFloat) -> String {
            return type
        }
        
	    let ingredientsByType = ingredients.map(getIngredientType)
        let shuffledIngredientsByType = arrayShuffler.shuffle(array: ingredientsByType) as! Array<String>
        let ingredientsSlice:ArraySlice<String> = shuffledIngredientsByType[0...totalIngredients]
        correctIngredients = Set<String>(ingredientsSlice)

        print("correctIngredients")
        print(correctIngredients)

        NotificationCenter.default.addObserver(self, selector: #selector(checkIngredients), name:Notification.Name("PizzaSubmitted"), object: nil)
    }
    
    @objc func checkIngredients(_ notification: Notification) {
        if let ingredientsToCheck = notification.userInfo?["currentIngredients"] as? Set<String> {
            print(ingredientsToCheck)
            if ingredientsToCheck == correctIngredients {
                NotificationCenter.default.post(name:Notification.Name("GameWon"), object: nil)
            }
            else {
                NotificationCenter.default.post(name:Notification.Name("GameFailed"), object: nil)
            }
        }
    }
}
