----  Reverse keys


-- reverseTime <controller> <interval> [ #incLeft ] [ #incRight ]

-- Reverses time in the given interval, essentially swapping keys around so that their time placements are reversed within the interval. The notes on inclusion and interval arguments from deleteTime() apply.

--  -----------------------------------

-- scaleTime <controller> <interval> <float_scale>

-- Scales the times of the keys within the given interval. Again, the <interval> argument can be specified as an Interval value or as two numbers or time values defining the start and end times. Number values are taken as frame counts.

---------------------------------
-- getKeyIndex <controller> <time>

-- Returns the index of the key at the specified time.

---------------------------------

-- selectKeys <controller> [ <interval> | <time> ]

-- Selects the specified keys in the track view. If an interval is given, all the keys within the interval are selected. If a single time is given, the key at that time is selected. If no time or interval is given, select all keys.

----------------------------------
-- isKeySelected <controller> <index_integer>

-- Returns true if indexed key is selected, false otherwise. Key indexes are 1-based.
------------------------------------------

-- Constructor

-- interval <start_time> <end_time>

---------------------------------------

interval 5f 15f

supportsTimeOperations pda


sliderTime = 10f


(

	pda = $.position.controller
	pdakey = pda.keys
	-- pdakeycount = $.position.controller.keys.count
	pdainterval = interval pdakey[1].time pdakey[pdakey.count].time

	--selectKeys pda

	reverseTime pda pdainterval #incleft #incright
	
	pda = $.rotation.controller
	pdakey = pda.keys
	pdainterval = interval pdakey[1].time pdakey[pdakey.count].time
	reverseTime pda pdainterval #incleft #incright
	
	pda = $.scale.controller
	pdakey = pda.keys
	pdainterval = interval pdakey[1].time pdakey[pdakey.count].time
	reverseTime pda pdainterval #incleft #incright
	

)


