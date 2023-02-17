/* 집합 연산자 : 두 개 이상의 쿼리 결과를 하나로 결합하는 연산자 */
-- UNION : 합집합, 중복 제거
-- UNION ALL : 합집합, 중복 제거 X
-- MINUS : 차집합
-- INTERSECT : 교집합

-- UNION : 합집합, 중복 제거
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE DEPTNO = 20
    ORDER BY DEPTNO;
    
-- UNION ALL : 합집합, 중복제거 X
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP   
    WHERE DEPTNO = 10
UNION ALL
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE DEPTNO = 10;
    
-- INTERSECT : 교집합 . 두개의 퀴리문에 모두 포함되어 있는 데이터를 표시
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL > 1000
INTERSECT
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL < 2000;
    
-- MINUS(차집합) : 앞의 쿼리문 결과에서 뒤의 쿼리문 결과를 뺀 것
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL > 1000
MINUS
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL > 2000;

SELECT * FROM DEPT;

/* JOIN */ 
-- JOIN 은 두개 이상의 테이블에서 데이터를 가져와서 연결하는 데 사용되는 SQL의 기능
-- 테이블의 식별 값인 Primary KEY와 테이블 간 공통 값인 Foreign KEY 값을 사용하여 조인
-- INNER JOIN : 두 테이블에서 일치하는 데이터만 선택
-- LEFT JOIN : 왼쪽 테이블의 모든 데이터와 오른쪽 데이터에서 일치하는 데이터를 선택
-- RIGHT JOIN : 오른쪽 테이블의 모든 데이터와 왼쪽 테이블에서 일치하는 데이터 선택

-- 두개의 테이블의 모든 열이 결합되어 데이터 * 데이터 만큼의 결과가 표시된다. (카테시안 곱)
SELECT *
    FROM EMP, DEPT
    ORDER BY EMPNO;

SELECT *
    FROM EMP e, DEPT d
    WHERE e.DEPTNO = d.DEPTNO;
    
/* 테이블 별칭 주기 : 양쪽 테이블 모두에 존재하는 열에 대해서는 테이블 이름을 명시해야 함 */ 
SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC 
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND E.JOB = 'MANAGER';
    
/* 등가 조인 */
-- 테이블을 연결한 후에 출력 행을 각 테이블의 특정 열에 일치한 데이터를 기준으로 선정하는 방식
-- 오라클 9i 까지는 오라클 조인만 사용 할 수 있었으나,  오라클 10g 부터는 Ansi 조인을 추가로 사용가능

-- ANSI 조인 방식으로 연결하기
SELECT EMPNO, ENAME, E.DEPTNO, DNAME
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE E.JOB = 'MANAGER';
    
-- EMP와 DEPT 테이블을 조인하고, 급여가 3000이상인 사원 정보 출력
-- 사원번호, 이름, 급여 입사일 부서번호, 부서이름
SELECT EMPNO, ENAME, SAL, HIREDATE, E.DEPTNO, DNAME
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND SAL >= 3000;
    
SELECT EMPNO, ENAME, SAL, HIREDATE, E.DEPTNO, DNAME
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE SAL >= 3000;
    
/* EMP 체이블 별칭을 E로, DEPT 테이블 별칭은 D로 하여 다음과 같이 등가 조인을 했을때,
   급여가 2500 이하이고 사원번호가 9999이하인 사원의 정보가 출력되도록 작성 */
   
SELECT EMPNO, ENAME, SAL, HIREDATE, E.DEPTNO, DNAME
    FROM EMP E, DEPT d
    WHERE E.DEPTNO = D.DEPTNO
    AND SAL <= 2500 AND EMPNO < 9999;
    
SELECT EMPNO, ENAME, SAL, HIREDATE, E.DEPTNO, DNAME
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE SAL <= 2500 AND EMPNO < 9999;
    
/* 비등가 조인 : 동일 열이 아닌 다른 조건을 사용하여 조인 할 때 사용. (자주 사용되지 않음, 자바의 서비스로직에서 하면 됨) */
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

-- 급여에 대한 등급을 표시하기 위해서는 급여의 금액이 일치할 수 없으므로 최소와 최대급여 사이로 나타내야함
-- 아래 경우 BETWEEN A AND B 연산자를 사용해서 처리 가능
SELECT ENAME, SAL, GRADE
    FROM EMP E JOIN SALGRADE S
    ON SAL BETWEEN LOSAL AND HISAL;
    
