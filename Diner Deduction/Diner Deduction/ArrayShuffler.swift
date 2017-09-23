
import GameKit

protocol ArrayShufflerProtocol {
    func shuffle(array: Array<Any>) -> (Array<Any>)
}

class ArrayShuffler: ArrayShufflerProtocol {
    func shuffle(array: Array<Any>) -> (Array<Any>) {
        return GKRandomSource.sharedRandom().arrayByShufflingObjects(in: array)
    }
}
