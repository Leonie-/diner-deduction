protocol GameSceneDelegate {
    func menuScene()
    func gamePlayScene()
    func gameWonScene(previousGuesses: Int)
    func gameLostScene()
}
