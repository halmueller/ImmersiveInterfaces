let wait = SKAction.waitForDuration(1.0, withRange: 0.05)
let pause = SKAction.waitForDuration(0.55, withRange: 0.05)

let left = SKAction.runBlock { fireCannon(leftBalloonCannon) }
let right = SKAction.runBlock { fireCannon(rightBalloonCannon) }

let leftFire = SKAction.sequence([wait, left, pause, left, pause, left, wait])
let rightFire = SKAction.sequence([pause, right, pause, right, pause, right, wait])
