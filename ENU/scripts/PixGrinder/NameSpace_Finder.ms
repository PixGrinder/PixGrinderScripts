-- NameSpace_Finder --
-- Select objects with space in the name --
-- v1.0 --

clearSelection()
select (for obj in objects where matchpattern obj.name pattern:"* *" collect obj)