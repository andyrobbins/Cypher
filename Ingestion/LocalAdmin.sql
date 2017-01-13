USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM
'file:////path/to/local_admins.csv' AS line
WITH line

// (Group)-[AdminTo]->(Computer)
FOREACH(f in (CASE WHEN UPPER(line.AccountType) IN ["GROUP"] THEN [1] else [] END) |
  MERGE (Computer:Computer {name: UPPER(line.`ComputerName`)})
  MERGE (Admin:Group {name: UPPER(line.`AccountName`)})
  MERGE (Admin)-[r:AdminTo]->(Computer)
)
// (User)-[AdminTo]->(Computer)
FOREACH(g in (CASE WHEN UPPER(line.AccountType) IN ["USER"] THEN [1] else [] END) |
  MERGE (Computer:Computer {name: UPPER(line.`ComputerName`)})
  MERGE (Admin:User {name: UPPER(line.`AccountName`)})
  MERGE (Admin)-[r:AdminTo]->(Computer)
)
// (Computer)-[AdminTo]->(Computer)
FOREACH(g in (CASE WHEN UPPER(line.AccountType) IN ["COMPUTER"] THEN [1] else [] END) |
  MERGE (Computer:Computer {name: UPPER(line.`ComputerName`)})
  MERGE (Admin:Computer {name: UPPER(line.`AccountName`)})
  MERGE (Admin)-[r:AdminTo]->(Computer)
)
