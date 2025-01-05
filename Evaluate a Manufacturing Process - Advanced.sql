/*
Manufacturing processes for any product is like putting together a puzzle. Products are pieced together step by step,
and keeping a close eye on the process is important.

For this project, you're supporting a team that wants to improve how they monitor and control a manufacturing process.
The goal is to implement a more methodical approach known as statistical process control (SPC). SPC is an established strategy that uses
data to determine whether the process works well. Processes are only adjusted if measurements fall outside of an acceptable range.

This acceptable range is defined by an upper control limit (UCL) and a lower control limit (LCL), the formulas for which are:

 w.avg_height + 3*w.stddev_height/SQRT(5) AS ucl
 
 w.avg_height - 3*w.stddev_height/SQRT(5) AS lcl  

 

The UCL defines the highest acceptable height for the parts, while the LCL defines the lowest acceptable height for the parts.
Ideally, parts should fall between the two limits.

Using SQL window functions and nested queries, you'll analyze historical manufacturing data to define this acceptable range
and identify any points in the process that fall outside of the range and therefore require adjustments. This will ensure a smooth
running manufacturing process consistently making high-quality products.

The data
The data is available in the manufacturing_parts table which has the following fields:

item_no: the item number
length: the length of the item made
width: the width of the item made
height: the height of the item made
operator: the operating machine
*/

/*
PART ONE:

Create an alert that flags whether the height of a product is within the control limits for each operator using the formulas provided in the workbook.
The final query should return the following fields: operator, row_number, height, avg_height, stddev_height, ucl, lcl, alert, and be ordered by the item_no.
The alert column will be your boolean flag.
Use a window function of length 5 to calculate the control limits, considering rows up to and including the current row;
incomplete windows should be excluded from the final query output.
*/

SELECT ul.*,
	   CASE WHEN ul.height NOT BETWEEN ul.lcl AND ul.ucl THEN TRUE
	   ELSE FALSE END as alert
FROM 
	(SELECT
		w.*, 
		w.avg_height + 3*w.stddev_height/SQRT(5) AS ucl, 
		w.avg_height - 3*w.stddev_height/SQRT(5) AS lcl  
	FROM (
		SELECT 
			operator,
			ROW_NUMBER() OVER (PARTITION BY operator ORDER BY item_no ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS row_number, 
			height, 
			AVG(height) OVER (PARTITION BY operator ORDER BY item_no ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS avg_height, 
			STDDEV(height) OVER (PARTITION BY operator ORDER BY item_no ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS stddev_height
		FROM manufacturing_parts 
		) AS w
	WHERE w.row_number >= 5 ) AS ul;


