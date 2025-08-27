-- Drop table if already exists
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE emp CASCADE CONSTRAINTS';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF; -- ignore "table does not exist"
END;
/

-- Create Employee Table
CREATE TABLE emp (
  empno NUMBER PRIMARY KEY,
  ename VARCHAR2(50),
  job VARCHAR2(50),
  deptno NUMBER
);

-- Insert Sample Data
INSERT INTO emp (empno, ename, job, deptno) VALUES (101, 'John Smith', 'Manager', 10);
INSERT INTO emp (empno, ename, job, deptno) VALUES (102, 'Jane Doe', 'Clerk', 20);
INSERT INTO emp (empno, ename, job, deptno) VALUES (103, 'Michael Brown', 'Analyst', 10);
INSERT INTO emp (empno, ename, job, deptno) VALUES (104, 'Emily Davis', 'Sales', 30);
INSERT INTO emp (empno, ename, job, deptno) VALUES (105, 'David Wilson', 'Manager', 20);

COMMIT;
