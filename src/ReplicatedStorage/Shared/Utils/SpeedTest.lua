local function time(func,...)	
	local totalTime = 0
	
    local startTime = os.clock()
    func(...)
    
    local timeTaken = (os.clock() - startTime)
    totalTime += timeTaken
	warn("Total Time: "..totalTime)
end

return {
    ["TimeFunc"] = time
}