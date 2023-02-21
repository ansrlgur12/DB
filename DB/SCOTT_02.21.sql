-- ������ ���̺� ���� �ϱ�
-- ���� ���̺� �����ؼ� ����ϴ� ���
CREATE TABLE DEPT_TEMP
    AS SELECT * FROM DEPT;

SELECT * FROM DEPT_TEMP; ------------------------- ���̺� �б�

-- DROP TABLE DEPT_TEMP; -- ���̺� ����
 DELETE FROM DEPT_TEMP -- �� ����
    WHERE DEPTNO = 91;

/* ���̺� �����͸� �߰��ϴ� INSERT �� 
    * INSERT INTO '���̺��̸�' (��1, ��2, .....) VALUE(���� �ش��ϴ� ������, .....)*/
    
-- ù��° ��� : ���̺� ��ϰ� �߰��� ���� ��� ǥ���ϴ� ��
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC) VALUES (50, 'DATABASE', 'SEOUL');
INSERT INTO DEPT_TEMP(LOC, DEPTNO) VALUES ('BUSAN', 60);

-- �ι�° ��� :
INSERT INTO DEPT_TEMP VALUES(70, 'DEVELOPER', 'SUWON');
INSERT INTO DEPT_TEMP VALUES(80, 'GUEST', 'INCHUN');

/* ���̺� NULL ������ �Է��ϱ� */
INSERT INTO DEPT_TEMP VALUES(90, 'WEB', NULL);
INSERT INTO DEPT_TEMP VALUES(91,'MOBILE', '');
INSERT INTO DEPT_TEMP(DEPTNO, LOC) VALUES (92, 'USLAN'); 


/* EMP TABLE �� �����ϸ鼭 ������ ��� */
CREATE TABLE EMP_TEMP
    AS SELECT *
        FROM EMP
        WHERE 1 != 1; -- ���̺��� �����ϸ鼭 �����ʹ� �����ϰ� ���� ���� ��
    
SELECT * FROM EMP_TEMP; -------- ���̺� �б�

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(9001, '������', 'PRESIDENT', NULL, '2020/01/01', 9900, 1000, 10);
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(9002, '�̿���', 'MANAGER', 9999, '2020/05/01', 7000, 500, 20);
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(9003, '������', 'MANAGER', NULL, '2020/07/01', 7000, 800, 30);
        
/* ��¥ �����ʹ� '2020/01/01', '2023-05-01' �Է°���
   * TO_DATE('2021/02/01', 'YYYY/MM/DD')  */
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(9004, '�̹�', 'MANAGER', 9999, '2023-05-01', 4500, 100, 40);
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(9005, 'ä��', 'MANAGER', 9999, TO_DATE('2021/02/01', 'YYYY/MM/DD'), 5500, 300, 40);
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(9006, 'ī����', 'MANAGER', 9999, SYSDATE, 7700, 300, 40);
 
 ----------------------------------------------------------------------------------------------------------------   
        
/* ���̺� �ִ� ������ �����ϱ� 
 
 UPDATE [������ ���̺�]
    SET [������ ��] = [������ ������], [������ ��] = [������ ������] ...
    WHERE ����
    
*/
SELECT * FROM DEPT_TEMP;

UPDATE DEPT_TEMP
    SET LOC = 'SEOUL'; -- ������ ��ü����
    
UPDATE DEPT_TEMP
    SET LOC = 'BUSAN' 
    WHERE DNAME = 'WEB';  -- ������ ���Ǽ���
    
UPDATE DEPT_TEMP
    SET DNAME = 'ANDROID', LOC = 'DAEGU'
    WHERE DEPTNO = 60;

UPDATE DEPT_TEMP
    SET (DNAME, LOC) = (SELECT DNAME, LOC
                            FROM DEPT
                            WHERE DEPTNO = 40)
    WHERE DEPTNO = 40;

/* ���̺� �ִ� ������ �����ϱ� (DELETE) */
CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP;
SELECT * FROM EMP_TEMP2; -- ���̺� ����

DELETE FROM EMP_TEMP2; -- ������ ����
DROP TABLE EMP_TEMP2; -- ���̺� ����

DELETE FROM EMP_TEMP2
    WHERE JOB = 'MANAGER';
    
DELETE FROM EMP_TEMP2
    WHERE COMM IS NULL;
    
/* ���������� ����Ͽ� ������ �����ϱ� */
DELETE FROM EMP_TEMP2
    WHERE EMPNO IN (SELECT E.EMPNO
                        FROM EMP_TEMP2 E, SALGRADE S
                        WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                        AND S.GRADE = 3
                        AND DEPTNO = 30);
                        
