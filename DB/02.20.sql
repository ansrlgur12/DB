-- 23.02.20
-- ANSI 조인
-- NATURAL JOIN : 동등조인과 비슷하지만 WHERE 조건절 없이 조인하는 방식
-- 두 테이블의 동일한 이름을 갖는 컬럼은 모두 조인 됨
-- DEPTNO 열이 양쪽 테이블에 모두 존재함
SELECT EMPNO, ENAME, DNAME
    FROM EMP NATURAL JOIN DEPT;
    
-- 일반적인 동등조인 경우는 아래의 쿼리문에 에러가 발생한다.(DEPTNO가 어디 소속인지 모호성이 발생)
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, DNAME, LOC
    FROM EMP NATURAL JOIN DEPT
    ORDER BY DEPTNO, EMPNO;
    
-- JOIN ~USING : 기존의 등가 조인을 대신하는 조인 방식
-- FROM TABLE1 JOIN TABLE2 USING(기준열)
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, DNAME, LOC
    FROM EMP JOIN DEPT USING(DEPTNO)
    WHERE SAL >= 3000
    ORDER BY DEPTNO, EMPNO;
    
-- JOIN ~ ON : 가장 범용성 있는 JOIN~ON 키워드를 사용한 조인 방식
-- FROM TABLE1 JOIN TABLE2 ON (조인 조건식)
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, E.DEPTNO, DNAME, LOC
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE SAL <= 3000
    ORDER BY E.DEPTNO;
    
-- ANSI OUTER JOIN

-- LEFT OUTER JOIN : 왼쪽 테이블 기준으로 오른쪽 테이블의 모든 행이 출력됨
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, E.DEPTNO, DNAME, LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO(+);
-- ANSI
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, E.DEPTNO, DNAME, LOC
    FROM EMP E LEFT OUTER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO;
    
-- RIGHT OUTER JOIN : 오른쪽 테이블 기준으로 오른쪽 테이블의 모든 행이 출력됨
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, E.DEPTNO, DNAME, LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO(+) = D.DEPTNO;
-- ANSI
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, E.DEPTNO, DNAME, LOC
    FROM EMP E RIGHT OUTER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO;
    
/* 연습 문제 */
-- 1. 급여가 2000 초과인 사원들의 부서정보, 부서번호, 부서이름, 사원이름, 급여 표시
-- 오라클 문법과 ANSI 문법으로 표시(NATURAL JOIN, JOIN USING, JOIN ON)
SELECT E.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND SAL > 2000;
    
SELECT DEPTNO, DNAME, ENAME, SAL
    FROM EMP NATURAL JOIN DEPT
    WHERE SAL > 2000;
    
SELECT DEPTNO, DNAME, ENAME, SAL
    FROM EMP JOIN DEPT USING(DEPTNO)
    WHERE SAL > 2000;

SELECT E.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE SAL > 2000;
    
    
-- 2. 각 부서별 평균 급여, 최대 급여, 최소 급여, 사원 수 출력
-- 오라클 문법과 ANSI 문법으로 표시(NATURAL JOIN, JOIN USING, JOIN ON)

SELECT E.DEPTNO, DNAME, TRUNC(AVG(SAL)), MAX(SAL), MIN(SAL), COUNT(*)
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    GROUP BY E.DEPTNO, DNAME;

SELECT DEPTNO, DNAME, TRUNC(AVG(SAL)),  MAX(SAL), MIN(SAL), COUNT(*)
    FROM EMP NATURAL JOIN DEPT
    GROUP BY DEPTNO, DNAME;
    
SELECT DEPTNO, DNAME, TRUNC(AVG(SAL)),  MAX(SAL), MIN(SAL), COUNT(*)
    FROM EMP JOIN DEPT USING(DEPTNO)
    GROUP BY DEPTNO, DNAME;


SELECT E.DEPTNO, DNAME, TRUNC(AVG(SAL)),  MAX(SAL), MIN(SAL), COUNT(*)
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    GROUP BY E.DEPTNO, DNAME;

-- 3. 모든 부서 정보와 사원 정보를 (부서번호, 부서이름, 사원번호, 사원 이름, 직책, 급여) 사원 이름순으로 출력
-- 오라클 문법과 ANSI 문법으로 표시(NATURAL JOIN, JOIN USING, JOIN ON)

SELECT E.DEPTNO, DNAME, EMPNO, ENAME, JOB, SAL
    FROM EMP E, DEPT D
    WHERE E.DEPTNO(+) = D.DEPTNO
    ORDER BY ENAME;
    
SELECT DEPTNO, DNAME, EMPNO, ENAME, JOB, SAL
    FROM EMP NATURAL JOIN DEPT
    ORDER BY ENAME;

SELECT DEPTNO, DNAME, EMPNO, ENAME, JOB, SAL
    FROM EMP RIGHT OUTER JOIN DEPT USING(DEPTNO)
    ORDER BY ENAME;
    
SELECT E.DEPTNO, DNAME, EMPNO, ENAME, JOB, SAL
    FROM EMP E RIGHT OUTER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    ORDER BY ENAME;
    
