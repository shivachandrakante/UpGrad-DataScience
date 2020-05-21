USE assignment;


DROP TABLE IF EXISTS master;
CREATE TABLE master AS 
  SELECT temp1.date        AS DATE, 
         temp1.close_price AS BAJAJ, 
         temp2.close_price AS TCS, 
         temp3.close_price AS INFOSYS, 
         temp4.close_price AS TVS, 
         temp5.close_price AS HERO, 
         temp6.close_price AS EITCHER 
  FROM   bajaj1 AS temp1 
         LEFT JOIN tcs1 temp2 
                ON temp1.date = temp2.date 
         LEFT JOIN infosys1 temp3 
                ON temp1.date = temp3.date 
         LEFT JOIN tvs_motors1 temp4 
                ON temp1.date = temp4.date 
         LEFT JOIN hero_motocorp1 temp5 
                ON temp1.date = temp5.date 
         LEFT JOIN eicher_motors1 temp6 
                ON temp1.date = temp6.date; 

SELECT * 
FROM   master;
