SELECT *
FROM area
WHERE name = 'Estonia';
;-- -. . -..- - / . -. - .-. -.--
SELECT name
FROM work_type;
;-- -. . -..- - / . -. - .-. -.--
SELECT name
FROM work_type
ORDER BY id;
;-- -. . -..- - / . -. - .-. -.--
SELECT name
FROM artist;
;-- -. . -..- - / . -. - .-. -.--
SELECT name
FROM artist
WHERE name LIKE '%CANADA%';
;-- -. . -..- - / . -. - .-. -.--
SELECT name
FROM artist
WHERE name LIKE '%states%';
;-- -. . -..- - / . -. - .-. -.--
SELECT name
FROM artist
WHERE name LIKE '%gorilla%';
;-- -. . -..- - / . -. - .-. -.--
SELECT name
FROM artist
WHERE name LIKE '%muse%';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM work
LIMIT 10;
;-- -. . -..- - / . -. - .-. -.--
SELECT name
FROM artist
WHERE name LIKE '%canada%';
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(*)
FROM work;
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM work;
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM work
GROUP BY type;
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(*)
FROM work
GROUP BY type;
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(*), type
FROM work
GROUP BY type;
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(*), name, type
FROM work
GROUP BY type;
;-- -. . -..- - / . -. - .-. -.--
SELECT LENGTH(work.name)
FROM work;
;-- -. . -..- - / . -. - .-. -.--
SELECT max(length(work.name))
FROM work;
;-- -. . -..- - / . -. - .-. -.--
SELECT max(length(work.name))
FROM work
GROUP BY work.type;
;-- -. . -..- - / . -. - .-. -.--
SELECT max(length(work.name)) AS max_length
FROM work
GROUP BY work.type;
;-- -. . -..- - / . -. - .-. -.--
SELECT work.name
FROM work;
;-- -. . -..- - / . -. - .-. -.--
SELECT work.name
FROM work
         INNER JOIN (
    SELECT max(length(work.name)) AS max_length,
           work.type AS type
    FROM work
    GROUP BY work.type
) AS newtable ON newtable.max_length = length(work.name)
AND work.type = newtable.type
INNER JOIN work_type ON work.type = work_type.id;
;-- -. . -..- - / . -. - .-. -.--
SELECT name
FROM work_type
ORDER BY name;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist_type
ORDER BY name ASC;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist_type
ORDER BY name DESC;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist_type
ORDER BY id DESC;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist_type
ORDER BY id ASC;
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
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM medium;
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM area;
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(*)
FROM area;
;-- -. . -..- - / . -. - .-. -.--
SELECT name
FROM area;
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM area
WHERE name = 'Chile';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM area
WHERE name = 'Pery';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM area
WHERE name LIKE '%eru%';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM area
WHERE name LIKE '%peru%';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM area
WHERE name LIKE '%chile%';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM area
WHERE name LIKE '%argen%';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM area
WHERE name LIKE '%boli%';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM area
WHERE name LIKE '%boli_ia%';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM area
WHERE name LIKE '%boli__ia%';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM area
WHERE name LIKE '%a__a%';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM area
WHERE name LIKE '%_states%';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM area
WHERE name LIKE '%states%';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM area
WHERE name LIKE '%unidos%';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM area
WHERE name LIKE '%united states%';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM artist;
;-- -. . -..- - / . -. - .-. -.--
SELECT begin_date_year
FROM artist;
;-- -. . -..- - / . -. - .-. -.--
SELECT begin_date_year
FROM artist
WHERE  begin_date_year > 1985;
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(begin_date_year)
FROM artist
WHERE  begin_date_year < 1850;
;-- -. . -..- - / . -. - .-. -.--
SELECT begin_date_year
FROM artist
WHERE  begin_date_year < 1850;
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM artist
WHERE  begin_date_year < 1850;
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM artist
LEFT JOIN area a on artist.area = a.id
WHERE  begin_date_year < 1850;
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM artist
INNER JOIN area a on artist.area = a.id
WHERE  begin_date_year < 1850;
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(*)
FROM artist
--INNER JOIN area a on artist.area = a.id
WHERE  begin_date_year < 1850;
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(*)
FROM artist
--LEFT JOIN area a on artist.area = a.id
WHERE  begin_date_year < 1850;
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(*)
FROM artist
LEFT JOIN area a on artist.area = a.id
WHERE  begin_date_year < 1850;
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(*)
FROM artist
INNER JOIN area a on artist.area = a.id
WHERE  begin_date_year < 1850;
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(*)
FROM artist a1
INNER JOIN area a2 on a1.area = a2.id
WHERE  begin_date_year < 1850
GROUP BY a2.name;
;-- -. . -..- - / . -. - .-. -.--
SELECT a2.name
FROM artist a1
INNER JOIN area a2 on a1.area = a2.id
WHERE  begin_date_year < 1850
GROUP BY a2.name;
;-- -. . -..- - / . -. - .-. -.--
SELECT a2.name
FROM artist a1
INNER JOIN area a2 on a1.area = a2.id
WHERE  begin_date_year < 1850
GROUP BY a1.area;
;-- -. . -..- - / . -. - .-. -.--
SELECT a2.name, COUNT(*)
FROM artist a1
INNER JOIN area a2 on a1.area = a2.id
WHERE  begin_date_year < 1850
GROUP BY a1.area;
;-- -. . -..- - / . -. - .-. -.--
SELECT a2.name, COUNT(*) AS c
FROM artist a1
INNER JOIN area a2 on a1.area = a2.id
WHERE  begin_date_year < 1850
GROUP BY a1.area
ORDER BY c;
;-- -. . -..- - / . -. - .-. -.--
SELECT a2.name, COUNT(*) AS c
FROM artist a1
INNER JOIN area a2 on a1.area = a2.id
WHERE  begin_date_year < 1850
GROUP BY a1.area
ORDER BY c DESC;
;-- -. . -..- - / . -. - .-. -.--
SELECT a2.name, COUNT(*) AS c
FROM artist a1
INNER JOIN area a2 on a1.area = a2.id
WHERE  begin_date_year < 1850
GROUP BY a2.name
ORDER BY c DESC
LIMIT 10;
;-- -. . -..- - / . -. - .-. -.--
SELECT a2.name, COUNT(*) AS c
FROM artist a1
INNER JOIN area a2 on a1.area = a2.id
WHERE  begin_date_year < 1850
GROUP BY a1.area
ORDER BY COUNT(a2.name) DESC
LIMIT 10;
;-- -. . -..- - / . -. - .-. -.--
SELECT a2.name, COUNT(*) AS c
FROM artist a1
INNER JOIN area a2 on a1.area = a2.id
WHERE  begin_date_year < 1850
GROUP BY a1.area
ORDER BY c DESC
LIMIT 10;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist_type;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist_alias;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist_alias
INNER JOIN artist a ON artist_alias.artist= a.id;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist
INNER JOIN artist a ON artist_alias.artist= a.id;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM a
INNER JOIN artist a ON artist_alias.artist= a.id;
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM artist_alias
         LEFT JOIN artist a
                    ON artist_alias.artist = a.id;
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(*)
FROM artist_alias
         INNER JOIN artist a
                    ON artist_alias.artist = a.id;
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(*)
FROM artist_alias
         LEFT JOIN artist a
                    ON artist_alias.artist = a.id;
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM artist_alias
         INNER JOIN artist a
                    ON artist_alias.artist = a.id;
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM artist_alias;
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM artist_alias
GROUP BY artist;
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(*)
FROM artist_alias
GROUP BY artist;
;-- -. . -..- - / . -. - .-. -.--
SELECT name, COUNT(*)
FROM artist_alias;
;-- -. . -..- - / . -. - .-. -.--
SELECT name,
FROM artist_alias;
;-- -. . -..- - / . -. - .-. -.--
SELECT name, COUNT(*)
FROM artist_alias
GROUP BY artist;
;-- -. . -..- - / . -. - .-. -.--
SELECT artist, COUNT(*)
FROM artist_alias
GROUP BY artist;
;-- -. . -..- - / . -. - .-. -.--
SELECT artist, COUNT(*)
FROM artist_alias
INNER JOIN "artist" a ON a.id = artist_alias.artist
GROUP BY artist;
;-- -. . -..- - / . -. - .-. -.--
SELECT name, artist, COUNT(*), a.name
FROM artist_alias
INNER JOIN "artist" a ON a.id = artist_alias.artist
GROUP BY artist;
;-- -. . -..- - / . -. - .-. -.--
SELECT artist_alias.name, artist, COUNT(*), a.name
FROM artist_alias
INNER JOIN "artist" a ON a.id = artist_alias.artist
GROUP BY artist;
;-- -. . -..- - / . -. - .-. -.--
SELECT artist, COUNT(*), a.name
FROM artist_alias
INNER JOIN "artist" a ON a.id = artist_alias.artist
GROUP BY artist;
;-- -. . -..- - / . -. - .-. -.--
SELECT a.name, COUNT(DISTINCT artist_alias.name) AS num
FROM artist a
INNER JOIN artist_alias aa ON a.id = aa.artist
GROUP BY artist;
;-- -. . -..- - / . -. - .-. -.--
SELECT a.name, COUNT(DISTINCT aa.name) AS num
FROM artist a
INNER JOIN artist_alias aa ON a.id = aa.artist
WHERE a.begin_date_year > 1950
AND a.area = 221
GROUP BY a.id;
;-- -. . -..- - / . -. - .-. -.--
SELECT a.name, COUNT(DISTINCT aa.name) AS num
FROM artist a
INNER JOIN artist_alias aa ON a.id = aa.artist
WHERE a.begin_date_year > 1950
AND a.area = 221
GROUP BY a.id
ORDER BY num DESC;
;-- -. . -..- - / . -. - .-. -.--
SELECT a.name, COUNT(DISTINCT aa.name) AS num
FROM artist a
INNER JOIN artist_alias aa ON a.id = aa.artist
WHERE a.begin_date_year > 1950
AND a.area = 221
GROUP BY a.id
ORDER BY num DESC
LIMIT 10;
;-- -. . -..- - / . -. - .-. -.--
SELECT a.name, COUNT(DISTINCT aa.name) AS num
FROM artist a
         INNER JOIN artist_alias aa ON a.id = aa.artist
