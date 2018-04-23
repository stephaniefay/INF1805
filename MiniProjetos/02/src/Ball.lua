function newBall ()

  local screenWidth, screenHeight = love.graphics.getDimensions( )

  local ballRadius = 10
  local ballSpeed = 350
  local dirX = -1 + love.math.random(0, 2)
  local dirY = -1
  local posX = screenWidth / 2 - ballRadius
  local posY = screenHeight - 80
  local id = totalCreated

  local update = function (self)
    while true do
      posX = posX + dirX * love.timer.getDelta() * ballSpeed
      posY = posY + dirY * love.timer.getDelta() * ballSpeed

      if posX < ballRadius then
        posX = ballRadius
        dirX = -dirX
      end

      if posX > screenWidth - ballRadius then
        posX = screenWidth - ballRadius
        dirX = -dirX
      end

      if posY < ballRadius then
        posY = ballRadius
        dirY = -dirY
      end

      if posY > screenHeight + 300 then
        if balls > 0 then
          resetBall(id)
        else
          lost = true
        end
      end

      if posY > paddlePosY - ballRadius and posY < paddlePosY + paddleHeight then
        if posX > paddlePosX - ballRadius and posX < paddlePosX + paddleWidth + ballRadius then
          posY = paddlePosY - ballRadius
          dirY = -dirY

          if paddleRight == true then
            dirX = dirX + 1
          elseif paddleLeft == true then
            dirX = dirX - 1
          end
        end
      end

      local bricksLeft = 0
      for j = 1, brickRows do
        for i = 1, brickCols do
          if bricks[j][i] == 1 then
            bricksLeft = bricksLeft + 1

            local bsx = (i - 1) * brickWidth - ballRadius
            local bex = i * brickWidth + ballRadius
            local bsy = (j - 1) * brickHeight - ballRadius
            local bey = j * brickHeight + ballRadius

            if posX > bsx and posX < bex and posY > bsy and posY < bey then
              bricks[j][i] = 0
              local r = love.math.random(1,4)
              if (r%2) == 0 then
                createBalls = 1
              end

              local bcx = (i - 1) * brickWidth + brickWidth / 2
              local bcy = (j - 1) * brickHeight + brickHeight / 2

              if posX < bcx and dirX > 0 then
                dirX = -dirX
              end

              if posX > bcx and dirX < 0 then
                dirX = -dirX
              end

              if posY < bcy and dirY > 0 then
                dirY = -dirY
              end

              if posY > bcy and dirY < 0 then
                dirY = -dirY
              end
            end
          end
        end
      end

      if bricksLeft == 0 then nextLevel() end

      coroutine.yield()
    end
  end

  local function draw()
    love.graphics.setColor(16, 16, 16, 255)
    love.graphics.circle("fill", posX, posY, ballRadius, 10)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.circle("fill", posX, posY, ballRadius - 2, 10)
  end
  
  function ballId ()
    return id
  end
  
  return {
    update = coroutine.wrap(update),
    ballId = ballId,
    draw = draw
  }
end
