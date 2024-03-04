/* Scenario #2

Given the following employee table

    employee_id | start_date | end_date
    ------------|------------|----------
    1           | 2024-03-04 | 2024-03-10
    2           | 2024-03-05 | 2024-03-12
    3           | 2024-03-08 | 2024-03-15

Return the following report showing the number of employees available at any time period.
    date        count
    ----------------
    2024-03-04  1
    2024-03-05  2
    2024-03-06  2
    2024-03-07  3
    2024-03-08  2
    2024-03-09  2
    2024-03-10  1
    2024-03-11  1
    2024-03-12  1
    2024-03-13  1
    2024-03-14  1
    2024-03-15  1
    2024-03-16  0
*/



CREATE PROCEDURE GetEmployeeAvailability
    @start_date DATE,
    @end_date DATE
AS
BEGIN
    WITH DateRange AS (
        SELECT @start_date AS date
        UNION ALL
        SELECT DATEADD(DAY, 1, date)
        FROM DateRange
        WHERE DATEADD(DAY, 1, date) <= @end_date
    )
    SELECT d.date, COUNT(e.employee_id) AS count
    FROM DateRange d
    LEFT JOIN [HR].[dbo].[employee] e ON d.date >= e.start_date AND d.date <= e.end_date
    GROUP BY d.date
    ORDER BY d.date
END


--- Execute the stored procedure by passing the start and end dates as parameters:


EXEC GetEmployeeAvailability '2024/03/04', '2024/03/16'