WHERE a.begin_date_year > 1950
  AND a.area = 221
GROUP BY a.id
ORDER BY num DESC
LIMIT 10;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM medium;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM medium_format;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist WHERE name LIKE '%coldplay%';
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist_credit;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist_credit_name WHERE name Like '%coldplay';
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist_credit_name WHERE name Like '%coldplay%';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM artist_credit_name acn
INNER JOIN artist_credit ac ON acn.artist_credit = ac.id
INNER JOIN release r ON r.artist_credit = ac.id
INNER JOIN medium m ON m."release" = r.id
INNER JOIN medium_format mf ON mf.id = m.format
WHERE m.name LIKE 'vinyl';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM artist_credit_name acn
INNER JOIN artist_credit ac ON acn.artist_credit = ac.id
INNER JOIN release r ON r.artist_credit = ac.id
INNER JOIN medium m ON m."release" = r.id
INNER JOIN medium_format mf ON mf.id = m.format
WHERE mf.name LIKE '%Vinyl';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM artist_credit_name acn
         INNER JOIN artist_credit ac ON acn.artist_credit = ac.id
         INNER JOIN release r ON r.artist_credit = ac.id
         INNER JOIN medium m ON m."release" = r.id
         INNER JOIN medium_format mf ON mf.id = m.format
