USE assignment;


DROP FUNCTION IF EXISTS helper_for_signal_function_infosys;
delimiter $$ 
CREATE FUNCTION helper_for_signal_function_infosys(d date) 
RETURNS NUMERIC(23, 4) DETERMINISTIC 
BEGIN
   DECLARE previous_row_value NUMERIC(23, 4);
SET
   previous_row_value = 
   (
		SELECT ( LAG(`20 day ma`, 1) OVER( ORDER BY date ASC) )-( LAG(`50 day ma`, 1) OVER( ORDER BY date ASC) )
		FROM     infosys1 
		WHERE    `date` <= d 
		ORDER BY date DESC limit 1
   );
RETURN previous_row_value;
END
$$ delimiter ;


DROP PROCEDURE IF EXISTS signal_finding_for_infosys;
delimiter $$ 
CREATE PROCEDURE signal_finding_for_infosys() 
BEGIN
DROP TABLE IF EXISTS infosys2;
CREATE TABLE infosys2 AS 
SELECT date, 
       close_price, 
       CASE 
         WHEN ( `20 day ma` - `50 day ma` ) > Helper_for_signal_function_infosys(f.date) 
				AND ( `20 day ma` - `50 day ma` ) > 0 
					THEN 'BUY'
		 WHEN ( `20 day ma` - `50 day ma` ) <0
					THEN 'HOLD'
         ELSE 'SELL' 
       END AS `Signal` 
FROM   infosys1 f; 
END
$$ delimiter ;

CALL signal_finding_for_infosys(); 


SET SQL_SAFE_UPDATES = 0;
UPDATE infosys2 temp1 
JOIN 
       (        SELECT   Row_number() OVER (ORDER BY date)AS row_num, 
                         date 
                FROM     tcs2 ) temp2
set    temp1.`signal` = 'HOLD' 
WHERE  temp1.date=temp2.date AND    temp2.row_num<50;


SELECT * 
FROM  infosys2;
