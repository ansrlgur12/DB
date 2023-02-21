-- 연습용 테이블 생성 하기
-- 기존 테이블 복사해서 사용하는 방법
CREATE TABLE DEPT_TEMP
    AS SELECT * FROM DEPT;

SELECT * FROM DEPT_TEMP; ------------------------- 테이블 읽기

-- DROP TABLE DEPT_TEMP; -- 테이블 삭제
 DELETE FROM DEPT_TEMP -- 값 삭제
    WHERE DEPTNO = 91;

/* 테이블에 데이터를 추가하는 INSERT 문 
    * INSERT INTO '테이블이름' (열1, 열2, .....) VALUE(열에 해당하는 데이터, .....)*/
    
-- 첫번째 방법 : 테이블 목록과 추가할 값을 모두 표기하는 법
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC) VALUES (50, 'DATABASE', 'SEOUL');
INSERT INTO DEPT_TEMP(LOC, DEPTNO) VALUES ('BUSAN', 60);

-- 두번째 방법 :
INSERT INTO DEPT_TEMP VALUES(70, 'DEVELOPER', 'SUWON');
INSERT INTO DEPT_TEMP VALUES(80, 'GUEST', 'INCHUN');

/* 테이블에 NULL 데이터 입력하기 */
INSERT INTO DEPT_TEMP VALUES(90, 'WEB', NULL);
INSERT INTO DEPT_TEMP VALUES(91,'MOBILE', '');
INSERT INTO DEPT_TEMP(DEPTNO, LOC) VALUES (92, 'USLAN'); 


/* EMP TABLE 을 복사하면서 내용은 비움 */
CREATE TABLE EMP_TEMP
    AS SELECT *
        FROM EMP
        WHERE 1 != 1; -- 테이블을 복사하면서 데이터는 복사하고 싶지 않을 때
    
SELECT * FROM EMP_TEMP; -------- 테이블 읽기

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(9001, '나영석', 'PRESIDENT', NULL, '2020/01/01', 9900, 1000, 10);
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(9002, '이영지', 'MANAGER', 9999, '2020/05/01', 7000, 500, 20);
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(9003, '안유진', 'MANAGER', NULL, '2020/07/01', 7000, 800, 30);
        
/* 날짜 데이터는 '2020/01/01', '2023-05-01' 입력가능
   * TO_DATE('2021/02/01', 'YYYY/MM/DD')  */
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(9004, '미미', 'MANAGER', 9999, '2023-05-01', 4500, 100, 40);
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(9005, '채원', 'MANAGER', 9999, TO_DATE('2021/02/01', 'YYYY/MM/DD'), 5500, 300, 40);
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(9006, '카즈하', 'MANAGER', 9999, SYSDATE, 7700, 300, 40);
 
 ----------------------------------------------------------------------------------------------------------------   
        
/* 테이블에 있는 데이터 수정하기 
 
 UPDATE [변경할 테이블]
    SET [변경할 열] = [변경할 데이터], [변경할 열] = [변경할 데이터] ...
    WHERE 조건
    
*/
SELECT * FROM DEPT_TEMP;

UPDATE DEPT_TEMP
    SET LOC = 'SEOUL'; -- 데이터 전체수정
    
UPDATE DEPT_TEMP
    SET LOC = 'BUSAN' 
    WHERE DNAME = 'WEB';  -- 데이터 조건수정
    
UPDATE DEPT_TEMP
    SET DNAME = 'ANDROID', LOC = 'DAEGU'
    WHERE DEPTNO = 60;

UPDATE DEPT_TEMP
    SET (DNAME, LOC) = (SELECT DNAME, LOC
                            FROM DEPT
                            WHERE DEPTNO = 40)
    WHERE DEPTNO = 40;

/* 테이블에 있는 데이터 삭제하기 (DELETE) */
CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP;
SELECT * FROM EMP_TEMP2; -- 테이블 보기

DELETE FROM EMP_TEMP2; -- 데이터 삭제
DROP TABLE EMP_TEMP2; -- 테이블 삭제

DELETE FROM EMP_TEMP2
    WHERE JOB = 'MANAGER';
    
DELETE FROM EMP_TEMP2
    WHERE COMM IS NULL;
    
/* 서브쿼리를 사용하여 데이터 삭제하기 */
DELETE FROM EMP_TEMP2
    WHERE EMPNO IN (SELECT E.EMPNO
                        FROM EMP_TEMP2 E, SALGRADE S
                        WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                        AND S.GRADE = 3
                        AND DEPTNO = 30);
                        