WHERE acn.name = 'Coldplay'
  AND mf.name LIKE '%Vinyl';
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT r.name AS rname
FROM artist_credit_name acn
         INNER JOIN artist_credit ac ON acn.artist_credit = ac.id
         INNER JOIN release r ON r.artist_credit = ac.id
         INNER JOIN medium m ON m."release" = r.id
         INNER JOIN medium_format mf ON mf.id = m.format
WHERE acn.name = 'Coldplay'
  AND mf.name LIKE '%Vinyl'
ORDER BY date_year;
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT r.name AS rname
FROM artist_credit_name acn
         INNER JOIN artist_credit ac ON acn.artist_credit = ac.id
         INNER JOIN release r ON r.artist_credit = ac.id
         INNER JOIN medium m ON m."release" = r.id
         INNER JOIN medium_format mf ON mf.id = m.format
WHERE acn.name = 'Coldplay'
  AND mf.name LIKE '%Vinyl';
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT r.name AS rname
FROM artist_credit_name acn
         INNER JOIN artist_credit ac ON acn.artist_credit = ac.id
         INNER JOIN release r ON r.artist_credit = ac.id
         INNER JOIN release_info ri ON ri."release" = r.id
         INNER JOIN medium m ON m."release" = r.id
         INNER JOIN medium_format mf ON mf.id = m.format
