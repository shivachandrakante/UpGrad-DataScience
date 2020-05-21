USE assignment;


DROP FUNCTION IF EXISTS helper_for_signal_function_tvs_motors;
delimiter $$ 
CREATE FUNCTION helper_for_signal_function_tvs_motors(d date) 
RETURNS NUMERIC(23, 4) DETERMINISTIC 
BEGIN
   DECLARE previous_row_value NUMERIC(23, 4);
SET
   previous_row_value = 
   (
		SELECT ( LAG(`20 day ma`, 1) OVER( ORDER BY date ASC) )-( LAG(`50 day ma`, 1) OVER( ORDER BY date ASC) )
		FROM     tvs_motors1 
		WHERE    `date` <= d 
		ORDER BY date DESC limit 1
   );
RETURN previous_row_value;
END
$$ delimiter ;


DROP PROCEDURE IF EXISTS signal_finding_for_tvs_motors;
delimiter $$ 
CREATE PROCEDURE signal_finding_for_tvs_motors() 
BEGIN
DROP TABLE IF EXISTS tvs_motors2;
CREATE TABLE tvs_motors2 AS 
SELECT date, 
       close_price, 
       CASE 
         WHEN ( `20 day ma` - `50 day ma` ) > Helper_for_signal_function_tvs_motors(f.date) 
				AND ( `20 day ma` - `50 day ma` ) > 0 
					THEN 'BUY'
		 WHEN ( `20 day ma` - `50 day ma` ) <0
					THEN 'HOLD'
         ELSE 'SELL' 
       END AS `Signal` 
FROM   tvs_motors1 f; 
END
$$ delimiter ;

CALL signal_finding_for_tvs_motors(); 
SET SQL_SAFE_UPDATES = 0;
UPDATE tvs_motors2 temp1 
JOIN 
       (        SELECT   Row_number() OVER (ORDER BY date)AS row_num, 
                         date 
                FROM     tvs_motors2 ) temp2
set    temp1.`signal` = 'HOLD' 
WHERE  temp1.date=temp2.date AND    temp2.row_num<50;


SELECT * 
FROM   tvs_motors2;
