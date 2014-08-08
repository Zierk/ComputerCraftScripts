-- lava - Automatic Lava Refuel by zierk v1.07
-- http://www.vigilantaddiction.com
--
-- Any turtle: Slot 1 - Empty bucket
--
-- Place an empty bucket in Slot 1 and set the turtle facing the lava pool
--
-- Syntax: lava <distance> [drop]
--
-- The turtle will travel the specified distance scooping up lava below it
-- and automatically refueling from each bucket. The turtle will do a U-turn
-- and return back to start, also scooping lava on the return trip. If the
-- [drop] switch has a value the turtle will descend that many blocks before
-- attempting to scoop lava.
--
-- If the turtle is a mining turtle it will break blocks that block
-- its path along the way.
--
-- enjoy! (^_^)
 
local tArgs = { ... }
     
    if #tArgs == 0 then
      print("Usage: <blocks> [drop]")
      return
    end
     
    turtle.refuel()
     
    if turtle.getFuelLevel() == 0 then
      print("The turtle must have at least some fuel to start with.")
      return
    elseif turtle.getFuelLevel() == "unlimited" then
      print("This turtle does not use fuel to move")
      return
    end
     
    --Number of blocks to travel to get the lava
    local maxDistance = tArgs[1]
     
    --How deep to go to gather the lava
    local drop = 0
    if #tArgs >= 2 then
      drop = tonumber(tArgs[2])
    end  
     
    --local counter for how far the turtle has travle
    local traveled = 0
     
    --A helper function to try and move forward, it will attempt to dig if it is blocked.
    local function moveForward()
      if turtle.forward() == false then
        --Failed to move, see if we can dig our way forward
        while turtle.dig() do
              --Keep digging till we can't dig any more, in case gravel is falling.
            end
            if turtle.forward() == false then
              print("I am either blocked or out of fuel.")
              return false
            end
      end
      return true  
    end
     
    --A helper function to try and move down, it will attempt to dig if it is blocked.
    local function moveDown()
      if turtle.down() == false then
        --Failed to move, see if we can dig our way down
        turtle.digDown()
            if turtle.down() == false then
              print("I am either blocked or out of fuel.")
              return false
            end
      end
      return true  
    end
     
    --A helper function to try and move down, it will attempt to dig if it is blocked.
    local function moveUp()
      if turtle.up() == false then
        --Failed to move, see if we can dig our way down
        while turtle.digUp() do
              --Keep digging till we can't dig any more, in case gravel is falling.
            end
            if turtle.up() == false then
              print("I am either blocked or out of fuel.")
              return false
            end
      end
      return true  
    end
     
    dropDone = false
     
    --Attempt to travel to max distance for getting lava
    for i = 1, maxDistance do
      if moveForward() == false then
        print("Could not move forward the full requested distance, starting U-Turn early.")
            break
      end
      traveled = traveled + 1
     
      --drop to the requested depth
      if(dropDone == false) then
        for j = 1, drop do
              if moveDown() == false then
                print("Could not drop the full distance")
                    drop = j - 1
                    end
            end
            dropDone = true
      end
     
      --grab the fuel
      turtle.placeDown()
      if turtle.refuel() == false then
        --Whatever we picked up is invalid for fuel, put it back down
        turtle.placeDown()
      end
    end
     
    --Turn around move a block over and get more lava
    turtle.turnRight()
    moveForward()
    turtle.turnRight()
     
    --Travel back the same number of blocks we came
    for i = 1, traveled do
      turtle.placeDown()
      turtle.refuel()
     
      --Check to see if we need to go up yet
      if i == traveled then
        for j = 1, drop do
              moveUp()
            end
      end
     
      if moveForward() == false then
        --We are stuck, attempt to go up a level to get home
            if drop > 0 then
              repeat
                moveUp()
                drop = drop - 1
                    lastMove = moveForward()
              until lastMove == true or drop == 0
             
              if lastMove == false then
                print("I am stuck!")
              end
            end
      end
    end
     
    turtle.turnRight()
    moveForward()
    turtle.turnRight()