WHERE acn.name = 'Coldplay'
  AND mf.name LIKE '%Vinyl';
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT r.name AS rname, ri.date_year
FROM artist_credit_name acn
         INNER JOIN artist_credit ac ON acn.artist_credit = ac.id
         INNER JOIN release r ON r.artist_credit = ac.id
         INNER JOIN release_info ri ON ri."release" = r.id
         INNER JOIN medium m ON m."release" = r.id
         INNER JOIN medium_format mf ON mf.id = m.format
WHERE acn.name = 'Coldplay'
  AND mf.name LIKE '%Vinyl'
ORDER BY ri.date_year, ri.date_month, ri.date_day;
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT r.name AS rname
FROM artist_credit_name acn
         INNER JOIN artist_credit ac ON acn.artist_credit = ac.id
         INNER JOIN release r ON r.artist_credit = ac.id
         INNER JOIN release_info ri ON ri."release" = r.id
         INNER JOIN medium m ON m."release" = r.id
         INNER JOIN medium_format mf ON mf.id = m.format
WHERE acn.name = 'Coldplay'
  AND mf.name LIKE '%Vinyl'
ORDER BY ri.date_year, ri.date_month, ri.date_day;
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT r.name AS rname
FROM artist_credit_name acn
         INNER JOIN artist_credit ac ON acn.artist_credit = ac.id
         INNER JOIN "release" r ON r.artist_credit = ac.id
         INNER JOIN release_info ri ON ri."release" = r.id
         INNER JOIN medium m ON m."release" = r.id
         INNER JOIN medium_format mf ON mf.id = m.format
WHERE acn.name = 'Coldplay'
  AND mf.name LIKE '%Vinyl'
ORDER BY ri.date_year, ri.date_month, ri.date_day;
;-- -. . -..- - / . -. - .-. -.--
SELECT  * From artist_credit;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM area;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM release_info;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM release_info
GROUP BY date_year;
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM release_info
GROUP BY date_year;
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM "release"
INNER JOIN release_info ON "release".id = release_info."release";
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM "release"
INNER JOIN release_info ON "release".id = release_info."release"
WHERE "release".status = 1;
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM "release"
         INNER JOIN release_info ON "release".id = release_info."release"
WHERE "release".status = 1
  AND date_year >= 1900;
;-- -. . -..- - / . -. - .-. -.--
SELECT (CAST((date_year / 10) AS INTEGER) )
FROM "release"
         INNER JOIN release_info ON "release".id = release_info."release"
WHERE "release".status = 1
  AND date_year >= 1900;
;-- -. . -..- - / . -. - .-. -.--
SELECT (CAST((date_year) AS INTEGER) * 10)
FROM "release"
         INNER JOIN release_info ON "release".id = release_info."release"
WHERE "release".status = 1
  AND date_year >= 1900;
;-- -. . -..- - / . -. - .-. -.--
SELECT (CAST((date_year) AS INTEGER))
FROM "release"
         INNER JOIN release_info ON "release".id = release_info."release"
WHERE "release".status = 1
  AND date_year >= 1900;
;-- -. . -..- - / . -. - .-. -.--
SELECT (CAST((date_year / 10) AS INTEGER) * 10)
FROM "release"
         INNER JOIN release_info ON "release".id = release_info."release"
WHERE "release".status = 1
  AND date_year >= 1900;
;-- -. . -..- - / . -. - .-. -.--
SELECT (CAST((date_year / 10) AS INTEGER) * 10) || 's'
FROM "release"
         INNER JOIN release_info ON "release".id = release_info."release"
WHERE "release".status = 1
  AND date_year >= 1900;
;-- -. . -..- - / . -. - .-. -.--
SELECT (CAST((date_year / 10) AS INTEGER) * 10) || 's' AS decade
FROM "release"
         INNER JOIN release_info ON "release".id = release_info."release"
WHERE "release".status = 1
  AND date_year >= 1900;
;-- -. . -..- - / . -. - .-. -.--
SELECT decade
FROM (
         SELECT (CAST((date_year / 10) AS INTEGER) * 10) || 's' AS decade
         FROM "release"
                  INNER JOIN release_info ON "release".id = release_info."release"
         WHERE "release".status = 1
           AND date_year >= 1900
     );
