macroScript PaletteLoader category:"- Gueshni -" Icon:#("g9_paletteloader", 1) tooltip:"Palette Loader"
 (
	 try destroyDialog ::paletteLoader catch()
rollout paletteLoader " Palette Loader" width:200 height:160
(
	subRollout subPalette "" width:200 height:125 pos:[0, 0]
	button btnClear "Clear Palettes" height:25 across:2
	button btnLoad "Load Palette" height:25

	struct colorDef (color, title, type)
	struct paletteDef (colors = #(), name)

	fn getByteConvert =
	(
		source  = "using System;\n"
		source += "public class ByteConvert\n"
		source += "{\n"
		source += "	private static byte[] castToBytes(int[] ints)\n"
		source += "	{\n"
		source += "		return Array.ConvertAll<int, byte>(ints, delegate(int i) { return (byte) i; });\n"
		source += "	}\n"
		source += "	public static String getASCIIString(int[] ints)\n"
		source += "	{\n"
		source += "		return System.Text.Encoding.ASCII.GetString(castToBytes(ints));\n"
		source += "	}\n"
		source += "	public static String getUTF16BEString(int[] ints)\n"
		source += "	{\n"
		source += "		return System.Text.Encoding.BigEndianUnicode.GetString(castToBytes(ints));\n"
		source += "	}\n"
		source += "	public static Single getSingle(int[] ints)\n"
		source += "	{\n"
		source += "		return BitConverter.ToSingle(castToBytes(ints), 0);\n"
		source += "	}\n"
		source += "}\n"

		csharpProvider = dotNetObject "Microsoft.CSharp.CSharpCodeProvider"
		compilerParams = dotNetObject "System.CodeDom.Compiler.CompilerParameters"
		compilerParams.GenerateInMemory = true
		compilerResults = csharpProvider.CompileAssemblyFromSource compilerParams #(source)

		for er = 0 to compilerResults.errors.count-1 do print (compilerResults.errors.item[er].tostring())
		compilerResults.CompiledAssembly.CreateInstance "ByteConvert"
	)

	local byteConvert = getByteConvert()

 	fn getParamStr i clr stream =
	(
		seek stream 0
		format "fieldWidth:15 height:15 pos:% color:% title:\"%\" " [mod i 12 * 15, 5 + 15*(i/12)] clr.color clr.title to:stream
		stream as string
	)

	fn reverseArr arr =
		for i = arr.count to 1 by -1 collect arr[i]

	fn swapShort short =
		bit.or (bit.shift (bit.and short 0xFF) 8) \
		(bit.shift (bit.and short 0xFF00) -8)

	fn readSingle binStream =
	(
		local bytes = for i = 1 to 4 collect readByte binStream #unsigned
		byteConvert.getSingle (reverseArr (bytes))
	)

	fn Lab2XYZ lab =
	(
		if lab[1] < 7.9996 then
		(
			Y = lab[1] / 903.3
			X = Y + lab[2] / 3893.5
			Z = Y - lab[3] / 1557.4
		)
		else
		(
			Y = (lab[1] + 16) / 116
			X = Y + lab[2] / 500
			Z = Y - lab[3] / 200
		)
		[X^3 * 0.95045, Y^3, Z^3 * 1.08892]
	)

	fn Lab2RGB lab =
		XYZ2RGB (Lab2XYZ lab)

	fn readRGB binStream =
		255 * [readSingle binStream, readSingle binStream, readSingle binStream]

	fn readCMYK binStream =
		255 * [1 - readSingle binStream, 1 - readSingle binStream, 1 - readSingle binStream] * \
		(1 - readSingle binStream)

	fn readGray binStream =
		255 * readSingle binStream * [1, 1, 1]

	fn readCharacters binStream length encoding = case encoding of
	(
		#ASCII : byteConvert.getASCIIString \
		         (for i = 1 to length collect readByte binStream #unsigned)
		#UTF16BE : byteConvert.getUTF16BEString \
		           (for i = 1 to 2*length collect readByte binStream #unsigned)
	)

	fn readName binStream =
		readCharacters binStream (swapShort (readShort binStream)) #UTF16BE

	fn skipBlockLength binStream =
		fseek binStream 4 #seek_cur

	fn isHeaderValid binStream =
		readCharacters binStream 4 #ASCII == "ASEF" AND
		swapShort (readShort binStream #unsigned) == 0x0001 AND
		swapShort (readShort binStream #unsigned) == 0x0000

	fn checkNextBlock binStream = case (readShort binStream #unsigned) of
	(
		(swapShort 0xC001) : #group
		(swapShort 0xC002) : #void
		(swapShort 0x0001) : #color
		undefined : #end
	)

	fn readColor binStream = case (readCharacters binStream 4 #ASCII) of
	(
		"RGB " : readRGB binStream
		"LAB " : () -- 3x float
		"CMYK" : readCMYK binStream
		"Gray" : readGray binStream
	)

	fn readType binStream = case (readShort binStream #unsigned) of
	(
		(swapShort 0x0000) : #global
		(swapShort 0x0001) : #spot
		(swapShort 0x0002) : #normal
	)

	fn readBlock binStream =
	(
		skipBlockLength binStream
		colorDef title:(readName binStream) color:(readColor binStream) type:(readType binStream)
	)

	fn readBlocks binStream palette &blockType = while blockType == #color do
	(
		append palette.colors (readBlock binStream)
		blockType = checkNextBlock binStream
	)

	fn getPaletteFromASE filePath blockType:#void =
	(
		local binStream = fopen filePath "rb"

		if NOT isHeaderValid binStream do
		(
			fclose binStream
			return messageBox "Unsupported file format."
		)

		while blockType == #void do
		(
			local palette = paletteDef name:(getFilenameFile filePath)

			skipBlockLength binStream
			blockType = checkNextBlock binStream

			if blockType == #group do
			(
				skipBlockLength binStream
				palette.name = readName binStream
				blockType = checkNextBlock binStream
			)
			readBlocks binStream palette &blockType
		)

		fclose binStream
		palette
	)

	fn createPaletteRollout palette =
	(
		local counter = -1
		local rci = rolloutCreator #palette palette.name
		local stream = stringStream ""
		rci.begin()

		for clr in palette.colors do
			rci.addControl #colorPicker ("cp" + (counter += 1) as string) "" \
			paramStr:(getParamStr counter clr stream)

		rci.end()
	)

	on paletteLoader resized size do
	(
		paletteLoader.width = 200
		subPalette.height = size.y - 35
		btnClear.pos = [btnClear.pos.x, size.y - 30]
		btnLoad.pos = [btnLoad.pos.x, size.y - 30]
	)

	on btnClear pressed do for item in subPalette.rollouts do removeSubRollout subPalette item

	on btnLoad pressed do
	(
		local filePath = getOpenFileName caption:"Pick Palette File" types:"Adobe Swatch Exchange (*.ase)|*.ase|"
		if filePath == undefined do
			return messageBox "Invalid Palette File."

		local palette = getPaletteFromASE filePath
		if isStruct palette do
			addSubRollout subPalette (createPaletteRollout palette) rolledup:false border:false
	)
)
createDialog paletteLoader style:#(#style_titlebar, #style_border, #style_sysmenu, #style_resizing)
)