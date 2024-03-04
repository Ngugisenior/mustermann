/* Scernario
    Given table [HR].[dbo].[leave_requests] below

    | employee_id | start_date | end_date   |
    |-------------|------------|------------|
    | 1           | 2024/03/04 | 2024/03/10 |
    | 2           | 2024/03/05 | 2024/03/12 |
    | 3           | 2024/03/08 | 2024/03/15 |

    Write a query to return the following table\
    employee_id | start_date
    ------------|-----------
    1           | 2024-03-04
    1           | 2024-03-05
    1           | 2024-03-06
    1           | 2024-03-07
    1           | 2024-03-08
    1           | 2024-03-09
    1           | 2024-03-10
    2           | 2024-03-05
    2           | 2024-03-06
    2           | 2024-03-07
    2           | 2024-03-08
    2           | 2024-03-09
    2           | 2024-03-10
    2           | 2024-03-11
    2           | 2024-03-12
    3           | 2024-03-08
    3           | 2024-03-09
    3           | 2024-03-10
    3           | 2024-03-11
    3           | 2024-03-12
    3           | 2024-03-13
    3           | 2024-03-14
    3           | 2024-03-15
*/


--- CTE 

WITH leave_request_report AS (
  SELECT employee_id, start_date, end_date
  FROM [HR].[dbo].[leave_requests]
  UNION ALL
  SELECT employee_id, DATEADD(day, 1, start_date), end_date
  FROM leave_request_report
  WHERE DATEADD(day, 1, start_date) <= end_date
)
SELECT employee_id, start_date as date
FROM leave_request_report
ORDER BY employee_id, start_date;