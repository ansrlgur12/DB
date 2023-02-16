SELECT * FROM EMP;
SELECT ENAME, SAL FROM EMP;

SELECT  DEPTNO, SUM(SAL)
    FROM EMP
    GROUP BY DEPTNO;
    
SELECT JOB, AVG(SAL)
    FROM EMP
    GROUP BY JOB;
    
SELECT JOB, COUNT(*)
    FROM EMP
    GROUP BY JOB;

SELECT JOB, MAX(SAL), MIN(SAL)
    FROM EMP
    GROUP BY JOB;
    
SELECT DEPTNO, MAX(SAL), MIN(SAL)
    FROM EMP
    GROUP BY DEPTNO;
    
/* �հ� ���ϴ� SUM �Լ� */
-- DISTINCT : �ߺ� ����
-- ALL : ������� �ʾƵ� �⺻������ ALL Ư���� ����
SELECT * FROM EMP;

SELECT SUM(DISTINCT SAL) AS �ߺ�����, SUM(ALL SAL) AS ����, SUM(SAL) AS �⺻
    FROM EMP;
    
SELECT SUM(SAL), SUM(COMM) FROM EMP;

SELECT COUNT(*) FROM EMP;
SELECT COUNT(COMM) FROM EMP; -- COMM ���� NULL�� �ƴѻ��

SELECT COUNT(COMM)
    FROM EMP
    WHERE COMM IS NOT NULL;
    
-- �μ� ��ȣ�� 20�� ��� �� �Ի����� ���� �ֱ��� ���
SELECT MAX(HIREDATE)
    FROM EMP
    WHERE DEPTNO = 20;
    
/* GROUP BY : �ϳ��� ����� Ư�� ���� ��� ����ϴ� ���� �׷�ȭ�Ѵٰ� �Ѵ�. */ 
-- �̋� ����ؾ� �� ����� GROUP BY�� �����Ѵ�

SELECT TRUNC(AVG(SAL)), DEPTNO
FROM EMP
GROUP BY DEPTNO;

SELECT TRUNC(AVG(SAL))FROM EMP WHERE DEPTNO = 10;
SELECT TRUNC(AVG(SAL)) FROM EMP WHERE DEPTNO = 20;
SELECT TRUNC(AVG(SAL)) FROM EMP WHERE DEPTNO = 30;

 /*�μ� ��ȣ �� ��å�� ��� �޿��� �����ϱ�*/
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    ORDER BY DEPTNO, JOB;

/* GROUP BY���� ����Ͽ� �μ� ��ȣ�� ��� �߰������� ��� */
SELECT AVG(COMM), DEPTNO
    FROM EMP
    GROUP BY DEPTNO;
    
/* �μ� �ڵ�, �޿� �հ�, �μ� ���, �μ� �ڵ� �� ���� */
SELECT DEPTNO �μ��ڵ�, SUM(SAL) �հ�, FLOOR(AVG(SAL)) ���, COUNT(*) �ο���
    FROM EMP
     GROUP BY DEPTNO;
     
     
/* HAVING * GRUOP BY ���� ������ ���� ����� �� ����.*/
-- �׷�ȭ�� ���� ������ �����ϴ� �뵵�� ���
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
        HAVING AVG(SAL) >= 2000
    ORDER BY DEPTNO, JOB;
    
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
--        WHERE AVG(SAL) >= 2000
        GROUP BY DEPTNO, JOB
        ORDER BY DEPTNO, JOB;
        
/* WHERE ���� HAVING ���� ��� ����ϴ� ��� */
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    WHERE SAL <= 2500
    GROUP BY DEPTNO, JOB
        HAVING AVG(SAL) >= 2000
    ORDER BY DEPTNO, JOB;
    
-- 1.HAVING���� ����Ͽ� EMP ���̺��� �μ��� ��å�� ��� �޿��� 500 �̻��� ������� 
--   �μ� ��ȣ, ��å, �μ��� ��å�� ��� �޿��� ���
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
        HAVING AVG(SAL) >= 500;

-- 2. EMP ���̺��� �̿��Ͽ� �μ���ȣ, ��ձ޿�, �ְ�޿�, �����޿�, ������� ���,  
--   ��, ��� �޿��� ��� �� ���� �Ҽ��� �����ϰ� �μ� ��ȣ���� ���
SELECT DEPTNO, TRUNC(AVG(SAL)) ��ձ޿�,
    MAX(SAL) �ְ�޿�,
    MIN(SAL) �����޿�,
    COUNT(*) �����
    FROM EMP
    GROUP BY DEPTNO;
    
-- 3. ���� ��å�� �����ϴ� ����� 3�� �̻��� ��å�� �ο��� ���
SELECT JOB ����, COUNT(JOB) �����
    FROM EMP
    GROUP BY JOB
        HAVING COUNT(JOB) >= 3;
        
-- 4. ������� �Ի� ������ �������� �μ����� �� ���� �Ի��ߴ��� ���
SELECT EXTRACT(YEAR FROM HIREDATE)�Ի���, DEPTNO, COUNT(*)�����
    FROM EMP
    GROUP BY EXTRACT(YEAR FROM HIREDATE), DEPTNO
    ORDER BY COUNT(*);
    
-- 5. �߰� ������ �޴� ��� ���� ���� �ʴ� ������� ��� (O, X�� ǥ�� �ʿ�)
SELECT NVL2(COMM, 'O', 'X') �߰�����, COUNT(*) �����
    FROM EMP
    GROUP BY NVL2(COMM, 'O', 'X');
    
-- 6. �� �μ��� �Ի� ������ ��� ��, �ְ� �޿�, �޿� ��, ��� �޿��� ���
SELECT DEPTNO, EXTRACT(YEAR FROM HIREDATE) �Ի�⵵, COUNT(*) �����, MAX(SAL)�ְ�޿�, TRUNC(AVG(SAL)) ��ձ޿�, SUM(SAL) �հ�
    FROM EMP
    GROUP BY DEPTNO, EXTRACT(YEAR FROM HIREDATE)
    ORDER BY DEPTNO, EXTRACT(YEAR FROM HIREDATE);
    
