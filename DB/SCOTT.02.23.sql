CREATE TABLE DEPT_TCL 
    AS SELECT * FROM DEPT;
    
SELECT * FROM DEPT_TCL;
    
INSERT INTO DEPT_TCL VALUES(50, 'DATABASE', 'SEOUL');

UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO = 40;
    
DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';

COMMIT;

---------------------------------------
/* DDL ���� Ŀ�ǵ� (������ ���Ǿ�)
    * CREATE : ���̺� ����
    * ALTER : ���̺� ���� (ADD, RENAME, MODIFY, DROP) -> �÷��� ������ �ִ� ��ɾ��
    * RENAME : ���̺� �̸� ����
    * TRUNCATE : ���̺��� �����͸� ����
    * DROP : ���̺� ����
*/

-- ���̺��� �ڷ����� �����Ͽ� ���� �����ϴ� ���
DESC EMP;
DROP TABLE EMP_DDL;
CREATE TABLE EMP_DDL (
    EMPNO    NUMBER(4),
    ENAME    VARCHAR2(10),
    JOB      VARCHAR2(9),
    MGR      NUMBER(4),
    HIREDATE DATE,
    SAL      NUMBER(7, 2),
    COMM     NUMBER(7, 2),
    DEPTNO   NUMBER(2)
);

SELECT * FROM EMP_DDL;

-- ���� ���̺��� �� ������ �����͸� �����Ͽ� �� ���̺� �����ϱ�
CREATE TABLE DEPT_DDL
    AS SELECT * FROM DEPT;

SELECT * FROM DEPT_DDL;

-- ���� ���̺��� �� ������ �����Ͽ� �� ���̺� �����
CREATE TABLE DEPT_TMP
    AS SELECT * FROM DEPT
    WHERE 1 != 1;
    
SELECT * FROM DEPT_TMP;
SELECT * FROM EMPDEPT_DDL;

CREATE TABLE EMPDEPT_DDL
    AS SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE,
    E.SAL, E.COMM, D.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
    WHERE 1 != 1;
    
 -------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------------   
-- ���̺��� �����ϴ� ALTER : ���̺� �� ���� �߰� �Ǵ� ����, ���� �ڷ��� ���� ���� ���� ����
CREATE TABLE EMP_ALTER  AS SELECT * FROM EMP;
SELECT * FROM EMP_ALTER;

-- ���̺� ���ο� ���� �߰� : ADD, �߰��� ���� ���� �࿡�� NULL ������ �Էµ�
ALTER TABLE EMP_ALTER
    ADD HP VARCHAR2(20);
    
-- �� �̸� ���� : RENAME
ALTER TABLE EMP_ALTER
    RENAME COLUMN HP TO TEL;
    
-- ���� �ڷ����� ���� : MODIFY, �ڷ��� ���� �� �̹� �ش� �÷��� ���� ���� �����Ѵٸ� ������ �ȵɼ�������
-- ������ �ڷ����� ũ�⺸�� ũ�� �����ϴ� �� ���� �ȵ�, �۰� ����ÿ��� ���Ե� �����Ϳ� ������ ����
ALTER TABLE EMP_ALTER
    MODIFY EMPNO NUMBER(5);
    
-- Ư�� ���� ������ �� : DROP
ALTER TABLE EMP_ALTER
    DROP COLUMN TEL;
    
   ----------------------------------------------------------------------------------------- -----------------------------------------------------------------------------------------  
/* ���̺� �̸��� �����ϴ� RENAME */

RENAME EMP_ALTER TO EMP_RENAME;
SELECT * FROM EMP_RENAME;

/* ���̺��� �����͸� �����ϴ� TRUNCATE */
-- ���̺��� ��� �����͸� �����ϴ� ���, ���̺� ������ ������ ���� ������, ROLLBACK �Ұ�
TRUNCATE TABLE EMP_RENAME;

/* ���̺��� �����ϴ� DROP */
DROP TABLE EMP_RENAME;

-----------------------------------------------------------------------------------
-- �������� 

-- 1. ���� ���� ������ ������ EMP_HW ���̺��� ����� ������.
CREATE TABLE EMP_HW (
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2)
);

SELECT * FROM EMP_HW;

-- 2.
ALTER TABLE EMP_HW 
    ADD BIGO VARCHAR2(20);

-- 3.
ALTER TABLE EMP_HW
    MODIFY BIGO VARCHAR2(30);

