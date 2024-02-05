CREATE DATABASE Test;

CREATE TABLE Users (
  NIM VARCHAR(10) PRIMARY KEY,
  Nama VARCHAR(50) NOT NULL
);

CREATE TABLE Attendance (
  Tanggal DATE NOT NULL,
  NIM VARCHAR(10) NOT NULL,
  FOREIGN KEY (NIM) REFERENCES Users(NIM)
);

INSERT INTO Users (NIM, Nama)
VALUES ('A001', 'Mozarella'),
       ('A002', 'Emmental'),
       ('A003', 'Gouda'),
       ('A004', 'Chevre');

INSERT INTO Attendance (Tanggal, NIM)
VALUES ('2020-06-15', 'A001'),
       ('2020-06-18', 'A003'),
       ('2020-06-16', 'A001'),
       ('2020-06-15', 'A002'),
       ('2020-06-17', 'A001'),
       ('2020-06-17', 'A002'),
       ('2020-06-15', 'A003'),
       ('2020-06-16', 'A002'),
       ('2020-06-17', 'A004'),
       ('2020-06-16', 'A003');

-- a). Buatlah query untuk menampilkan siapa saja yang hadir
--     pada tanggal 15 dan 17 Juni 2020 
DECLARE @date_list NVARCHAR(MAX);
DECLARE @dynamic_query NVARCHAR(MAX);

SELECT @date_list = STRING_AGG('[' + CONVERT(NVARCHAR, Tanggal, 23) + ']', ', ')
FROM (SELECT DISTINCT Tanggal FROM Attendance WHERE Tanggal = '2020-06-15' OR Tanggal = '2020-06-17') AS dates;

SET @dynamic_query = 
    'SELECT *
     FROM (
         SELECT u.NIM, u.Nama, t.Tanggal,COALESCE(a.Status, ''Tidak Hadir'') AS Status
		 FROM (SELECT DISTINCT Tanggal FROM Attendance) t
		 CROSS JOIN Users u
		 LEFT JOIN (
		 	SELECT a.NIM, a.Tanggal,
		 		   CASE WHEN a.Tanggal IS NOT NULL THEN ''Hadir'' ELSE ''Tidak Hadir'' END AS Status
		 	FROM Attendance a
		 ) a ON u.NIM = a.NIM AND t.Tanggal = a.Tanggal
     ) AS src
     PIVOT (
         MAX(Status) FOR Tanggal IN (' + @date_list + ')
     ) AS ct
     ORDER BY NIM';

EXEC sp_executesql @dynamic_query;

--------------------------- END a). -----------------------------------------------------


-- b).Buatlah query untuk menampilkan jumlah kehadiran masing-masing
--    orang dalam periode tsb.
DECLARE @date_list_b NVARCHAR(MAX);
DECLARE @dynamic_query_b NVARCHAR(MAX);

-- Get the list of distinct dates as dynamic columns
SELECT @date_list_b = STRING_AGG('[' + CONVERT(NVARCHAR, Tanggal, 23) + ']', ', ')
FROM (SELECT DISTINCT Tanggal FROM Attendance) AS dates;

-- Construct the dynamic SQL query
SET @dynamic_query_b = 
    'SELECT *
     FROM (
         SELECT ''Total Kehadiran '' as Jumlah, t.Tanggal, SUM(COALESCE(a.Status, 0)) AS TotalKehadiran
         FROM (SELECT DISTINCT Tanggal FROM Attendance) t
         CROSS JOIN Users u
         LEFT JOIN (
             SELECT a.NIM, a.Tanggal,
                    CASE WHEN a.Tanggal IS NOT NULL THEN 1 ELSE 0 END AS Status
             FROM Attendance a
         ) a ON u.NIM = a.NIM AND t.Tanggal = a.Tanggal
         GROUP BY t.Tanggal
     ) AS resultData
     PIVOT (
         MAX(TotalKehadiran) FOR Tanggal IN (' + @date_list_b + ')
     ) AS ct'; -- Order by the date columns directly

-- Execute the dynamic SQL
EXEC sp_executesql @dynamic_query_b;