/* 자체 조인 : 같은 테이블을 두번 사용하는 것 */
SELECT E1.EMPNO, E1.ENAME, /*E1.MGR,*/
        E2.EMPNO AS MGR_EMPNO,
        E2.ENAME AS MGR_ENAME
        FROM EMP E1 JOIN EMP E2
        ON E1.MGR = E2.EMPNO;

/*내부조인(INNER JOIN) 또는 동등조인의 경우 한쪽의 컬럼(열)에 값이 없다면 조회되지 않음*/
/* 외부 조인(OUTER JOIN) : 내부 조인과 다르게 공통되지 않은 열도 표시한다.  */

-- ANSI 문법
SELECT ENAME, E.DEPTNO, DNAME
    FROM EMP E RIGHT OUTER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    ORDER BY E.DEPTNO;
    
-- ORACLE 문법
SELECT ENAME, E.DEPTNO, DNAME
    FROM EMP E , DEPT D
    WHERE E.DEPTNO(+) = D.DEPTNO
    ORDER BY E.DEPTNO;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

-- 1. 사원번호가 7499인 사원의 이름, 입사일 부서번호 출력
SELECT ENAME, HIREDATE, DEPTNO
    FROM EMP
    WHERE EMPNO = 7499;
    
-- 2. 이름이 ALLEN인 사원의 모든 정보 출력
SELECT *
    FROM EMP
    WHERE ENAME = 'ALLEN';
    
-- 3. 이름이 K보다 큰 글자로 시작하는 사원의 모든 정보 출력
SELECT *
    FROM EMP
    WHERE ENAME > 'K';
    --WHERE SUBSTR(ENAME,1,1) > 'K';
    
-- 4.입사일이 81년 4월2일 보다 늦고, 82년 12월9일 보다 빠른 사원의 이름, 급여, 부서번호 출력
SELECT ENAME, SAL, DEPTNO, HIREDATE
    FROM EMP
    WHERE HIREDATE BETWEEN '81/04/03' AND '82/12/08';
    
-- 5.급여가 1,600 보다 크고, 3000보다 작은 사원의 이름, 직무, 급여를 출력
SELECT ENAME, JOB, SAL
    FROM EMP
    WHERE SAL BETWEEN 1601 AND 2999;
    
-- 6. 입사일이 81년 이외에 입사한 사원의 모든 정보 출력
SELECT *
    FROM EMP
    WHERE HIREDATE NOT BETWEEN '81/01/01' AND '81/12/31';
    
SELECT *
    FROM EMP
    WHERE EXTRACT(YEAR FROM HIREDATE) != 1981;
    
-- 7.직업이 MANAGER와 SALESMAN인 사원의 모든 정보를 출력
SELECT *
    FROM EMP
    WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN';
    
-- 8. 부서가 20번, 30번을 제외한 모든 사원의 이름, 사원번호, 부서번호를 출력
SELECT ENAME, EMPNO, DEPTNO
    FROM EMP
    WHERE NOT DEPTNO IN(20,30);

-- 9. 이름이 S로 시작하는 사원의 사원번호, 이름, 부서번호 출력
SELECT EMPNO, ENAME, DEPTNO
    FROM EMP
    WHERE SUBSTR(ENAME, 1, 1) = 'S';
    
SELECT EMPNO, ENAME, DEPTNO
    FROM EMP
    WHERE ENAME LIKE 'S%';
    
-- 10. 처음 글자는 관계없고, 두 번째 글자가 A인 사원의 모든 정보를 출력
SELECT *
    FROM EMP
    WHERE ENAME LIKE '_A%';
    
-- 11. 커미션이 NULL이 아닌 사원의 모든 정보를 출력
SELECT *
    FROM EMP
    WHERE COMM IS NOT NULL;
    
-- 12. 이름이 J자로 시작하고 마지막 글자가 S인 사원의 모든 정보를 출력
SELECT *
    FROM EMP
    WHERE ENAME LIKE 'J%S';

-- 13. 급여가 1500이상이고, 부서번호가 30번인 사원 중 직무가 MANAGER인 사원의 모든 정보 출력
SELECT *
    FROM EMP
    WHERE SAL >= 1500
    AND DEPTNO = 30
    AND JOB = 'MANAGER';

