/* ���� ������ : �� �� �̻��� ���� ����� �ϳ��� �����ϴ� ������ */
-- UNION : ������, �ߺ� ����
-- UNION ALL : ������, �ߺ� ���� X
-- MINUS : ������
-- INTERSECT : ������

-- UNION : ������, �ߺ� ����
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE DEPTNO = 20
    ORDER BY DEPTNO;
    
-- UNION ALL : ������, �ߺ����� X
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP   
    WHERE DEPTNO = 10
UNION ALL
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE DEPTNO = 10;
    
-- INTERSECT : ������ . �ΰ��� �������� ��� ���ԵǾ� �ִ� �����͸� ǥ��
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL > 1000
INTERSECT
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL < 2000;
    
-- MINUS(������) : ���� ������ ������� ���� ������ ����� �� ��
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL > 1000
MINUS
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL > 2000;

SELECT * FROM DEPT;

/* JOIN */ 
-- JOIN �� �ΰ� �̻��� ���̺��� �����͸� �����ͼ� �����ϴ� �� ���Ǵ� SQL�� ���
-- ���̺��� �ĺ� ���� Primary KEY�� ���̺� �� ���� ���� Foreign KEY ���� ����Ͽ� ����
-- INNER JOIN : �� ���̺��� ��ġ�ϴ� �����͸� ����
-- LEFT JOIN : ���� ���̺��� ��� �����Ϳ� ������ �����Ϳ��� ��ġ�ϴ� �����͸� ����
-- RIGHT JOIN : ������ ���̺��� ��� �����Ϳ� ���� ���̺��� ��ġ�ϴ� ������ ����

-- �ΰ��� ���̺��� ��� ���� ���յǾ� ������ * ������ ��ŭ�� ����� ǥ�õȴ�. (ī�׽þ� ��)
SELECT *
    FROM EMP, DEPT
    ORDER BY EMPNO;

SELECT *
    FROM EMP e, DEPT d
    WHERE e.DEPTNO = d.DEPTNO;
    
/* ���̺� ��Ī �ֱ� : ���� ���̺� ��ο� �����ϴ� ���� ���ؼ��� ���̺� �̸��� ����ؾ� �� */ 
SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC 
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND E.JOB = 'MANAGER';
    
/* � ���� */
-- ���̺��� ������ �Ŀ� ��� ���� �� ���̺��� Ư�� ���� ��ġ�� �����͸� �������� �����ϴ� ���
-- ����Ŭ 9i ������ ����Ŭ ���θ� ��� �� �� �־�����,  ����Ŭ 10g ���ʹ� Ansi ������ �߰��� ��밡��

-- ANSI ���� ������� �����ϱ�
SELECT EMPNO, ENAME, E.DEPTNO, DNAME
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE E.JOB = 'MANAGER';
    
-- EMP�� DEPT ���̺��� �����ϰ�, �޿��� 3000�̻��� ��� ���� ���
-- �����ȣ, �̸�, �޿� �Ի��� �μ���ȣ, �μ��̸�
SELECT EMPNO, ENAME, SAL, HIREDATE, E.DEPTNO, DNAME
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND SAL >= 3000;
    
SELECT EMPNO, ENAME, SAL, HIREDATE, E.DEPTNO, DNAME
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE SAL >= 3000;
    
/* EMP ü�̺� ��Ī�� E��, DEPT ���̺� ��Ī�� D�� �Ͽ� ������ ���� � ������ ������,
   �޿��� 2500 �����̰� �����ȣ�� 9999������ ����� ������ ��µǵ��� �ۼ� */
   
SELECT EMPNO, ENAME, SAL, HIREDATE, E.DEPTNO, DNAME
    FROM EMP E, DEPT d
    WHERE E.DEPTNO = D.DEPTNO
    AND SAL <= 2500 AND EMPNO < 9999;
    
SELECT EMPNO, ENAME, SAL, HIREDATE, E.DEPTNO, DNAME
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE SAL <= 2500 AND EMPNO < 9999;
    
/* �� ���� : ���� ���� �ƴ� �ٸ� ������ ����Ͽ� ���� �� �� ���. (���� ������ ����, �ڹ��� ���񽺷������� �ϸ� ��) */
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

-- �޿��� ���� ����� ǥ���ϱ� ���ؼ��� �޿��� �ݾ��� ��ġ�� �� �����Ƿ� �ּҿ� �ִ�޿� ���̷� ��Ÿ������
-- �Ʒ� ��� BETWEEN A AND B �����ڸ� ����ؼ� ó�� ����
SELECT ENAME, SAL, GRADE
    FROM EMP E JOIN SALGRADE S
    ON SAL BETWEEN LOSAL AND HISAL;
    