---------------------------------시   험-----------------------------------------------------------------------------------------                        
                        
/* ROWNUM : 행에 대한 일련번호를 지정하는 키워드 */
SELECT ROWNUM, ENAME, SAL
    FROM (SELECT *
            FROM EMP
            ORDER BY SAL DESC)
    WHERE ROWNUM <= 3;
/*  집계함수와 연관된 GROUP BY ~ HAVING */

/* LIKE 절에서 ESCAPE 문자 사용 관련된 부분 복습 필요 */

/* NULL 비교 관련 부분 */

--------------------------------------------------------------------------------------------------------------------------
DROP TABLE EX_EMP;
DROP TABLE EX_DEPT;
-- 연습문제
CREATE TABLE EX_EMP AS SELECT * FROM EMP;
CREATE TABLE EX_DEPT AS SELECT * FROM DEPT;
CREATE TABLE EX_SALGRADE AS SELECT * FROM SALGRADE;

SELECT * FROM EX_EMP ORDER BY DEPTNO;
SELECT * FROM EX_DEPT;
-- 1. EX_DEPT 테이블에 50, 60, 70, 80를 등록하는 SQL문을 작성 하세요.
INSERT INTO EX_DEPT VALUES (50, 'ORACLE', 'BUSAN');
INSERT INTO EX_DEPT VALUES (60, 'SQL', 'ILSAN');
INSERT INTO EX_DEPT VALUES (70, 'SELECT', 'INCHEON');
INSERT INTO EX_DEPT VALUES (80, 'DML', 'BUNDANG');

-- 2.EX_EMP 테이블에 다음 8명의 사원 정보를 등록하는 SQL문을 작성 하세요.
INSERT INTO EX_EMP VALUES (7201, 'TEST_USER1', 'MANAGER', 7788, '2016/01/02',4500,NULL,50);
INSERT INTO EX_EMP VALUES (7202, 'TEST_USER2', 'CLERK', 7201, '2016/02/21',1800,NULL,50);
INSERT INTO EX_EMP VALUES (7203, 'TEST_USER3', 'ANALYST', 7201, '2016/04/11',3400,NULL,60);
INSERT INTO EX_EMP VALUES (7204, 'TEST_USER4', 'SALESMAN', 7201, '2016/05/31',2700,300,60);
INSERT INTO EX_EMP VALUES (7205, 'TEST_USER5', 'CLERK', 7201, '2016/07/20',2600,NULL,70);
INSERT INTO EX_EMP VALUES (7206, 'TEST_USER6', 'CLERK', 7201, '2016/09/08',2600,NULL,70);
INSERT INTO EX_EMP VALUES (7207, 'TEST_USER7', 'LECTURER', 7201, '2016/10/28',2300,NULL,80);
INSERT INTO EX_EMP VALUES (7208, 'TEST_USER8', 'STUDENT', 7201, '2016/03/09',1200,NULL,80);

-- 3. EX_EMP에 속한 사원 중 50번 부서에서 근무하는 사원들의 평균 급여보다 많은 급여를
--      받고 있는 사원들을 70번 부서로 옮기는 SQL문을 작성 하세요.

UPDATE EX_EMP
    SET DEPTNO = 70
    WHERE SAL > (SELECT AVG(SAL)
                    FROM EX_EMP
                    WHERE DEPTNO = 50);
                    
-- 4.  EX_EMP에 속한 사원 중, 60번 부서의 사원 중에 입사일이 가장 빠른 사원보다 늦게 
--     입사한 사원의 급여를10% 인상하고 80번 부서로 옮기는 SQL문을 작성하세요.  
UPDATE EX_EMP
    SET SAL = SAL * 1.1 , DEPTNO = 80
    WHERE HIREDATE > ANY (SELECT HIREDATE
                        FROM EX_EMP
                        WHERE DEPTNO = 60);
    
                            
-- 5. EX_EMP에 속한 사원 중, 급여 등급이 5인 사원을 삭제하는 SQL문을 작성하세요.
DELETE FROM EX_EMP
     WHERE EMPNO IN (SELECT E.EMPNO
                        FROM EX_EMP E, EX_SALGRADE S
                        WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                        AND S.GRADE = 5);
                        
SELECT * FROM EX_EMP;