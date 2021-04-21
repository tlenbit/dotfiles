-- List the number of artists who have collaborated with Ariana Grande.
-- Details: Print only the total number of artists.
-- An artist is considered a collaborator if they appear in the same artist_credit with Ariana Grande.
-- The answer should include Ariana Grande herself.

SELECT COUNT(DISTINCT artist) AS 'Collaborators'
FROM artist_credit_name acn1
WHERE acn1.artist_credit IN (
    SELECT acn2.artist_credit
    FROM artist_credit_name acn2
    WHERE name = 'Ariana Grande'
)