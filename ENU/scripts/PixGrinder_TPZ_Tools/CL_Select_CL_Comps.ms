-- CL_Select_CL_Comps.ms --
(
		select (for obj in objects where CustAttributes.count obj == 1 collect obj)
)