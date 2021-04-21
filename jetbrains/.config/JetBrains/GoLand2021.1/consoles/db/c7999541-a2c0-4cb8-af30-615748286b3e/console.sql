-- List works with longest name of each type.
-- Details: For each work type, find works that have the longest names.
-- There might be cases where there is a tie for the longest names -
-- in that case, return all of them. Display work names and corresponding
-- type names, and order it according to work type (ascending)
-- and use work name (ascending) as tie-breaker.

SELECT work.name
FROM work
         INNER JOIN (
    SELECT max(length(work.name)) AS max_length,
           work.type              AS type
    FROM work
    GROUP BY work.type
) AS newtable ON newtable.max_length = length(work.name)
    AND work.type = newtable.type
         INNER JOIN work_type ON work.type = work_type.id
ORDER BY work.type ASC, work.name ASC;