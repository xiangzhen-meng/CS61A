CREATE TABLE parents AS
  SELECT "ace" AS parent, "bella" AS child UNION
  SELECT "ace"          , "charlie"        UNION
  SELECT "daisy"        , "hank"           UNION
  SELECT "finn"         , "ace"            UNION
  SELECT "finn"         , "daisy"          UNION
  SELECT "finn"         , "ginger"         UNION
  SELECT "ellie"        , "finn";

CREATE TABLE dogs AS
  SELECT "ace" AS name, "long" AS fur, 26 AS height UNION
  SELECT "bella"      , "short"      , 52           UNION
  SELECT "charlie"    , "long"       , 47           UNION
  SELECT "daisy"      , "long"       , 46           UNION
  SELECT "ellie"      , "short"      , 35           UNION
  SELECT "finn"       , "curly"      , 32           UNION
  SELECT "ginger"     , "short"      , 28           UNION
  SELECT "hank"       , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT p.child 
  FROM parents AS p, dogs AS parent_dogs, dogs AS child_dogs
  WHERE p.child = child_dogs.name AND p.parent = parent_dogs.name
  ORDER BY parent_dogs.height DESC;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT dogs.name AS name, sizes.size AS size
  FROM dogs, sizes
  WHERE dogs.height > sizes.min AND dogs.height <= sizes.max;


-- [Optional] Filling out this helper table is recommended
CREATE TABLE siblings AS
  SELECT a.child AS first, b.child AS second
  FROM parents AS a, parents AS b
  WHERE a.parent = b.parent AND a.child < b.child;


-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT "The two siblings, " || siblings.first || " and " || siblings.second || ", have the same size: " || a.size
  FROM siblings, size_of_dogs AS a, size_of_dogs AS b
  WHERE siblings.first = a.name
    AND siblings.second = b.name
    AND a.size = b.size;


-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT dogs.fur AS fur, MAX(dogs.height) - MIN(dogs.height) AS height_range
  FROM dogs
  GROUP BY dogs.fur
  HAVING MAX(dogs.height) <= AVG(dogs.height) * 1.3
     AND MIN(dogs.height) >= AVG(dogs.height) * 0.7;

