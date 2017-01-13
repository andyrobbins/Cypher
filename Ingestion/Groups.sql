USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM
'file:////path/to/group_memberships.csv' AS line
WITH line

// (Group)-[MemberOf]->(Group)
FOREACH(f in (CASE WHEN UPPER(line.AccountType) IN ["GROUP"] THEN [1] else [] END) |
  MERGE (Group:Group {name: UPPER(line.`GroupName`)})
  MERGE (Member:Group {name: UPPER(line.`AccountName`)})
  MERGE (Member)-[r:MemberOf]->(Group)
)
// (User)-[MemberOf]->(Group)
FOREACH(g in (CASE WHEN UPPER(line.AccountType) IN ["USER"] THEN [1] else [] END) |
  MERGE (Group:Group {name: UPPER(line.`GroupName`)})
  MERGE (Member:User {name: UPPER(line.`AccountName`)})
  MERGE (Member)-[r:MemberOf]->(Group)
)
// (Computer)-[MemberOf]->(Group)
FOREACH(g in (CASE WHEN UPPER(line.AccountType) IN ["COMPUTER"] THEN [1] else [] END) |
  MERGE (Group:Group {name: UPPER(line.`GroupName`)})
  MERGE (Member:Computer {name: UPPER(line.`AccountName`)})
  MERGE (Member)-[r:MemberOf]->(Group)
)