/* ��ü ���� : ���� ���̺��� �ι� ����ϴ� �� */
SELECT E1.EMPNO, E1.ENAME, /*E1.MGR,*/
        E2.EMPNO AS MGR_EMPNO,
        E2.ENAME AS MGR_ENAME
        FROM EMP E1 JOIN EMP E2
        ON E1.MGR = E2.EMPNO;

/*��������(INNER JOIN) �Ǵ� ���������� ��� ������ �÷�(��)�� ���� ���ٸ� ��ȸ���� ����*/
/* �ܺ� ����(OUTER JOIN) : ���� ���ΰ� �ٸ��� ������� ���� ���� ǥ���Ѵ�.  */

-- ANSI ����
SELECT ENAME, E.DEPTNO, DNAME
    FROM EMP E RIGHT OUTER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    ORDER BY E.DEPTNO;
    
-- ORACLE ����
SELECT ENAME, E.DEPTNO, DNAME
    FROM EMP E , DEPT D
    WHERE E.DEPTNO(+) = D.DEPTNO
    ORDER BY E.DEPTNO;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

-- 1. �����ȣ�� 7499�� ����� �̸�, �Ի��� �μ���ȣ ���
SELECT ENAME, HIREDATE, DEPTNO
    FROM EMP
    WHERE EMPNO = 7499;
    
-- 2. �̸��� ALLEN�� ����� ��� ���� ���
SELECT *
    FROM EMP
    WHERE ENAME = 'ALLEN';
    
-- 3. �̸��� K���� ū ���ڷ� �����ϴ� ����� ��� ���� ���
SELECT *
    FROM EMP
    WHERE ENAME > 'K';
    --WHERE SUBSTR(ENAME,1,1) > 'K';
    
-- 4.�Ի����� 81�� 4��2�� ���� �ʰ�, 82�� 12��9�� ���� ���� ����� �̸�, �޿�, �μ���ȣ ���
SELECT ENAME, SAL, DEPTNO, HIREDATE
    FROM EMP
    WHERE HIREDATE BETWEEN '81/04/03' AND '82/12/08';
    
-- 5.�޿��� 1,600 ���� ũ��, 3000���� ���� ����� �̸�, ����, �޿��� ���
SELECT ENAME, JOB, SAL
    FROM EMP
    WHERE SAL BETWEEN 1601 AND 2999;
    
-- 6. �Ի����� 81�� �̿ܿ� �Ի��� ����� ��� ���� ���
SELECT *
    FROM EMP
    WHERE HIREDATE NOT BETWEEN '81/01/01' AND '81/12/31';
    
SELECT *
    FROM EMP
    WHERE EXTRACT(YEAR FROM HIREDATE) != 1981;
    
-- 7.������ MANAGER�� SALESMAN�� ����� ��� ������ ���
SELECT *
    FROM EMP
    WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN';
    
-- 8. �μ��� 20��, 30���� ������ ��� ����� �̸�, �����ȣ, �μ���ȣ�� ���
SELECT ENAME, EMPNO, DEPTNO
    FROM EMP
    WHERE NOT DEPTNO IN(20,30);

-- 9. �̸��� S�� �����ϴ� ����� �����ȣ, �̸�, �μ���ȣ ���
SELECT EMPNO, ENAME, DEPTNO
    FROM EMP
    WHERE SUBSTR(ENAME, 1, 1) = 'S';
    
SELECT EMPNO, ENAME, DEPTNO
    FROM EMP
    WHERE ENAME LIKE 'S%';
    
-- 10. ó�� ���ڴ� �������, �� ��° ���ڰ� A�� ����� ��� ������ ���
SELECT *
    FROM EMP
    WHERE ENAME LIKE '_A%';
    
-- 11. Ŀ�̼��� NULL�� �ƴ� ����� ��� ������ ���
SELECT *
    FROM EMP
    WHERE COMM IS NOT NULL;
    
-- 12. �̸��� J�ڷ� �����ϰ� ������ ���ڰ� S�� ����� ��� ������ ���
SELECT *
    FROM EMP
    WHERE ENAME LIKE 'J%S';

-- 13. �޿��� 1500�̻��̰�, �μ���ȣ�� 30���� ��� �� ������ MANAGER�� ����� ��� ���� ���
SELECT *
    FROM EMP
    WHERE SAL >= 1500
    AND DEPTNO = 30
    AND JOB = 'MANAGER';

