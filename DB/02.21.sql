SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;
SELECT * FROM JOBS;

-- 1. EMPLOYEES ���̺��� 100�� �μ��� �ּ� �޿����� �ּ� �޿��� ���� �ٸ� ��� �μ��� ���
SELECT DEPARTMENT_ID
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
        HAVING MIN(SALARY) > (SELECT MIN(SALARY)
                                FROM EMPLOYEES
                                WHERE DEPARTMENT_ID = 100);

-- 2. EMPLOYEES �� DEPARTMENTS ���̺��� ������ SA_MAN ����� ������ ����, ����, �μ���, �ٹ����� ���
SELECT FIRST_NAME || ' ' || LAST_NAME AS ����, JOB_ID AS ����, DEPARTMENT_NAME AS �μ��� , CITY AS �ٹ���
    FROM EMPLOYEES E
    JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
    WHERE JOB_ID = 'SA_MAN';
    
-- 3. EMPLOYEES ���̺��� (���� ���� ���)�� ���� MANAGER�� �����ȣ�� ���
SELECT MANAGER_ID, COUNT(*)
    FROM EMPLOYEES
    GROUP BY MANAGER_ID
        HAVING COUNT(*) IN (SELECT MAX(COUNT(*))
                                FROM EMPLOYEES
                                GROUP BY MANAGER_ID);

-- 4. EMPLOYEES ���̺��� (���� ���� ����� ���� �ִ� �μ� ��ȣ)�� ������� ��� -------------
SELECT DEPARTMENT_ID, COUNT(*)
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
        HAVING COUNT(*) IN (SELECT MAX(COUNT(*))
                                FROM EMPLOYEES
                                GROUP BY DEPARTMENT_ID);

-- 5. ����(JOB)���� �ּұ޿��� �޴� ����� ������ �����ȣ, �̸�, ����, �μ����� ��� (�������� ��������) --------------
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, DEPARTMENT_NAME
    FROM EMPLOYEES E JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE (JOB_ID, SALARY) IN (SELECT JOB_ID, MIN(SALARY)
                        FROM EMPLOYEES
                        GROUP BY JOB_ID)
    ORDER BY JOB_ID DESC;

-- 6. EMPLOYEES ���̺��� (50�� �μ��� �ְ� �޿�)�� �޴� ������� ���� �޿��� �޴� ����� �����ȣ, �̸�, ����, �Ի�����, �޿�, �μ���ȣ�� ��� (�� 50���� ����)
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, HIRE_DATE, SALARY, DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE SALARY > (SELECT MAX(SALARY)
                    FROM EMPLOYEES
                    WHERE DEPARTMENT_ID = 50);
                    
