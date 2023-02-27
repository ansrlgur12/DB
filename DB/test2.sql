CREATE TABLE CUSTOM_INFO(
    ������ȣ    NUMBER      PRIMARY KEY,
    �����̸�    VARCHAR2(20) NOT NULL,
    ��ȭ��ȣ    VARCHAR2(20)
);


CREATE TABLE ORDER_TABLE(
    ORDER_NUM NUMBER PRIMARY KEY,
    CUS_NUM NUMBER REFERENCES CUSTOM_INFO (������ȣ),
    MENU_NUM NUMBER REFERENCES PRODUCT_TABLE (��ǰ��ȣ),
    ORDER_DATE DATE
    );
    

CREATE TABLE MENU_TABLE(
    MENU_NUM NUMBER PRIMARY KEY,
    NAME VARCHAR2(20) NOT NULL,
    MENU VARCHAR2(30) REFERENCES ��ǰ (�з�),
    PRICE NUMBER NOT NULL
    );


INSERT INTO MENU_TABLE VALUES (1, 'Ŭ��','������', 5000);
INSERT INTO ORDER_TABLE VALUES (1, 1000, 1, SYSDATE);

CREATE TABLE INGREDIENT (
    MENU    VARCHAR2(30) PRIMARY KEY,
    MENU_SIZE    VARCHAR2(1) CHECK(MENU_SIZE IN('S', 'M', 'L')) NOT NULL,
    BREAD   VARCHAR2(20) DEFAULT 'X' NOT NULL,
    CHEESE  VARCHAR2(20) DEFAULT 'ġ��þ���' NOT NULL,
    VEGI    VARCHAR2(20) DEFAULT 'ä�Ҽ��þ���' NOT NULL,
    SAUCE   VARCHAR2(20) DEFAULT '�ҽ����þ���' NOT NULL
    );

INSERT INTO INGREDIENT VALUES('������', 'M', DEFAULT,'�Ƹ޸�ĭġ��', '�����', '�ø�����');

DROP TABLE ORDER_TABLE;
DROP TABLE MENU_TABLE;
DROP TABLE INGREDIENT;
DROP TABLE INGREDIENT;


SELECT * FROM CUSTOM_INFO;
SELECT * FROM ORDER_TABLE;
SELECT * FROM MENU_TABLE;
SELECT * FROM INGREDIENT;


SELECT *
    FROM MENU_TABLE P JOIN ORDER_TABLE O
    ON P.MENU_NUM = O.MENU_NUM;
    
SELECT *
    FROM INGREDIENT A JOIN MENU_TABLE B
    ON A.MENU = B.MENU;


