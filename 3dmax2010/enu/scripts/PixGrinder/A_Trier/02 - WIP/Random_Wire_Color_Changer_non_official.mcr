/*
[DESCRIPTION]
This script will assign a random color to each objecct in the selection.  It is based on John Burnetts WireColorMan script.

[USAGE]
Select Objects
Run Script

[CREATION INFO]
Author:Paul Hormis
Last Updated:January 23, 2005

[VERSION HISTORY]
v1.00	Created
v2.00	Initial Public Posting

Copyright (C) 2004, 2005  Paul Hormis

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

paul@time-in-motion.com
*/


macroScript RandomColor
category:"Felipe Scripts"
toolTip:"RandomColor"

(

Global RandomWireColor

Struct RandomWireColorStruct
	(
		fn DoRandomWireColor =
			(
				colArray = #(color 86 86 86, color 227 152 152, color 228 184 153, color 228 214 153, color 214 228 153, color 184 228 153, color 153 228 153,
					color 153 228 184, color 153 228 214, color 154 215 229, color 154 185 229, color 154 154 229, color 184 155 229, color 213 154 229,
					color 229 154 215, color 228 153 184, color 87 224 198, color 224 86 86, color 224 143 87, color 224 198 87, color 198 224 87,
					color 143 224 87, color 87 224 87, color 87 224 143, color 229 166 215, color 88 199 225, color 88 143 225, color 88 88 225,
					color 140 88 225, color 196 88 225, color 225 88 199, color 224 87 143, color 26 177 148, color 176 26 26, color 177 88 26,
					color 177 148 26, color 148 177 26, color 88 177 26, color 26 177 26, color 26 177 88, color 214 229 166, color 28 149 177,
					color 28 89 177, color 28 28 177, color 85 28 177, color 145 28 177, color 177 28 149, color 177 26 88, color 6 134 113,
					color 134 6 6, color 134 59 8, color 134 110 8, color 113 134 6, color 61 134 6, color 6 134 6, color 6 134 58, color 166 229 229,
					color 8 110 134, color 8 61 138, color 8 8 136, color 57 8 136, color 108 8 136, color 138 8 110, color 141 7 58)
			
				objs = (selection as array)
				
				for obj in objs do
					(
						rndCol = random 1 colArray.count
						try ( obj.wireColor = colArray[rndCol] ) catch ()
					)
			)
	)

RandomWireColor = RandomWireColorStruct()

RandomWireColor.DoRandomWireColor()



)