;-- -. . -..- - / . -. - .-. -.--
SELECT decade, COUNT(*) AS cnt
FROM (
         SELECT (CAST((date_year / 10) AS INTEGER) * 10) || 's' AS decade
         FROM "release"
                  INNER JOIN release_info ON "release".id = release_info."release"
         WHERE "release".status = 1
           AND date_year >= 1900
     )
GROUP BY decade;
;-- -. . -..- - / . -. - .-. -.--
SELECT decade, COUNT(*) AS cnt
FROM (
         SELECT (CAST((date_year / 10) AS INTEGER) * 10) || 's' AS decade
         FROM "release"
                  INNER JOIN release_info ON "release".id = release_info."release"
         WHERE "release".status = 1
           AND date_year >= 1900
     )
GROUP BY decade
ORDER BY cnt DESC, decade DESC;
;-- -. . -..- - / . -. - .-. -.--
Select;
;-- -. . -..- - / . -. - .-. -.--
Select * From area;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM "release";
;-- -. . -..- - / . -. - .-. -.--
WITH past_year_release (year, month) AS (
    SELECT date_year, date_month
    FROM release_info r1
             INNER JOIN "release" r2 ON r1."release" = r2.id
    WHERE ((date_year = 2019 AND date_month >= 7) OR
           (date_year = 2020 AND date_month <= 7))
)

SELECT CAST(year AS varchar) || '.' || (
    case
        when month < 10 then 0
        else ''
        end
    ) || CAST(month AS varchar) AS DATE,
       round(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM past_year_release), 2)
FROM past_year_release;
;-- -. . -..- - / . -. - .-. -.--
WITH past_year_release (year, month) AS (
    SELECT date_year, date_month
    FROM release_info r1
             INNER JOIN "release" r2 ON r1."release" = r2.id
    WHERE ((date_year = 2019 AND date_month >= 7) OR
           (date_year = 2020 AND date_month <= 7))
)

SELECT CAST(year AS varchar) || '.' || (
    case
        when month < 10 then 0
        else ''
        end
    ) || CAST(month AS varchar) AS DATE,
       round(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM past_year_release), 2) AS percentage
FROM past_year_release;
;-- -. . -..- - / . -. - .-. -.--
WITH past_year_release (year, month) AS (
    SELECT date_year, date_month
    FROM release_info r1
             INNER JOIN "release" r2 ON r1."release" = r2.id
    WHERE ((date_year = 2019 AND date_month >= 7) OR
           (date_year = 2020 AND date_month <= 7))
)

SELECT CAST(year AS varchar) || '.' || (
    case
        when month < 10 then 0
        else ''
        end
    ) || CAST(month AS varchar) AS DATE,
       round(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM past_year_release), 2) AS percentage