---------------------------------��   ��-----------------------------------------------------------------------------------------                        
                        
/* ROWNUM : �࿡ ���� �Ϸù�ȣ�� �����ϴ� Ű���� */
SELECT ROWNUM, ENAME, SAL
    FROM (SELECT *
            FROM EMP
            ORDER BY SAL DESC)
    WHERE ROWNUM <= 3;
/*  �����Լ��� ������ GROUP BY ~ HAVING */

/* LIKE ������ ESCAPE ���� ��� ���õ� �κ� ���� �ʿ� */

/* NULL �� ���� �κ� */

--------------------------------------------------------------------------------------------------------------------------
DROP TABLE EX_EMP;
DROP TABLE EX_DEPT;
-- ��������
CREATE TABLE EX_EMP AS SELECT * FROM EMP;
CREATE TABLE EX_DEPT AS SELECT * FROM DEPT;
CREATE TABLE EX_SALGRADE AS SELECT * FROM SALGRADE;

SELECT * FROM EX_EMP ORDER BY DEPTNO;
SELECT * FROM EX_DEPT;
-- 1. EX_DEPT ���̺� 50, 60, 70, 80�� ����ϴ� SQL���� �ۼ� �ϼ���.
INSERT INTO EX_DEPT VALUES (50, 'ORACLE', 'BUSAN');
INSERT INTO EX_DEPT VALUES (60, 'SQL', 'ILSAN');
INSERT INTO EX_DEPT VALUES (70, 'SELECT', 'INCHEON');
INSERT INTO EX_DEPT VALUES (80, 'DML', 'BUNDANG');

-- 2.EX_EMP ���̺� ���� 8���� ��� ������ ����ϴ� SQL���� �ۼ� �ϼ���.
INSERT INTO EX_EMP VALUES (7201, 'TEST_USER1', 'MANAGER', 7788, '2016/01/02',4500,NULL,50);
INSERT INTO EX_EMP VALUES (7202, 'TEST_USER2', 'CLERK', 7201, '2016/02/21',1800,NULL,50);
INSERT INTO EX_EMP VALUES (7203, 'TEST_USER3', 'ANALYST', 7201, '2016/04/11',3400,NULL,60);
INSERT INTO EX_EMP VALUES (7204, 'TEST_USER4', 'SALESMAN', 7201, '2016/05/31',2700,300,60);
INSERT INTO EX_EMP VALUES (7205, 'TEST_USER5', 'CLERK', 7201, '2016/07/20',2600,NULL,70);
INSERT INTO EX_EMP VALUES (7206, 'TEST_USER6', 'CLERK', 7201, '2016/09/08',2600,NULL,70);
INSERT INTO EX_EMP VALUES (7207, 'TEST_USER7', 'LECTURER', 7201, '2016/10/28',2300,NULL,80);
INSERT INTO EX_EMP VALUES (7208, 'TEST_USER8', 'STUDENT', 7201, '2016/03/09',1200,NULL,80);

-- 3. EX_EMP�� ���� ��� �� 50�� �μ����� �ٹ��ϴ� ������� ��� �޿����� ���� �޿���
--      �ް� �ִ� ������� 70�� �μ��� �ű�� SQL���� �ۼ� �ϼ���.

UPDATE EX_EMP
    SET DEPTNO = 70
    WHERE SAL > (SELECT AVG(SAL)
                    FROM EX_EMP
                    WHERE DEPTNO = 50);
                    
-- 4.  EX_EMP�� ���� ��� ��, 60�� �μ��� ��� �߿� �Ի����� ���� ���� ������� �ʰ� 
--     �Ի��� ����� �޿���10% �λ��ϰ� 80�� �μ��� �ű�� SQL���� �ۼ��ϼ���.  
UPDATE EX_EMP
    SET SAL = SAL * 1.1 , DEPTNO = 80
    WHERE HIREDATE > ANY (SELECT HIREDATE
                        FROM EX_EMP
                        WHERE DEPTNO = 60);
    
                            
-- 5. EX_EMP�� ���� ��� ��, �޿� ����� 5�� ����� �����ϴ� SQL���� �ۼ��ϼ���.
DELETE FROM EX_EMP
     WHERE EMPNO IN (SELECT E.EMPNO
                        FROM EX_EMP E, EX_SALGRADE S
                        WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                        AND S.GRADE = 5);
                        
SELECT * FROM EX_EMP;