/* 서브쿼리 : SQL문 안에 작성하는 작은 SELECT 문을 의미. 주로 WHERE 절에 사용 */
-- 서브쿼리는 반드시 괄호() 안에 넣어서 표현

-- 사원의 이름으로 사원이 속한 부서 번호를 찾음(서브쿼리)
-- 메인쿼리에서 부서 이름과 부서 번호를 비교해서 원하는 결과 찾기
SELECT DNAME 
    FROM DEPT
    WHERE DEPTNO = (SELECT DEPTNO 
                    FROM EMP
                    WHERE ENAME = 'KING');
                    
-- 연습 문제
-- 서브 쿼리를 이용해 'JONES'의 급여 보다 높은 급여를 받는 사원 정보 출력하기
SELECT *
    FROM EMP
    WHERE SAL > (SELECT SAL
                    FROM EMP
                    WHERE ENAME = 'JONES');
    

/* 서브 쿼리의 특징 
    * 조회 대상의 오른쪽에 놓이며 ()로 묶어서 사용
    * 대부분의 경우 ORDER BY 절을 사용할 수 없음
    * 메인쿼리의 대상과 서브쿼리의 대상은 같은 자료형이거나 같은 개수로 지정해야 함
    * 서브쿼리와 메인쿼리는 연산자와 함께 상호 작용하는 방식에 따라 단일행 서브쿼리와 다중행 서브쿼리*/
    
-- 연습문제 : 서브쿼리를 사용하여 EMP 테이블의 사원 정보 중에서 사원이름이 ALLEN인 사원의 추가수당 보다 많은 추가 수당을 받는 사원 정보를 출력하기
SELECT *
    FROM EMP
    WHERE COMM > (SELECT COMM
                    FROM EMP
                    WHERE ENAME = 'ALLEN');
                    
SELECT *
    FROM EMP
    WHERE HIREDATE < (SELECT HIREDATE
                        FROM EMP
                        WHERE ENAME = 'JAMES');
                        
-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원 정보와 소속 부서 정보를 조회
SELECT *
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE E.DEPTNO = 20
    AND SAL > (SELECT AVG(SAL)
                    FROM EMP);
                    
/* 실행 결과가 여러개인 다중행 서브 쿼리 */
-- IN 연산자 : 메인 쿼리의 데이터가 서브쿼리의 결과 중 하나라도 일치하는 데이터가 있다면 TRUE
SELECT *
    FROM EMP
    WHERE SAL IN(SELECT MAX(SAL)
                    FROM EMP
                    GROUP BY DEPTNO);

-- ANY 연산자 : 메인쿼리의 비교 조건이 서브쿼리의 여러 검색 결과 중 하나 이상 만족되면 TRUE
SELECT *
    FROM EMP
    WHERE SAL > ANY(SELECT MAX(SAL)
                    FROM EMP
                    GROUP BY DEPTNO);

SELECT *
    FROM EMP
    WHERE SAL > ANY(SELECT SAL
                    FROM EMP
                    WHERE JOB = 'SALESMAN');
                    
-- 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 정보
SELECT *
    FROM EMP
    WHERE SAL < ANY(SELECT SAL
                        FROM EMP
                        WHERE DEPTNO = 30)
    ORDER BY SAL, EMPNO;
    
-- ALL 연산자 : 메인쿼리의 비교조건이 서브쿼리의 여러 검색결과와 모두 일치하면 반환
SELECT *
    FROM EMP
    WHERE SAL < ALL (SELECT SAL
                        FROM EMP
                        WHERE DEPTNO = 30)
    ORDER BY SAL, EMPNO;
    
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL < ALL(SELECT SAL
                        FROM EMP
                        WHERE JOB = 'MANAGER');
                    
-- EXISTS 연산자 : 서브쿼리의 결과 값이 하나 이상 존재하면 TRUE, 아니면 FALSE
SELECT *
     FROM EMP
     WHERE EXISTS (SELECT DNAME
                        FROM DEPT
                        WHERE DEPTNO = 50);
                        
-- 다중열 서브쿼리 : 서브쿼리의 결과가 두개 이상의 컬럼으로 반환되어 메인 쿼리에 전달 되는 쿼리
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, SAL
                                FROM EMP
                                WHERE DEPTNO = 30);
                                
SELECT *
    FROM EMP
    WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                                FROM EMP
                                GROUP BY DEPTNO);
                                
/* FROM절에 사용하는 서브쿼리 
   * 메인쿼리의 FROM절을 서브 쿼리로 이용하는 방법으로 다른 말로는 인라인 뷰 라고 한다.
   * 테이블이 너무 커서 일부분만 사용하고자 하는 경우
   * 보안상 보여주고 싶은 열을 제한해야 하는 경우  */

SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME, D.LOC
    FROM (SELECT *
            FROM EMP
            WHERE DEPTNO = 10) E,
         (SELECT *
            FROM DEPT) D
        WHERE E.DEPTNO = D.DEPTNO;
        