-- 14. 모든 사원의 이름, 급여, 커미션, 총액(급여+커미션)을 구하여 총액이 많은 순서로 출력 
--     (단, 커미션이 null인 사원도 0으로 포함)
SELECT ENAME, SAL, NVL(COMM, 0), SAL + NVL(COMM, 0) 총액
    FROM EMP
    ORDER BY SAL + NVL(COMM, 0) DESC;
    
-- 15. 10번 부서의 모든 사원에게 급여의 13%를 보너스로 지불하기로 하였다. 
--     10번 부서 사원들의 이름, 급여, 보너스, 부서번호 출력
SELECT ENAME, SAL, SAL*1.13, DEPTNO
    FROM EMP
    WHERE DEPTNO = 10;
    
-- 16. 모든 사원에 대해 입사한 날로 부터 60일이 지난 후의 ‘월요일’에 대한 년,월,일를 구하여 
--     이름, 입사일, 60일 후의 ‘월요일’ 날짜를 출력
SELECT ENAME, HIREDATE,
    TO_CHAR(NEXT_DAY(HIREDATE+60,'월요일'), 'YYYY/MM/DD')
    FROM EMP;
    
-- 17.이름의 글자수가 6자 이상인 사원의 이름을 앞에서 3자만 구하여 소문자로 이름만 출력
SELECT LOWER(SUBSTR(ENAME,1,3))
    FROM EMP
    WHERE LENGTH(ENAME) >= 6;
    
-- 18. 사원들의 사원 번호와 급여, 커미션, 연봉((comm+sal)*12)을 연봉이 많은 순서로 출력
SELECT EMPNO, SAL, NVL(COMM,0), (NVL(COMM,0)+SAL) * 12 연봉
    FROM EMP
    ORDER BY 연봉 DESC;
    
-- 19. 모든 사원들의 입사한 년/월/일 
SELECT TO_CHAR(HIREDATE, 'YYYY"년"MM"월"DD"일"') FROM EMP;

-- 20. 10번 부서에 대해 급여의 평균 값, 최대 값, 최소 값, 인원 수를 출력
SELECT AVG(SAL), MAX(SAL), MIN(SAL), COUNT(*)
    FROM EMP
    WHERE DEPTNO = 10;
    
-- 21. 사원번호가 짝수인 사원들의 모든 정보를 출력
SELECT *
    FROM EMP
    WHERE MOD(EMPNO,2) = 0;
    
-- 22. 각 부서별 같은 직무를 갖는 사원의 인원수를 구하여 부서 번호, 직무, 인원수 출력
SELECT DEPTNO, JOB, COUNT(*)
    FROM EMP
    GROUP BY DEPTNO, JOB
    ORDER BY DEPTNO, JOB;
    
-- 23. EMP와 DEPT테이블을 조인하여 모든 사원에 대해 부서 번호, 부서이름, 사원이름 급여를 출력
SELECT E.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO;
    
-- 24. 이름이 ‘ALLEN’인 사원의 부서 번호, 부서 이름, 사원 이름, 급여 출력
SELECT E.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE ENAME = 'ALLEN';
    
-- 25. ‘ALLEN’과 직무가 같은 사원의 이름, 부서 이름, 급여, 부서위치를 출력
SELECT E.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE JOB = (SELECT JOB 
                    FROM EMP
                    WHERE ENAME = 'ALLEN');
    
    
-- 26. 모든 사원들의 평균 급여 보다 많이 받는 사원들의 사원번호와 이름 출력
SELECT EMPNO, ENAME
    FROM EMP
    WHERE SAL > (SELECT AVG(SAL) --- ???
                    FROM EMP);

-- 27. 부서별 평균 급여가 2000보다 적은 부서 사원들의 부서 번호 출력
SELECT DEPTNO
    FROM EMP
    GROUP BY DEPTNO
        HAVING AVG(SAL) < 2000; 
        
-- 28. 30번 부서의 최고급여보다 급여가 많은 사원의 사원 번호, 이름, 급여를 출력
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL > (SELECT MAX(SAL)
                    FROM EMP
                    WHERE DEPTNO = 30);

SELECT MAX(SAL)
    FROM EMP;