-- 4.    
ALTER TABLE EMP_HW
    RENAME COLUMN BIGO TO REMARK;

-- 5.
INSERT INTO EMP_HW
    SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, NULL
    FROM EMP;

-- 6.
DROP TABLE EMP_HW;

--------------------------------------------------------------------------------------------

/* ���� ���� : ���̺� ������ �����͸� �����ϴ�  Ư���� ��Ģ�� �ǹ� �մϴ�. ���ǿ� ���� �ʴ� ������ ���� �Ұ� */

-- �� ���� ������� �ʴ� NOT NULL : ���� ���� �����Ϳ� �ߺ����δ� ������� NULL ���� ������� ���� (�ݵ�� ���� �ԷµǾ�� ��)

CREATE TABLE TABLE_NOTNULL (
    LOGIN_ID  VARCHAR2(20) NOT NULL,
    LOGIN_PW  VARCHAR2(20) NOT NULL,
    TEL       VARCHAR2(20) 
    );

INSERT INTO TABLE_NOTNULL(LOGIN_ID, LOGIN_PW, TEL) VALUES('�����̻�����',  'SPHB8250', '010-5506-4164');
INSERT INTO TABLE_NOTNULL(LOGIN_ID, LOGIN_PW, TEL) VALUES('����������', '12345678', NULL);
SELECT * FROM TABLE_NOTNULL;

/* �ߺ����� �ʴ� �� : UNIQUE */
-- ���� ������ �������� �ߺ��� ������� ����, 

CREATE TABLE TABLE_UNIQUE (
     LOGIN_ID  VARCHAR2(20) UNIQUE,
     LOGIN_PW  VARCHAR2(20) NOT NULL,
     TEL VARCHAR2(20)
);
INSERT INTO TABLE_UNIQUE(LOGIN_ID, LOGIN_PW, TEL) VALUES('�����̻�����',  'SPHB8250', '010-5506-4164');
INSERT INTO TABLE_UNIQUE(LOGIN_ID, LOGIN_PW, TEL) VALUES('NULL', '12345678', NULL);

SELECT * FROM TABLE_UNIQUE;

DROP TABLE TABLE_PK;
DROP TABLE EMP_FK;
CREATE TABLE TABLE_PK(
    LOGIN_ID VARCHAR2(20) PRIMARY KEY,
    LOGIN_PW VARCHAR(20) NOT NULL,
    TEL      VARCHAR(20)
);
INSERT INTO TABLE_PK(LOGIN_ID, LOGIN_PW, TEL) VALUES('�����̻�����',  'SPHB8250', '010-5506-4164');
INSERT INTO TABLE_PK(LOGIN_ID, LOGIN_PW, TEL) VALUES('NULL', '12345678', NULL);
SELECT * FROM TABLE_PK;

/* FOREIGN(�ܷ�) KEY �����ϱ�
  * FOREIGN KEY�� ���� �ٸ� ���̺� ���踦 �����ϴµ� ����ϴ� ���� ���� */
CREATE TABLE DEPT_FK(
    DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
    DNAME VARCHAR(14),
    LOC VARCHAR(13)
);
CREATE TABLE EMP_FK(    
    EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7, 2),
    COMM NUMBER(7, 2),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK (DEPTNO)
);

INSERT INTO DEPT_FK VALUES(10, '���̺�', 'SEOUL');
INSERT INTO EMP_FK VALUES(9999, '������', '���̵�', NULL, SYSDATE, 3000, NULL, 10);

/* ������ ���¿� ������ ���ϴ� CHECK */
CREATE TABLE TABLE_CHECK (
    LOGIN_ID VARCHAR2(20) CONSTRAINT TBLCK_LOGINID_PK PRIMARY KEY,
    LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLCK_LOGINPW_CK CHECK (LENGTH(LOGIN_PWD) > 3),
    TEL VARCHAR2(20)
);

INSERT INTO TABLE_CHECK VALUES('����������', '1234', '010-1234-5678');
SELECT * FROM TABLE_CHECK;

/* �⺻���� �����ϴ� DEFAULT */
CREATE TABLE TABLE_DEFAULT (
    LOGIN_ID VARCHAR2(20) CONSTRAINT TBCLK2_LOGINID_PK PRIMARY KEY,
    LOGIN_PWD VARCHAR2(20) DEFAULT '1234',
    TEL VARCHAR2(20)
);
INSERT INTO TABLE_DEFAULT VALUES('������', NULL, '010-5006-4146');
INSERT INTO TABLE_DEFAULT (LOGIN_ID, TEL) VALUES('������2', '010-1234-5678');
SELECT * FROM TABLE_DEFAULT;