-- 먼저 정렬하고 해당 개수만 가져오기
-- ROWNUM : 오라클에서 일련번호를 부여하기 위해 사용되는 예약어(행 번호를 매김)
SELECT ROWNUM, ENAME, SAL
    FROM(SELECT * FROM EMP ORDER BY SAL DESC)
    WHERE ROWNUM <= 3;
    
/* SELECT 절에 사용하는 서브쿼리 
    * SELECT 문에 사용하는 단일행 서브쿼리를 스칼라 서브쿼리 라고 함 */
SELECT EMPNO, ENAME, JOB, SAL,
    (SELECT GRADE FROM SALGRADE 
                    WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE,
    DEPTNO,
    (SELECT DNAME FROM DEPT
                    WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME
    FROM EMP E;
    
SELECT ENAME, DEPTNO, SAL, 
(SELECT TRUNC(AVG(SAL)) 
    FROM EMP
    WHERE DEPTNO = E.DEPTNO) AS "부서평균급여"
    FROM EMP E;

/* 부서 위치가 NEWYORK 인 경우에 본사, 아니면 분점으로 반환하기 */
SELECT EMPNO, ENAME,
    CASE WHEN DEPTNO = (SELECT DEPTNO
                            FROM DEPT
                            WHERE LOC = 'NEW YORK')
        THEN '본사'
        ELSE '분점'
    END AS 소속
    FROM EMP
    ORDER BY 소속 DESC;
    
-- 노션에 있는 연습문제 
-- 1. 전체 사원 중 ALLEN과 같은 직책(JOB)인 사원들의 사원 정보, 부서 정보를 다음과 같이 출력하는 SQL문을 작성하세요.

SELECT JOB, EMPNO, ENAME, SAL, D.DEPTNO, DNAME
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE JOB = (SELECT JOB
                        FROM EMP
                        WHERE ENAME = 'ALLEN');
                        
-- 2. 전체 사원의 평균 급여(SAL)보다 높은 급여를 받는 사원들의 사원 정보, 부서 정보, 급여 등급 정보를 출력하는 SQL문을 작성하세요
-- (단 출력할 때 급여가 많은 순으로 정렬하되 급여가 같을 경우에는 사원 번호를 기준으로 오름차순으로 정렬하세요).
SELECT EMPNO, ENAME, DNAME, HIREDATE, LOC, SAL,
                    (SELECT GRADE FROM SALGRADE 
                    WHERE E.SAL BETWEEN LOSAL AND HISAL) AS GRADE
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND SAL > (SELECT AVG(SAL)
                FROM EMP)
    ORDER BY SAL DESC, EMPNO;
----------------------------------------------------------------------------------------------  
SELECT EMPNO, ENAME, DNAME, HIREDATE, LOC, SAL, GRADE
    FROM EMP E, DEPT D, SALGRADE S
    WHERE E.DEPTNO = D.DEPTNO 
    AND E.SAL BETWEEN S.LOSAL AND S.HISAL
    AND SAL > (SELECT AVG(SAL)
                    FROM EMP)
    ORDER BY E.SAL DESC, E.EMPNO;
----------------------------------------------------------------------------------------------
SELECT EMPNO, ENAME, DNAME, HIREDATE, LOC, SAL, GRADE
    FROM EMP E
    JOIN DEPT D ON E.DEPTNO = D.DEPTNO
    JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
    AND SAL > (SELECT AVG(SAL)
                    FROM EMP)
    ORDER BY E.SAL DESC, E.EMPNO;

-- 3. 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의 
-- 사원 정보, 부서 정보를 다음과 같이 출력하는 SQL문을 작성하세요.
SELECT EMPNO, ENAME, JOB, E.DEPTNO, DNAME, LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO = 10
AND JOB NOT IN(SELECT JOB  -- 이렇게도 할 수 있음
                FROM EMP 
                WHERE DEPTNO = 30);

-- 4. 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원 정보, 급여 등급 정보를 다음과 같이 출력하는 SQL문을 작성하세요(단 서브쿼리를 활용할 때 
-- 다중행 함수를 사용하는 방법과 사용하지 않는 방법을 통해 사원 번호를 기준으로 오름차순으로 정렬하세요).
SELECT EMPNO, ENAME, SAL, (SELECT GRADE FROM SALGRADE WHERE E.SAL BETWEEN LOSAL AND HISAL) AS GRADE
FROM EMP E
WHERE SAL > ALL (SELECT SAL
                    FROM EMP
                    WHERE JOB = 'SALESMAN')
ORDER BY EMPNO;
----------------------------------------------------------------------------------------------
SELECT EMPNO, ENAME, SAL, GRADE
    FROM EMP E, SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
    AND SAL > (SELECT MAX(SAL)
                    FROM EMP
                    WHERE JOB = 'SALESMAN')
    ORDER BY E.EMPNO;

----------------------------------------------------------------------------------------------
SELECT EMPNO, ENAME, SAL, GRADE
    FROM EMP E JOIN SALGRADE S
    ON E.SAL BETWEEN S.LOSAL AND S.HISAL
    WHERE SAL > ALL(SELECT SAL FROM EMP WHERE JOB = 'SALESMAN')
    ORDER BY E.EMPNO;