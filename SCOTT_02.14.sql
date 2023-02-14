-- 2월 14일

/* IN 연산자 : 포함 여부를 확인*/
SELECT *
    FROM EMP
    WHERE JOB = 'MANAGER' 
       OR JOB = 'SALESMAN'
       OR JOB = 'CLERK';
       -- 특정 열에 포함된 데이터를 여러개 조합할 때 사용
SELECT *
    FROM EMP
    WHERE JOB IN('MANAGER', 'SALESMAN', 'CLERK');
    
/* IN 연산자를 사용하여 부서번호가 10과 20번인 사원의 사원번호, 이름, 입사일, 급여 출력 */
SELECT EMPNO 사원번호, ENAME 이름, HIREDATE 입사일, SAL 급여
    FROM EMP
    WHERE DEPTNO IN('10', '20');
    
/* 등가 비교연산자와 AND 연산자 */
SELECT *
    FROM EMP
    WHERE JOB != 'MANAGER'
      AND JOB <> 'SALESMAN'
      AND JOB ^= 'CLERK';
      
/* 일정 범위를 지정하는 BETWEEN 연산자 */
-- 급여가 2000에서 3000 사이를 표시
SELECT *
    FROM EMP
    WHERE SAL >= 2000
        AND SAL <= 3000;
        
SELECT *
    FROM EMP -- BETWEEN 2000 AND 3000 => 2000과 같거나 크고 3000과 같거나 작음
    WHERE SAL BETWEEN 2000 AND 3000;
    
/* BETWEEN 절을 사용해서 급여가 1000에서 2500 사이이고 부서가 10, 30인 사원을 출력 하기 */

SELECT *
    FROM EMP
    WHERE SAL BETWEEN 1000 AND 2500 
        AND DEPTNO IN(10, 30);
        
/* BETWEEN 절을 사용해서 급여가 1000에서 2500 사이이고, 부서가 10,20 아닌 사원 출력 */

SELECT *
    FROM EMP
    WHERE SAL BETWEEN 1000 AND 2500 
        AND NOT DEPTNO IN(10, 20);

/* BETWEEN 절을 사용해서 사원번호가 7000에서 7999 사이이고, 입사일이 81년 5월 1일 이후인 사람 출력 */

SELECT *
    FROM EMP
    WHERE EMPNO BETWEEN 7000 AND 7999
        AND HIREDATE > '81/05/01';
        
/* 1980년이 아닌 해에 입사한 사원을 조회해서 출력 */
SELECT *
    FROM EMP
    WHERE HIREDATE NOT BETWEEN '80/01/01' AND '80/12/31';
-- 다른방법
SELECT *
    FROM EMP
    WHERE EXTRACT(YEAR FROM HIREDATE) != 1980;
    
/* LIKE 절은 일부 문자열이 포함되어 있는지 여부를 확인 할 때 사용 */
-- % : 길이와 상관없이 모든 문자 데이터를 의미
-- _ : 문자 1자를 의미
SELECT *
    FROM EMP
    WHERE ENAME LIKE '_M___';
    
SELECT *
    FROM EMP
    WHERE ENAME LIKE '_L%';

/* 이름에 AM이 포함되어 있는 사원 출력 */
SELECT *
    FROM EMP
    WHERE ENAME LIKE '%AM%';

/* 이름에 AM이 포함되어 있지 않은 사원 출력 */
SELECT *
    FROM EMP
    WHERE ENAME NOT LIKE '%AM%';
    
/* 와일드카드 문자가 데이터 일부일 경우*/
INSERT INTO EMP VALUES(9999, 'TEST%PP', 'SALESMAN', 7698, TO_DATE('22-02-14', 'DD-MM-YYYY'), 2000, 1000, 30);

SELECT *
    FROM EMP
    WHERE ENAME LIKE '%\%%' ESCAPE '\';
    
    /* 테이블에 해당하는 이름의 데이터 삭제 */
DELETE FROM EMP
    WHERE ENAME = 'TEST%PP';
    
/* IS NULL :  */
-- NULL 이란 ? 0이 아니고 빈공간이 아님을 의미. 즉 미확정된 값이라는 의미
SELECT *
    FROM EMP
    WHERE COMM = NULL; -- NULL은 값을 비교할 수 없음
    
SELECT *
    FROM EMP
    WHERE COMM IS NULL;
    
SELECT *
    FROM EMP
    WHERE COMM IS NOT NULL;

/* MGR이 있는 사원만 출력하기 */
SELECT * FROM EMP;

SELECT * FROM EMP
    WHERE MGR IS NOT NULL;

/* ORDER BY : 특정 컬럼의 데이터를 기준으로 오름차순이나 내림차순으로 정렬하는 기능을 하는 절 입니다 */
-- 반드시 가장 마지막에 기술되어야 하며, 남발하면 좋지 않다
-- 오름차순 : ASC / 내림차순 : DESC
-- 정렬조건을 기술하지 않으면 기본적으로 ASC(오름차순) 입니다.
SELECT * FROM EMP
    ORDER BY SAL ASC;

/* 사원번호 기준으로 오름차순 정렬하기 */
SELECT * FROM EMP
    ORDER BY EMPNO;
    
/* 급여 기준으로 오름차순 하고 급여가 같은 경우 이름 기준  */
SELECT * FROM EMP
    ORDER BY SAL, ENAME;

/* 급여 기준으로 오름차순 하고 급여가 같은 경우 이름 내림차순 정렬  */
SELECT * FROM EMP
    ORDER BY SAL, ENAME DESC;
    
/* 별칭사용과 ORDER BY */
SELECT EMPNO 사원번호, ENAME 사원명, SAL 월급, HIREDATE 입사일
    FROM EMP
    ORDER BY 월급 DESC, 사원명 ASC;
    
/* 연결 연산자 : SELECT 조회시 컬럼 사이에 특정한 문자를 넣고 싶을 때 사용하는 연산자 */
SELECT ENAME || 'S JOB IS ' || JOB AS EMPLOYEE
    FROM EMP;

SELECT * FROM EMP;
    
/* 실습 문제 */    
    
/* 1번 */
SELECT * FROM EMP
    WHERE ENAME LIKE '%S';

/* 2번 */
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP
    WHERE DEPTNO IN 30
    AND JOB IN 'SALESMAN';

/* 3번 */
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
    WHERE DEPTNO IN (20, 30)
    AND SAL > 2000;

/* 4번 */
SELECT * FROM EMP
    WHERE SAL < 2000 OR SAL > 3000;

/* 5번 */
SELECT ENAME, EMPNO, SAL, DEPTNO FROM EMP
    WHERE ENAME LIKE '%E%' 
    AND DEPTNO IN 30
    AND SAL NOT BETWEEN 1000 AND 2000;

/* 6번 */
SELECT * FROM EMP
    WHERE COMM IS NULL
    AND MGR IS NOT NULL
    AND ENAME NOT LIKE '_L%';





    
