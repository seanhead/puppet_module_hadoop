# cloud_dirs.rb

Facter.add("cloud_dirs") do
        setcode do
                hdcount = %x{fdisk -l 2> /dev/null | grep "Disk" | cut -d: -f1 | cut -d" " -f2}.split("\n").size
		
		if (hdcount < 2 )
			cloud_dirs = "/disk00"
		else
			i = 0
			cloud_dirs = []
			while i < (hdcount - 1)  do
				num = i
				if (num.to_s.length < 2)
					num = "0" + num.to_s	
				else
					num = num.to_s
				end

				cloud_dirs.push("/disk#{num}")

				i += 1;
			end
			cloud_dirs.join(',')
	        end
	end
end
