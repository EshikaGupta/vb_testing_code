CREATE OR REPLACE PROCEDURE SEARCH_EMPLOYEES (
  p_emp_name IN VARCHAR2,
  p_results OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN p_results FOR
    SELECT empno, ename, job, deptno
    FROM emp
    WHERE UPPER(ename) LIKE '%' || UPPER(p_emp_name) || '%';
END SEARCH_EMPLOYEES;
/
