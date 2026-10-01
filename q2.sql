WITH tsn AS (
    SELECT playerid, yearid, lgid
    FROM awardsmanagers
    WHERE awardid = 'TSN Manager of the Year'
      AND lgid IN ('AL', 'NL')
),
both_leagues AS (
    SELECT playerid
    FROM tsn
    GROUP BY playerid
    HAVING COUNT(DISTINCT lgid) = 2
)
SELECT p.namefirst,
       p.namelast,
       t.yearid,
       t.lgid,
       m.teamid,
       tm.name AS team_name
FROM tsn t
JOIN both_leagues b ON b.playerid = t.playerid
JOIN people p       ON p.playerid = t.playerid
JOIN managers m     ON m.playerid = t.playerid
                   AND m.yearid   = t.yearid
                   AND m.lgid     = t.lgid
JOIN teams tm       ON tm.yearid  = m.yearid
                   AND tm.lgid    = m.lgid
                   AND tm.teamid  = m.teamid
ORDER BY p.namelast, t.yearid;







WITH both_leagues AS (
    SELECT playerid
    FROM awardsmanagers
    WHERE awardid = 'TSN Manager of the Year'
      AND lgid IN ('AL', 'NL')
    GROUP BY playerid
    HAVING COUNT(DISTINCT lgid) = 2
)
SELECT p.namefirst,
       p.namelast,
       a.yearid,
       a.lgid,
       m.teamid
FROM awardsmanagers a
JOIN both_leagues b ON b.playerid = a.playerid
JOIN people p       ON p.playerid = a.playerid
JOIN managers m     ON m.playerid = a.playerid
                   AND m.yearid   = a.yearid
                   AND m.lgid     = a.lgid
WHERE a.awardid = 'TSN Manager of the Year'
  AND a.lgid IN ('AL', 'NL')
ORDER BY p.namelast, a.yearid;