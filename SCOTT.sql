-- = 단일행에 대한 주석
/* = 범위 주석 */

/* 사원 정보 테이블 */
DESC EMP;
/* 보너스 테이블 */
DESC BONUS;
/* 급여 정보 테이블 */
DESC SALGRADE;

/* SELECT문은 데이터베이스에 저장된 데이터를 조회하는데 사용되는 구문 입니다 */
/* SELECT (조회할 열 .....) FROM 조회할테이블 */
SELECT * FROM EMP;
SELECT EMPNO, ENAME, HIREDATE FROM EMP;

/* 사원 번호와 부서 번호만 나오도록 쿼리문 작성 */
SELECT EMPNO, DEPTNO FROM EMP;

/* 별칭 사용 하기 */
SELECT EMPNO "번 호", ENAME "이 름" FROM EMP;
SELECT EMPNO 번호, ENAME 이름 FROM EMP;
SELECT EMPNO AS 번호, ENAME AS 이름 FROM EMP;

SELECT ENAME, SAL, SAL*12+COMM AS "연 봉", COMM FROM EMP;

SHOW USER; -- 현재 USER를 표시함
SELECT * FROM TAB;

/* 중복 제거(DISTINCT) : 데이터를 조회할 때 값이 중복되는 행이 여러 개 조회되는데, 값이 중복된 행을 한개씩만 선택하고자 할 때 사용하는 키워드 */
SELECT DISTINCT DEPTNO FROM EMP;
SELECT DISTINCT JOB, DEPTNO FROM EMP; -- 두가지 조건에 대한 중복 제거

/* 컴럼값 계산하는 산술연산자(+, -, *, /) : 자료형이 숫자인 컬럼값들을 계산한 값을 조회하고 싶을 때 사용 */
SELECT ENAME, SAL, SAL * 12 AS "연 봉"
FROM EMP;

/* 연습문제 :  +JOB 열에 대해 중복 없이 출력 해보기 */
SELECT DISTINCT JOB FROM EMP;

/* WHRER 구문 : 데이터를 조회할 떄 사용자가 원하는 조건에 맞는 데이터만을 조회하고 싶을 떄 사용 하는 것 */
SELECT  *
    FROM EMP
    WHERE DEPTNO = 10; -- SQL에서 같은지 비교하는 연산자는 = 입니다.

/* WHERE 구문을 사용해 사원 번호가 7500 보다 큰 사람만 골라서 사원번호, 사원이름, 입사일, 부서번호 출력 */
SELECT EMPNO, ENAME, HIREDATE, DEPTNO
    FROM EMP
    WHERE EMPNO > 7500;
    
/* 급여가 2500 이상의 사원번호, 이름, 직무, 급여 출력 */
SELECT EMPNO, ENAME, JOB, SAL
    FROM EMP
    WHERE SAL > 2500;
    
/* 산술연산자 : +, -, *, / */
SELECT *
    FROM EMP
    WHERE SAL * 12 = 36000;
    
/* 비교연산자 : >, >=, <, <= */
SELECT *
    FROM EMP
    WHERE COMM >= 500; -- 보너스가 500 이상인 사람만 출력
    
DESC EMP;
    
/* 입사일이 81년 1월 1일 이후인 사람을 모두 출력 */
SELECT *
    FROM EMP
    WHERE HIREDATE > '81/01/01'; -- 날짜를 비교하거나 문자열을 비교할 떄는 ''를 감싸주어야 한다.
    
/* 직업이 세일즈맨인 사람만 출력 */
SELECT *
    FROM EMP
    WHERE JOB = 'SALESMAN';
    
/* 논리연산자 : AND, OR, NOT */
-- 급여가 2500과 같거나 크고 부서가 20번인 사람을 출력하기 (둘다 조건을 만족해야 하므로 AND)
SELECT *
    FROM EMP
    WHERE SAL >= 2500 AND DEPTNO = 20;
    
-- 급여가 2500과 같거나 큰 사람이나 부서가 20번인 사람을 출력
SELECT *
    FROM EMP
    WHERE SAL >= 2500 OR DEPTNO = 20;
    
-- 급여가 2500이상이고 부서가 20번이고 입사일이 81년 1월 1일 이전 입사자 출력
SELECT *
    FROM EMP
    WHERE SAL > 2500 AND HIREDATE < '82/01/01' AND DEPTNO = 20;
    
SELECT * FROM EMP;

-- 급여가 2000 이상이고 직업이 MANAGER인 사원의 사원번호, 이름, 직책, 급여, 부서번호를 출력하세요
SELECT EMPNO,ENAME, JOB, SAL, DEPTNO 
    FROM EMP
    WHERE SAL >= 2000 AND JOB = 'MANAGER';
    
-- 부정의 연산자 사용하기 : NOT
-- 급여가 2500 이고, 직책이 SALESMAN이 아닌 사람만 출력

SELECT EMPNO,ENAME, JOB, SAL, DEPTNO 
    FROM EMP
    WHERE SAL >= 2500 AND NOT JOB = 'SALESMAN';
    
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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





    
