function findDistance(pos_1, pos_2)
    local x = math.abs(pos_2[1] - pos_1[1])
    local y = math.abs(pos_2[2] - pos_1[2])
    return math.sqrt(x^2 + y^2)
end

function checkCollusion(info1, info2)
    local x1 = info1[1]
    local y1 = info1[2]
    local w1 = info1[3]
    local h1 = info1[4]
    
    local x2 = info2[1]
    local y2 = info2[2]
    local w2 = info2[3]
    local h2 = info2[4]
    return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end



function findDir(entity, target, speed)
    local x1, y1 = entity[1], entity[2] 
    local x2, y2 = target[1], target[2]
    local angle = math.atan2(y2 - y1, x2 - x1)
    return {math.cos(angle) * speed, math.sin(angle) * speed}
end

function setColor(color)
    if color[4] ~= nill then
        love.graphics.setColor(color[1], color[2], color[3], color[4])
    else
        love.graphics.setColor(color[1], color[2], color[3])
    end
end

function rotateTo(from, to, dir)
    --right = 0, up = 90, left = 180, down = 270
    local x1, y1 = from[1], from[2]
    local x2, y2 = to[1], to[2]
    local d_x,d_y,angle
    d_x, d_y = x1- x2, y1-y2
    return math.deg(math.atan2(-d_y, d_x)) - dir
end
function getImageScaleForNewDimensions( image, newWidth, newHeight )
    local currentWidth, currentHeight = image:getDimensions()
    return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end

function findAngle(pos1, pos2) 
    return math.atan2(pos2[2] - pos1[2], pos2[2] - pos1[1])
end

function rotateVector(Vector, angle)
    local x = Vector[1] * math.cos(angle) - Vector[2] * math.sin(angle)
    local y = Vector[1] * math.sin(angle) + Vector[2] * math.cos(angle)
    return x,y
end


function addSpace(list)
    local info = ''
    for _, i in ipairs(list) do
        if _ == 1 then
            info = tostring(i)
        else
            info = info .. '-' .. tostring(i)
        end
    end
    return info
end

function split(s, delimiter)
	local result = {}
	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end
	return result
end
toboolean={ ["true"]=true, ["false"]=false, ['False']=false, ['True']=true }

function inList (val, list)
    for index, value in ipairs(list) do
        if value == val then
            return true
        end
    end
    return false
end


function fileExists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
  end

  function readFile(file)
    if not fileExists(file) then return {} end
    local lines = {}
    for line in io.lines(file) do 
      lines[#lines + 1] = line
    end
    return lines
  end

function writeFile(file, txt)
    local file = io.open(file, "a")
    file:write(txt, "\n")
end
function clearFile(file)
    io.open(file,"w"):close()
end

function scandir(directory)
    local  list, popen =  {}, io.popen
    local pfile = popen('ls -a "'..directory..'"')

    for filename in pfile:lines() do
        table.insert(list, filename)
    end
    pfile:close()
    return list
end
function moveFile(from ,to)
    os.rename(from,to)
end

function intoCode(code)
    local list = {'h', "l", "b", 'r', "o", "f", 'a', "m", "n", "j", "-"}
    local nums = {0, 1,2, 3,4,5,6,7,8,9, "%."}
    local text = code
    for _, i in ipairs(list) do
        text = text:gsub(nums[_], i)
    end
    return text
end

function fromCode(code)
    local list = {'h', "l", "b", 'r', "o", "f", 'a', "m", "n", "j", "-"}
    local nums = {0, 1,2, 3,4,5,6,7,8,9, "%."}
    local text = code
    for _, i in ipairs(nums) do
        text = text:gsub(list[_],tostring(i))
    end
    return text
end
