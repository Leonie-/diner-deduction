/// Delegate to switch between scenes in the game.
protocol GameSceneDelegate {
    /// Switch to the menu scene
    func menuScene()
    /// Switch to the main game play scene
    func gamePlayScene()
    /// Switch to the game won scene and pass the number of guesses
    func gameWonScene(previousGuesses: Int)
    /// Switch to the game lost scene
    func gameLostScene()
}
