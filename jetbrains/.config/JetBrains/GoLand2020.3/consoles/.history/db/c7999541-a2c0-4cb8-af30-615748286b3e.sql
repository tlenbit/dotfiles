SELECT * FROM artist;
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(DISTINCT artist) AS 'Collaborators'
FROM artist_credit_name acn1
WHERE acn1.artist_credit IN (
    SELECT acn2.artist_credit
    FROM artist_credit_name acn2
    WHERE name = 'Ariana Grande'
);
;-- -. . -..- - / . -. - .-. -.--
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