-- tupdater - Custom Turtle Program Updater by zierk v1.2
-- http://www.vigilantaddiction.com
--
-- Custom program to automatically update a specific set of programs
--
-- Standard issue programs for all mining turtles @ Z-Corp
 
local tArgs = {...}
 
local updateProg= {}
updateProg[1] = { "lava", "8SjnrPUz" }
updateProg[2] = { "wall", "fcEKRJhU" }
updateProg[3] = { "floor", "cAuaDips" }
updateProg[4] = { "room", "Gcx4pbx8" }
updateProg[5] = { "quarry-setup", "BKZsen2s" }
updateProg[6] = { "ztunnel", "CkKMRfzG"}
 
function main()
   local count = table.getn(updateProg)
   
   for x = 1, count do
     shell.run("rm", updateProg[x][1])
     shell.run("pastebin", "get", updateProg[x][2], updateProg[x][1])
   end
end
 
if #tArgs ==1 then
   if tArgs[1] == "update" then
      shell.run("rm", "tupdater")
      shell.run("pastebin", "get", "aYTXuwDN", "tupdater")
      shell.run("clear")
      print(shell.getRunningProgram().." updated.")
   end
   return
end
 
 
main()