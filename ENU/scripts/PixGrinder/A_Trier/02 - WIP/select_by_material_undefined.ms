
select (for obj in geometry where obj.material == undefined collect obj)