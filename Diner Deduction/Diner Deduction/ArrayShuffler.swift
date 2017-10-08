import GameKit

/// Protocol for the `ArrayShuffler`.
protocol ArrayShufflerProtocol {
    ///
    func shuffle(array: Array<Any>) -> (Array<Any>)
}

///Pass in an array and it will rearrange the items in the array using a Fisher-Yates Shuffle. This implements an object shuffler on `GKRandomSource`, which is part of `GameKit`.
class ArrayShuffler: ArrayShufflerProtocol {
    func shuffle(array: Array<Any>) -> (Array<Any>) {
        return GKRandomSource.sharedRandom().arrayByShufflingObjects(in: array)
    }
}
