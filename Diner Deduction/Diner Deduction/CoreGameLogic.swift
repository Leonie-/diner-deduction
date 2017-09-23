//
//  CoreGameLogic.swift
//  Diner Deduction
//
//  Created by Leonie Kenyon on 19/09/2017.
//  Copyright © 2017 Leonie Kenyon. All rights reserved.
//

import SpriteKit

class CoreGameLogic {
    
    private var correctIngredients: ArraySlice<(String,CGFloat)>
    
    init(ingredients: Array<(String,CGFloat)>, totalIngredients: Int, arrayShuffler: ArrayShufflerProtocol) {
        
        if (totalIngredients > ingredients.count) {
            print("Number to select was longer than the total list of ingredients")
        }
        
        let shuffledIngredients = arrayShuffler.shuffle(array: ingredients)
        let selectionOfIngredients:Array<(String, CGFloat)> = shuffledIngredients as! Array<(String, CGFloat)>
        correctIngredients = selectionOfIngredients[0...totalIngredients]
    }
}
