
import GameKit

protocol ArrayShufflerProtocol {
    func shuffle(array: Array<Any>) -> (Array<Any>)
}

class ArrayShuffler: ArrayShufflerProtocol {
    func shuffle(array: Array<Any>) -> (Array<Any>) {
        // Fisher-Yates Shuffle
        return GKRandomSource.sharedRandom().arrayByShufflingObjects(in: array)
    }
}
