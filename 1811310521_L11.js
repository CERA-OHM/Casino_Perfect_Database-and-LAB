--L1101
db.inventory.insert({ item: "journal", qty: 25, size: { h: 14, w: 21, uom: "cm" }, status: "A" })
/
db.inventory.insert({ item: "notebook", qty: 50, size: { h: 8.5, w: 11, uom: "in" }, status: "A" })
/
db.inventory.insert({ item: "paper", qty: 100, size: { h: 8.5, w: 11, uom: "in" }, status: "D" })
/
db.inventory.insert({ item: "planner", qty: 75, size: { h: 22.85, w: 30, uom: "cm" }, status: "D" })
/
db.inventory.insert({ item: "postcard", qty: 45, size: { h: 10, w: 15.25, uom: "cm" }, status: "A" })

--L1102
db.inventory.find({qty:{$gt:50}})
/

--L1103
db.inventory.find({qty:50, status:"A"})
/

--L1104
db.inventory.find({status: "A"})
/

--L1105
db.inventory.find({"size.w":{$lte:11}})
/