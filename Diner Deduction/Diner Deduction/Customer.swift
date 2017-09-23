//
//  CoreGameLogic.swift
//  Diner Deduction
//
//  Created by Leonie Kenyon on 19/09/2017.
//  Copyright © 2017 Leonie Kenyon. All rights reserved.
//

import SpriteKit

class Customer {
    private var correctIngredients: Array<Any>
    
    init(ingredients: Array<(String,CGFloat)>, totalIngredients: Int, arrayShuffler: ArrayShufflerProtocol) {
        
        if (totalIngredients > ingredients.count) {
            print("Number to select was longer than the total list of ingredients")
        }
        
        func getIngredientType(type:String, offsetX:CGFloat) -> String {
            return type
        }
        
        let shuffledIngredientsByType = arrayShuffler.shuffle(array: ingredients.map(getIngredientType))
        let ingredientsSlice = shuffledIngredientsByType[0...totalIngredients]
        correctIngredients = Array(ingredientsSlice)
        
        
        
//        correctIngredients = Set(correctIngredientsArray.map { $0 })
        
        print("correctIngredients")
        print(correctIngredients)

        NotificationCenter.default.addObserver(self, selector: #selector(checkIngredients), name:Notification.Name("PizzaSubmitted"), object: nil)
    }
    
    @objc func checkIngredients(_ notification: Notification) {
        print("Checking...")
        if let ingredientsToCheck = notification.userInfo?["currentIngredients"] as? Set<String> {
            print(ingredientsToCheck)
            
//            if ingredientsToCheck == correctIngredients {
//                print("Game won");
//            }
            
        }
    }
}
