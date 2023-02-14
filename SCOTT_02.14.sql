-- 2�� 14��

/* IN ������ : ���� ���θ� Ȯ��*/
SELECT *
    FROM EMP
    WHERE JOB = 'MANAGER' 
       OR JOB = 'SALESMAN'
       OR JOB = 'CLERK';
       -- Ư�� ���� ���Ե� �����͸� ������ ������ �� ���
SELECT *
    FROM EMP
    WHERE JOB IN('MANAGER', 'SALESMAN', 'CLERK');
    
/* IN �����ڸ� ����Ͽ� �μ���ȣ�� 10�� 20���� ����� �����ȣ, �̸�, �Ի���, �޿� ��� */
SELECT EMPNO �����ȣ, ENAME �̸�, HIREDATE �Ի���, SAL �޿�
    FROM EMP
    WHERE DEPTNO IN('10', '20');
    
/* � �񱳿����ڿ� AND ������ */
SELECT *
    FROM EMP
    WHERE JOB != 'MANAGER'
      AND JOB <> 'SALESMAN'
      AND JOB ^= 'CLERK';
      
/* ���� ������ �����ϴ� BETWEEN ������ */
-- �޿��� 2000���� 3000 ���̸� ǥ��
SELECT *
    FROM EMP
    WHERE SAL >= 2000
        AND SAL <= 3000;
        
SELECT *
    FROM EMP -- BETWEEN 2000 AND 3000 => 2000�� ���ų� ũ�� 3000�� ���ų� ����
    WHERE SAL BETWEEN 2000 AND 3000;
    
/* BETWEEN ���� ����ؼ� �޿��� 1000���� 2500 �����̰� �μ��� 10, 30�� ����� ��� �ϱ� */

SELECT *
    FROM EMP
    WHERE SAL BETWEEN 1000 AND 2500 
        AND DEPTNO IN(10, 30);
        
/* BETWEEN ���� ����ؼ� �޿��� 1000���� 2500 �����̰�, �μ��� 10,20 �ƴ� ��� ��� */

SELECT *
    FROM EMP
    WHERE SAL BETWEEN 1000 AND 2500 
        AND NOT DEPTNO IN(10, 20);

/* BETWEEN ���� ����ؼ� �����ȣ�� 7000���� 7999 �����̰�, �Ի����� 81�� 5�� 1�� ������ ��� ��� */

SELECT *
    FROM EMP
    WHERE EMPNO BETWEEN 7000 AND 7999
        AND HIREDATE > '81/05/01';
        
/* 1980���� �ƴ� �ؿ� �Ի��� ����� ��ȸ�ؼ� ��� */
SELECT *
    FROM EMP
    WHERE HIREDATE NOT BETWEEN '80/01/01' AND '80/12/31';
-- �ٸ����
SELECT *
    FROM EMP
    WHERE EXTRACT(YEAR FROM HIREDATE) != 1980;
    
/* LIKE ���� �Ϻ� ���ڿ��� ���ԵǾ� �ִ��� ���θ� Ȯ�� �� �� ��� */
-- % : ���̿� ������� ��� ���� �����͸� �ǹ�
-- _ : ���� 1�ڸ� �ǹ�
SELECT *
    FROM EMP
    WHERE ENAME LIKE '_M___';
    
SELECT *
    FROM EMP
    WHERE ENAME LIKE '_L%';

/* �̸��� AM�� ���ԵǾ� �ִ� ��� ��� */
SELECT *
    FROM EMP
    WHERE ENAME LIKE '%AM%';

/* �̸��� AM�� ���ԵǾ� ���� ���� ��� ��� */
SELECT *
    FROM EMP
    WHERE ENAME NOT LIKE '%AM%';
    
/* ���ϵ�ī�� ���ڰ� ������ �Ϻ��� ���*/
INSERT INTO EMP VALUES(9999, 'TEST%PP', 'SALESMAN', 7698, TO_DATE('22-02-14', 'DD-MM-YYYY'), 2000, 1000, 30);

SELECT *
    FROM EMP
    WHERE ENAME LIKE '%\%%' ESCAPE '\';
    
    /* ���̺� �ش��ϴ� �̸��� ������ ���� */
DELETE FROM EMP
    WHERE ENAME = 'TEST%PP';
    
/* IS NULL :  */
-- NULL �̶� ? 0�� �ƴϰ� ������� �ƴ��� �ǹ�. �� ��Ȯ���� ���̶�� �ǹ�
SELECT *
    FROM EMP
    WHERE COMM = NULL; -- NULL�� ���� ���� �� ����
    
SELECT *
    FROM EMP
    WHERE COMM IS NULL;
    
SELECT *
    FROM EMP
    WHERE COMM IS NOT NULL;

/* MGR�� �ִ� ����� ����ϱ� */
SELECT * FROM EMP;

SELECT * FROM EMP
    WHERE MGR IS NOT NULL;

/* ORDER BY : Ư�� �÷��� �����͸� �������� ���������̳� ������������ �����ϴ� ����� �ϴ� �� �Դϴ� */
-- �ݵ�� ���� �������� ����Ǿ�� �ϸ�, �����ϸ� ���� �ʴ�
-- �������� : ASC / �������� : DESC
-- ���������� ������� ������ �⺻������ ASC(��������) �Դϴ�.
SELECT * FROM EMP
    ORDER BY SAL ASC;

/* �����ȣ �������� �������� �����ϱ� */
SELECT * FROM EMP
    ORDER BY EMPNO;
    
/* �޿� �������� �������� �ϰ� �޿��� ���� ��� �̸� ����  */
SELECT * FROM EMP
    ORDER BY SAL, ENAME;

/* �޿� �������� �������� �ϰ� �޿��� ���� ��� �̸� �������� ����  */
SELECT * FROM EMP
    ORDER BY SAL, ENAME DESC;
    
/* ��Ī���� ORDER BY */
SELECT EMPNO �����ȣ, ENAME �����, SAL ����, HIREDATE �Ի���
    FROM EMP
    ORDER BY ���� DESC, ����� ASC;
    
/* ���� ������ : SELECT ��ȸ�� �÷� ���̿� Ư���� ���ڸ� �ְ� ���� �� ����ϴ� ������ */
SELECT ENAME || 'S JOB IS ' || JOB AS EMPLOYEE
    FROM EMP;

SELECT * FROM EMP;
    
/* �ǽ� ���� */    
    
/* 1�� */
SELECT * FROM EMP
    WHERE ENAME LIKE '%S';

/* 2�� */
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP
    WHERE DEPTNO IN 30
    AND JOB IN 'SALESMAN';

/* 3�� */
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
    WHERE DEPTNO IN (20, 30)
    AND SAL > 2000;

/* 4�� */
SELECT * FROM EMP
    WHERE SAL < 2000 OR SAL > 3000;

/* 5�� */
SELECT ENAME, EMPNO, SAL, DEPTNO FROM EMP
    WHERE ENAME LIKE '%E%' 
    AND DEPTNO IN 30
    AND SAL NOT BETWEEN 1000 AND 2000;

/* 6�� */
SELECT * FROM EMP
    WHERE COMM IS NULL
    AND MGR IS NOT NULL
    AND ENAME NOT LIKE '_L%';





    
