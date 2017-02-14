macroScript GoZBrush
category:"GoZ"
tooltip:"Edit in ZBrush"
(
	try (
		if (s_verbose) then print "\n === 3DS -> ZBrush === "
		local result = s_gozServer.GoToZBrush()
	) catch ();
)
