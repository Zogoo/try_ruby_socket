CREATE TABLE Board (
  id serial NOT NULL PRIMARY KEY,
  row INT [],
  column CHAR [],
  style json,
  content json
)
