local function handle_intersection(input)
	local args = string.split(input, " ")

	if #args < 7 then
		warn("Erreur : nmb arg")
		return
	end
	
	local opt = tonumber(args[1])
	local xp, yp, zp = tonumber(args[2]), tonumber(args[3]), tonumber(args[4])
	local xv, yv, zv = tonumber(args[5]), tonumber(args[6]), tonumber(args[7])
	local p = tonumber(args[8])

	if not opt or not xp or not yp or not zp or not xv or not yv or not zv or not p then
		warn("Error arg")
		return
	end

	local a, b, c = 0, 0, 0
	
	-- 1 = sphere, 2 = cylindre, 3 = cone
	
	if opt == 1 then
		a = xv^2 + yv^2 + zv^2
		b = 2 * (xp*xv + yp*yv + zp*zv)
		c = xp^2 + yp^2 + zp^2 - p^2
	elseif opt == 2 then 
		a = xv^2 + yv^2
		b = 2 * (xp*xv + yp*yv)
		c = xp^2 + yp^2 - p^2
	elseif opt == 3 then 
		local rad = math.rad(p)
		local tan_sq = math.tan(rad)^2
		a = xv^2 + yv^2 - (zv^2 * tan_sq)
		b = 2 * (xp*xv + yp*yv - (zp*zv * tan_sq))
		c = xp^2 + yp^2 - (zp^2 * tan_sq)
	else
		warn("Error opt")
		return
	end
	-- %.3f = 3 chiffre apres la virgule
	-- 1e-9 = 10^-9
	if math.abs(a) < 1e-9 then
		if math.abs(b) < 1e-9 then
			print("Infini de point d'inter")
		else
			local t = -c / b
			print("1 p d'inter")
				print(string.format("(%.3f, %.3f, %.3f)", xp + t*xv, yp + t*yv, zp + t*zv))
		end
	else
		local delta = b^2 - 4*a*c
		if delta < 0 then
			print("no p d'inter")
		elseif math.abs(delta) < 1e-9 then
			local t = -b / (2*a)
			print("1 p d'inter")
			print(string.format("(%.3f, %.3f, %.3f)", xp + t*xv, yp + t*yv, zp + t*zv))
		else
			local t1 = (-b - math.sqrt(delta)) / (2*a)
			local t2 = (-b + math.sqrt(delta)) / (2*a)
			print("2 p d'inter")
				print(string.format("(%.3f, %.3f, %.3f)", xp + t1*xv, yp + t1*yv, zp + t1*zv))
				print(string.format("(%.3f, %.3f, %.3f)", xp + t2*xv, yp + t2*yv, zp + t2*zv))
		end
	end
end

local function main()
	local test_input = "1 4 0 3 0 0 -2 4"
	handle_intersection(test_input)
end

main()