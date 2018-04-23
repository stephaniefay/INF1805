require "Ball"

local screenWidth = 800
local screenHeight = 600

finished = false
lost = false

paddleWidth = 80
paddleHeight = 20
paddleSpeed = 750
paddlePosX = screenWidth / 2 - paddleWidth / 2
paddlePosY = screenHeight - 60
local paddleLeft
local paddleRight

local ballsList = {}
totalCreated = 0
createBalls = 0

brickWidth = 40
brickHeight = 30
brickRows = 10
brickCols = 20
bricks = {}

currentLevel = 1
local levels = {
  {
    { 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
    { 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1 },
    { 0,0,1,0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,1,0 },
    { 1,0,0,1,0,1,0,0,0,1,0,1,0,0,0,1,0,1,0,1 },
    { 0,1,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,1,0 },
    { 0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0 },
    { 0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0 },
    { 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0 },
    { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
    { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 }
  },
  {
    { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
    { 0,1,1,0,1,1,0,0,0,1,1,0,0,0,1,1,0,1,1,0 },
    { 0,1,1,1,1,1,0,0,1,1,1,1,0,0,1,1,1,1,1,0 },
    { 0,0,1,1,1,0,0,0,1,1,1,1,0,0,0,1,1,1,0,0 },
    { 0,0,0,1,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0 },
    { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
    { 1,1,0,0,1,1,0,1,1,0,0,1,1,0,1,1,0,0,1,1 },
    { 1,1,1,0,1,1,1,1,1,0,0,1,1,1,1,1,0,1,1,1 },
    { 1,1,1,0,0,1,1,1,0,0,0,0,1,1,1,0,0,1,1,1 },
    { 1,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,1,1 }
  },
  {
    { 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
    { 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 },
    { 1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,1 },
    { 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 },
    { 1,0,1,0,0,0,1,1,1,1,0,1,0,1,0,1,1,1,0,1 },
    { 1,0,1,0,0,0,1,0,0,1,0,1,0,1,0,1,0,0,0,1 },
    { 1,0,1,0,0,0,1,0,0,1,0,1,0,1,0,1,1,1,0,1 },
    { 1,0,1,0,0,0,1,0,0,1,0,1,0,1,0,1,0,0,0,1 },
    { 1,0,1,1,1,0,1,1,1,1,0,0,1,0,0,1,1,1,0,1 },
    { 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 }
  }

}

local colors = {
  { 255, 0, 0, 255 },
  { 255, 128, 0, 255 },
  { 255, 255, 0, 255 },
  { 128, 255, 0, 255 },
  { 0, 255, 0, 255 },
  { 0, 255, 128, 255 },
  { 0, 255, 255, 255 },
  { 0, 128, 255, 255 },
  { 0, 0, 255, 255 },
  { 128, 0, 255, 255 },
  { 255, 0, 255, 255 },
  { 255, 0, 128, 255 },
}

function love.load()
  love.window.setTitle("INF1805 - Brick Breaker")
  love.graphics.setBackgroundColor(0, 0, 0)

  for j = 1, brickRows do
    bricks[j] = {}
    for i = 1, brickCols do
      bricks[j][i] = 0
    end
  end

  resetGame()
end

function createBall()
  totalCreated = totalCreated + 1
  table.insert(ballsList, newBall())
  ballsList[#ballsList]:update()

end

function resetBall(index)
  if next(ballsList) == nil then
    createBall()
  else
    for i = 1, #ballsList do
      
      if ballsList[i] == nil then
        return false
      end
      
      local temp = ballsList[i]:ballId()
      if (temp == index) then
        table.remove(ballsList, i)
      end
    end
    if next(ballsList) == nil then
      balls = balls - 1
      resetPaddle()
      createBall()
    end
  end
end

function resetPaddle()
  paddlePosX = screenWidth / 2 - paddleWidth / 2
  paddlePosY = screenHeight - 60
  paddleLeft = false
  paddleRight = false
end

function resetLevel()
  for j = 1, brickRows do
    for i = 1, brickCols do
      bricks[j][i] = levels[currentLevel][j][i]
    end
  end
end

function nextLevel()
  currentLevel = currentLevel + 1

  if currentLevel > #levels then
    finished = true
  else
    resetLevel()
    resetPaddle()
  end
end

function resetGame()
  finished = false
  lost = false
  balls = 5
  resetLevel()
  resetBall()
  resetPaddle()
end

function love.keypressed(key)
  if key == "left" then paddleLeft = true end
  if key == "right" then paddleRight = true end
end

function love.keyreleased(key)
  if key == "escape" then love.event.quit() end
  if key == "left" then paddleLeft = false end
  if key == "right" then paddleRight = false end
  if key == "return" and (finished == true or lost == true) then resetGame() end
end

function love.update(dt)
  if finished == true or lost == true then return end

  if paddleLeft == true then paddlePosX = paddlePosX - dt * paddleSpeed end
  if paddleRight == true then paddlePosX = paddlePosX + dt * paddleSpeed end

  if paddlePosX < 0 then paddlePosX = 0 end
  if paddlePosX > screenWidth - paddleWidth then paddlePosX = screenWidth - paddleWidth end

  for i = 1, #ballsList do
    if ballsList[i] ~= nil then
      ballsList[i]:update()
    end
    
    if createBalls == 1 then
      createBalls = 0
      createBall()
    end
  end

end

function love.draw()
  if finished == true then
    local y = screenHeight / 2 - (7 * 30) / 2
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf("Congratulations! You have won the game!", 0, y, screenWidth, "center")
    love.graphics.printf("Balls: " .. balls, 0, y + 3 * 30, screenWidth, "center")
    love.graphics.printf("Press ENTER to restart the game", 0, y + 6 * 30, screenWidth, "center")
    return
  end

  if lost == true then
    local y = screenHeight / 2 - (5 * 30) / 2
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf("Unfortunately, you have lost the game!", 0, y, screenWidth, "center")
    love.graphics.printf("Press ENTER to restart the game", 0, y + 4 * 30, screenWidth, "center")
    return
  end

  local c

  for j = 1, brickRows do
    c = 1

    for i = 1, brickCols do
      if bricks[j][i] == 1 then
        love.graphics.setColor(16, 16, 16, 255)
        love.graphics.rectangle("fill", (i - 1) * brickWidth, (j - 1) * brickHeight, brickWidth, brickHeight)
        love.graphics.setColor(colors[c])
        love.graphics.rectangle("fill", (i - 1) * brickWidth + 2, (j - 1) * brickHeight + 2, brickWidth - 4, brickHeight - 4)
      end

      c = c + 1
      c = c > 12 and 1 or c
    end
  end

  for i = 1, #ballsList do 
    ballsList[i].draw()
  end

   love.graphics.setColor(16, 16, 16, 255)
  love.graphics.rectangle("fill", paddlePosX, paddlePosY, paddleWidth, paddleHeight)
  love.graphics.setColor(0, 128, 255, 255)
  love.graphics.rectangle("fill", paddlePosX + 2, paddlePosY + 2, paddleWidth - 4, paddleHeight - 4)

  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf("Balls: " .. balls, -10, screenHeight - 30, screenWidth, "right")
end