-- 14. ��� ����� �̸�, �޿�, Ŀ�̼�, �Ѿ�(�޿�+Ŀ�̼�)�� ���Ͽ� �Ѿ��� ���� ������ ��� 
--     (��, Ŀ�̼��� null�� ����� 0���� ����)
SELECT ENAME, SAL, NVL(COMM, 0), SAL + NVL(COMM, 0) �Ѿ�
    FROM EMP
    ORDER BY SAL + NVL(COMM, 0) DESC;
    
-- 15. 10�� �μ��� ��� ������� �޿��� 13%�� ���ʽ��� �����ϱ�� �Ͽ���. 
--     10�� �μ� ������� �̸�, �޿�, ���ʽ�, �μ���ȣ ���
SELECT ENAME, SAL, SAL*1.13, DEPTNO
    FROM EMP
    WHERE DEPTNO = 10;
    
-- 16. ��� ����� ���� �Ի��� ���� ���� 60���� ���� ���� �������ϡ��� ���� ��,��,�ϸ� ���Ͽ� 
--     �̸�, �Ի���, 60�� ���� �������ϡ� ��¥�� ���
SELECT ENAME, HIREDATE,
    TO_CHAR(NEXT_DAY(HIREDATE+60,'������'), 'YYYY/MM/DD')
    FROM EMP;
    
-- 17.�̸��� ���ڼ��� 6�� �̻��� ����� �̸��� �տ��� 3�ڸ� ���Ͽ� �ҹ��ڷ� �̸��� ���
SELECT LOWER(SUBSTR(ENAME,1,3))
    FROM EMP
    WHERE LENGTH(ENAME) >= 6;
    
-- 18. ������� ��� ��ȣ�� �޿�, Ŀ�̼�, ����((comm+sal)*12)�� ������ ���� ������ ���
SELECT EMPNO, SAL, NVL(COMM,0), (NVL(COMM,0)+SAL) * 12 ����
    FROM EMP
    ORDER BY ���� DESC;
    
-- 19. ��� ������� �Ի��� ��/��/�� 
SELECT TO_CHAR(HIREDATE, 'YYYY"��"MM"��"DD"��"') FROM EMP;

-- 20. 10�� �μ��� ���� �޿��� ��� ��, �ִ� ��, �ּ� ��, �ο� ���� ���
SELECT AVG(SAL), MAX(SAL), MIN(SAL), COUNT(*)
    FROM EMP
    WHERE DEPTNO = 10;
    
-- 21. �����ȣ�� ¦���� ������� ��� ������ ���
SELECT *
    FROM EMP
    WHERE MOD(EMPNO,2) = 0;
    
-- 22. �� �μ��� ���� ������ ���� ����� �ο����� ���Ͽ� �μ� ��ȣ, ����, �ο��� ���
SELECT DEPTNO, JOB, COUNT(*)
    FROM EMP
    GROUP BY DEPTNO, JOB
    ORDER BY DEPTNO, JOB;
    
-- 23. EMP�� DEPT���̺��� �����Ͽ� ��� ����� ���� �μ� ��ȣ, �μ��̸�, ����̸� �޿��� ���
SELECT E.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO;
    
-- 24. �̸��� ��ALLEN���� ����� �μ� ��ȣ, �μ� �̸�, ��� �̸�, �޿� ���
SELECT E.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE ENAME = 'ALLEN';
    
-- 25. ��ALLEN���� ������ ���� ����� �̸�, �μ� �̸�, �޿�, �μ���ġ�� ���
SELECT E.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE JOB = (SELECT JOB 
                    FROM EMP
                    WHERE ENAME = 'ALLEN');
    
    
-- 26. ��� ������� ��� �޿� ���� ���� �޴� ������� �����ȣ�� �̸� ���
SELECT EMPNO, ENAME
    FROM EMP
    WHERE SAL > (SELECT AVG(SAL) --- ???
                    FROM EMP);

-- 27. �μ��� ��� �޿��� 2000���� ���� �μ� ������� �μ� ��ȣ ���
SELECT DEPTNO
    FROM EMP
    GROUP BY DEPTNO
        HAVING AVG(SAL) < 2000; 
        
-- 28. 30�� �μ��� �ְ�޿����� �޿��� ���� ����� ��� ��ȣ, �̸�, �޿��� ���
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL > (SELECT MAX(SAL)
                    FROM EMP
                    WHERE DEPTNO = 30);

SELECT MAX(SAL)
    FROM EMP;