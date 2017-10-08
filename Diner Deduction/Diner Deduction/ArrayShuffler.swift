/**

Pass an Array<Any> in and it will rearrange the items in the array using a Fisher-Yates Shuffle.
This uses an object shuffler on GKRandomSource, which is part of GameKit.
 
 */


import GameKit


protocol ArrayShufflerProtocol {
    func shuffle(array: Array<Any>) -> (Array<Any>)
}

class ArrayShuffler: ArrayShufflerProtocol {
    func shuffle(array: Array<Any>) -> (Array<Any>) {
        return GKRandomSource.sharedRandom().arrayByShufflingObjects(in: array)
    }
}
