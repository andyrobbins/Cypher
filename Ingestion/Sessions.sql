USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM
'file:////path/to/user_sessions.csv' AS line
WITH line

// (Computer)-[HasSession]->(User)
MERGE (User:User {name: UPPER(line.`UserName`)})
MERGE (Computer:Computer {name: UPPER(line.`ComputerName`)})
MERGE (Computer)-[r:HasSession]->(User)
