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
    
/* 합계 구하는 SUM 함수 */
-- DISTINCT : 중복 제거
-- ALL : 사용하지 않아도 기본적으로 ALL 특성을 가짐
SELECT * FROM EMP;

SELECT SUM(DISTINCT SAL) AS 중복제거, SUM(ALL SAL) AS 전부, SUM(SAL) AS 기본
    FROM EMP;
    
SELECT SUM(SAL), SUM(COMM) FROM EMP;

SELECT COUNT(*) FROM EMP;
SELECT COUNT(COMM) FROM EMP; -- COMM 값이 NULL이 아닌사람

SELECT COUNT(COMM)
    FROM EMP
    WHERE COMM IS NOT NULL;
    
-- 부서 번호가 20인 사원 중 입사일이 가장 최근인 사람
SELECT MAX(HIREDATE)
    FROM EMP
    WHERE DEPTNO = 20;
    
/* GROUP BY : 하나의 결과를 특정 열을 묶어서 출력하는 것을 그룹화한다고 한다. */ 
-- 이떄 출력해야 할 대상열을 GROUP BY로 지정한다

SELECT TRUNC(AVG(SAL)), DEPTNO
FROM EMP
GROUP BY DEPTNO;

SELECT TRUNC(AVG(SAL))FROM EMP WHERE DEPTNO = 10;
SELECT TRUNC(AVG(SAL)) FROM EMP WHERE DEPTNO = 20;
SELECT TRUNC(AVG(SAL)) FROM EMP WHERE DEPTNO = 30;

 /*부서 번호 및 직책별 평균 급여로 정렬하기*/
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    ORDER BY DEPTNO, JOB;

/* GROUP BY절을 사용하여 부서 번호별 평균 추가수당을 출력 */
SELECT AVG(COMM), DEPTNO
    FROM EMP
    GROUP BY DEPTNO;
    
/* 부서 코드, 급여 합계, 부서 평균, 부서 코드 순 정렬 */
SELECT DEPTNO 부서코드, SUM(SAL) 합계, FLOOR(AVG(SAL)) 평균, COUNT(*) 인원수
    FROM EMP
     GROUP BY DEPTNO;
     
     
/* HAVING * GRUOP BY 절이 존재할 떄만 사용할 수 있음.*/
-- 그룹화된 값의 범위를 제한하는 용도로 사용
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
        
/* WHERE 절과 HAVING 절을 모두 사용하는 경우 */
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    WHERE SAL <= 2500
    GROUP BY DEPTNO, JOB
        HAVING AVG(SAL) >= 2000
    ORDER BY DEPTNO, JOB;
    
-- 1.HAVING절을 사용하여 EMP 테이블의 부서별 직책의 평균 급여가 500 이상인 사원들의 
--   부서 번호, 직책, 부서별 직책의 평균 급여가 출력
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
        HAVING AVG(SAL) >= 500;

-- 2. EMP 테이블을 이용하여 부서번호, 평균급여, 최고급여, 최저급여, 사원수를 출력,  
--   단, 평균 급여를 출력 할 때는 소수점 제외하고 부서 번호별로 출력
SELECT DEPTNO, TRUNC(AVG(SAL)) 평균급여,
    MAX(SAL) 최고급여,
    MIN(SAL) 최저급여,
    COUNT(*) 사원수
    FROM EMP
    GROUP BY DEPTNO;
    
-- 3. 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원를 출력
SELECT JOB 직업, COUNT(JOB) 사원수
    FROM EMP
    GROUP BY JOB
        HAVING COUNT(JOB) >= 3;
        
-- 4. 사원들의 입사 연도를 기준으로 부서별로 몇 명이 입사했는지 출력
SELECT EXTRACT(YEAR FROM HIREDATE)입사일, DEPTNO, COUNT(*)사원수
    FROM EMP
    GROUP BY EXTRACT(YEAR FROM HIREDATE), DEPTNO
    ORDER BY COUNT(*);
    
-- 5. 추가 수당을 받는 사원 수와 받지 않는 사원수를 출력 (O, X로 표기 필요)
SELECT NVL2(COMM, 'O', 'X') 추가수당, COUNT(*) 사원수
    FROM EMP
    GROUP BY NVL2(COMM, 'O', 'X');
    
-- 6. 각 부서의 입사 연도별 사원 수, 최고 급여, 급여 합, 평균 급여를 출력
SELECT DEPTNO, EXTRACT(YEAR FROM HIREDATE) 입사년도, COUNT(*) 사원수, MAX(SAL)최고급여, TRUNC(AVG(SAL)) 평균급여, SUM(SAL) 합계
    FROM EMP
    GROUP BY DEPTNO, EXTRACT(YEAR FROM HIREDATE)
    ORDER BY DEPTNO, EXTRACT(YEAR FROM HIREDATE);
    