FROM past_year_release
GROUP BY date
ORDER BY date;
;-- -. . -..- - / . -. - .-. -.--
SELECT *;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist_credit_name;
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist_credit_name where name = 'Ariana Grande';
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(*) FROM artist_credit_name where name = 'Ariana Grande'
group by name;
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(*) FROM artist_credit_name where name = 'Ariana Grande';
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(*) FROM artist where name = 'Ariana Grande';
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist where name = 'Ariana Grande';
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist where name = '%ariana grande%';
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist where name = '%Ariana grande%';
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist where name = '%Ariana Grande%';
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist where like '%ariana grande%';
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist where name like'%ariana grande%';
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist where name like '%ariana grande%';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM artist a
INNER JOIN artist_credit_name acn ON a.id = acn.artist
WHERE name = 'Ariana Grande';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM artist a
INNER JOIN artist_credit_name acn ON a.id = acn.artist
WHERE a-name = 'Ariana Grande';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM artist a
INNER JOIN artist_credit_name acn ON a.id = acn.artist
WHERE a.name = 'Ariana Grande';
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM artist_credit_name acn
WHERE artist_credit IN (
    SELECT acn.artist_credit
    FROM artist_credit_name
    WHERE name = 'Ariana Grande'
);
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM artist_credit_name acn1
WHERE artist_credit IN (
    SELECT acn2.artist_credit
    FROM artist_credit_name acn2
    WHERE name = 'Ariana Grande'
);
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(DISTINCT artist)
FROM artist_credit_name acn1
WHERE artist_credit IN (
    SELECT acn2.artist_credit
    FROM artist_credit_name acn2
    WHERE name = 'Ariana Grande'
);
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(DISTINCT artist) AS 'Collaborator'
FROM artist_credit_name acn1
WHERE artist_credit IN (
    SELECT acn2.artist_credit
    FROM artist_credit_name acn2
    WHERE name = 'Ariana Grande'
);
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(DISTINCT artist) AS 'Collaborators'
FROM artist_credit_name acn1
WHERE artist_credit IN (
    SELECT acn2.artist_credit
    FROM artist_credit_name acn2
    WHERE name = 'Ariana Grande'
);
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(DISTINCT artist) AS 'Collaborators'
FROM artist_credit_name acn1
WHERE acn1.artist_credit IN (
    SELECT acn2.artist_credit
    FROM artist_credit_name acn2
    WHERE name = 'Ariana Grande'
);
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM artist;
;-- -. . -..- - / . -. - .-. -.--
WITH duos_list (id1, id2, c) AS (
    SELECT a1.artist as id1,
           a2.artist as id2,
           COUNT(*) as c
    FROM artist_credit_name a1
             INNER JOIN artist_credit_name a2 ON a1.artist_credit = a2.artist_credit
             INNER JOIN release r ON a2.artist_credit = r.artist_credit
             INNER JOIN artist a3 ON a1.artist = a3.id
             INNER JOIN artist a4 ON a2.artist = a4.id
             INNER JOIN artist_type a5 ON a3.type = a5.id
             INNER JOIN artist_type a6 ON a4.type = a6.id
             INNER JOIN language l ON r.language = l.id
    WHERE a3.name < a4.name
      AND a5.name = 'Person'
      AND a6.name = 'Person'
      AND l.name = 'English'
      AND a3.begin_date_year > 1960
      AND a4.begin_date_year > 1960
    GROUP BY a1.artist, a2.artist
)

SELECT *
FROM duos_list;
;-- -. . -..- - / . -. - .-. -.--
WITH duos_list (id1, id2, c) AS (
    SELECT a1.artist as id1,
           a2.artist as id2,
           COUNT(*)  as c
    FROM artist_credit_name a1
             INNER JOIN artist_credit_name a2 ON a1.artist_credit = a2.artist_credit
             INNER JOIN release r ON a2.artist_credit = r.artist_credit
             INNER JOIN artist a3 ON a1.artist = a3.id
             INNER JOIN artist a4 ON a2.artist = a4.id
             INNER JOIN artist_type a5 ON a3.type = a5.id
             INNER JOIN artist_type a6 ON a4.type = a6.id
             INNER JOIN language l ON r.language = l.id
    WHERE a3.name < a4.name
      AND a5.name = 'Person'
      AND a6.name = 'Person'
      AND l.name = 'English'
      AND a3.begin_date_year > 1960
      AND a4.begin_date_year > 1960
    GROUP BY a1.artist, a2.artist
)

SELECT *
FROM (
         SELECT row_number() over (
             ORDER BY c DESC,
                 a1.name,
                 a2.name
             )          AS rank,
                a1.name AS name1,
                a2.name AS name2
         FROM duos_list d
                  INNER JOIN artist a1 ON d.id1 = a1.id
                  INNER JOIN artist a2 ON d.id2 = a2.id
     )
WHERE name1 = 'Dr. Dre'
  AND name2 = 'Eminem';
;-- -. . -..- - / . -. - .-. -.--
SELECT*;
;-- -. . -..- - / . -. - .-. -.--
WITH c AS (
    SELECT row_number() OVER (
        ORDER BY c.id ASC
        )         AS seqnum,
           c.name AS name
    FROM artist_alias c
             JOIN artist ON c.artist = artist.id
    WHERE artist.name = 'The Beatles'
),
     flattened AS (
         SELECT seqnum, name AS name
         from c
         WHERE seqnum = 1
         UNION ALL
         SELECT c.seqnum, f.name || ',' || c.name
         FROM c
                  JOIN flattened f ON c.seqnum = f.seqnum + 1
     )
SELECT name
FROM flattened
ORDER BY seqnum DESC
LIMIT 1;