-----------------------------------------��������-------------------------------------------------------
SELECT * FROM PRODUCT;
-- 1-1. 
CREATE TABLE PRODUCT (
    PRODUCT_ID NUMBER PRIMARY KEY,
    PRODUCT_NAME VARCHAR2(20) NOT NULL,
    REG_DATE DATE
);

-- 1-2.
INSERT INTO PRODUCT VALUES (1, 'COMPUTER', '21/01/02');
INSERT INTO PRODUCT VALUES (2, 'SMARTPHONE', '22/02/03');
INSERT INTO PRODUCT VALUES (3, 'TELEVISION', '22/07/01');

-- 1-3.
ALTER TABLE PRODUCT
    ADD WEIGHT NUMBER CONSTRAINT PRD_WEI_CK CHECK (WEIGHT >= 0)
    ADD PRICE NUMBER CONSTRAINT PRD_PRI_CK CHECK (PRICE >= 0);

DROP TABLE CUSTOMER_TABLE;
-- 2-1. 
CREATE TABLE CUSTOMER_TABLE (
    CUSTOM_ID NUMBER PRIMARY KEY,
    USER_NAME VARCHAR(12) NOT NULL,
    PHONE VARCHAR(20),
    EMAIL VARCHAR(20),
    REG_DATE DATE DEFAULT '1900/01/01'
);

-- 2-2.
ALTER TABLE CUSTOMER_TABLE
    ADD AGE NUMBER CONSTRAINT CTT_AGE_CK CHECK (AGE < 200 OR AGE > 0)
    ADD SEX VARCHAR2(1) CONSTRAINT CTT_SEX_CK CHECK (SEX IN ('M' , 'F'))
    ADD BIRTH_DATE DATE;
    
-- 2-3
ALTER TABLE CUSTOMER_TABLE
    MODIFY PHONE VARCHAR(20) UNIQUE
    MODIFY EMAIL VARCHAR(20) UNIQUE;
    
-- 2-4
ALTER TABLE CUSTOMER_TABLE
    RENAME COLUMN SEX TO GENDER;
ALTER TABLE CUSTOMER_TABLE 
    RENAME COLUMN PHONE TO MOBILE;
ALTER TABLE CUSTOMER_TABLE 
    MODIFY USER_NAME VARCHAR(20);
    
-- 2-5
INSERT INTO CUSTOMER_TABLE VALUES(1001, '�ϴ�', '010-3456-5678', 'HN@GMAIL.COM', '2022/07/22', 18, 'F', '2004/10/06');
INSERT INTO CUSTOMER_TABLE VALUES(1002, '�ٴϿ�', '010-3457-5678', 'DAN@GMAIL.COM', '2022/07/22', 17, 'F', '2005/04/11');
INSERT INTO CUSTOMER_TABLE VALUES(1003, '�ظ�', '010-3459-5678', 'HL@GMAIL.COM', '2022/07/22', 16, 'F', '2006/05/15');
INSERT INTO CUSTOMER_TABLE VALUES(1004, '����', '010-5678-5678', 'HI@GMAIL.COM', '2022/07/22', 14, 'F', '2008/04/21');
INSERT INTO CUSTOMER_TABLE VALUES(1005, '����', '010-5678-6789', 'YJ@GMAIL.COM', '2019/02/12', 23, 'F', '2000/05/26');
INSERT INTO CUSTOMER_TABLE VALUES(1006, '����', '010-5578-6789', 'LA@GMAIL.COM', '2019/02/12', 23, 'F', '2000/07/21');
INSERT INTO CUSTOMER_TABLE VALUES(1007, '����', '010-5578-9999', 'LJ@GMAIL.COM', '2019/02/12', 22, 'F', '2001/04/17');
INSERT INTO CUSTOMER_TABLE VALUES(1008, 'ä��', '010-5578-8888', 'CR@GMAIL.COM', '2019/02/12', 22, 'F', '2001/06/05');
INSERT INTO CUSTOMER_TABLE VALUES(1009, '����', '010-4444-8888', 'YN@GMAIL.COM', '2019/02/12', 20, 'F', '2003/12/09');

SELECT * FROM CUSTOMER_TABLE;