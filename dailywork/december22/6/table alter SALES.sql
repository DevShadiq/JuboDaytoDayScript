/* Formatted on 12/6/2022 4:27:27 PM (QP5 v5.227.12220.39754) */
ALTER TABLE CM_PROJECT ADD (user1 VARCHAR2(50));
ALTER TABLE CM_PROJECT ADD (PRODUCT_TYPE VARCHAR2(50));


ALTER TABLE DISTRIBUTOR ADD (TEXT_BIN VARCHAR2(30));
ALTER TABLE DISTRIBUTOR ADD (REGI_STATUS VARCHAR2(30));
ALTER TABLE DISTRIBUTOR ADD (USER_ID VARCHAR2(30));


ALTER TABLE PRODUCT_INFO ADD (USER1 VARCHAR2(50));

ALTER  TABLE CM_SYS_USERS ADD (CONF_PASSWORD VARCHAR2(50));
ALTER  TABLE CM_SYS_USERS ADD (PIC BLOB);


ALTER  TABLE CM_SYS_USERS ADD (EMAIL VARCHAR2(50));

ALTER  TABLE CM_SYS_USERS ADD (NID VARCHAR2(50));

ALTER  TABLE CM_SYS_USERS ADD (CELL_NO VARCHAR2(50));

ALTER  TABLE CM_SYS_USERS ADD (ADDRESS VARCHAR2(200));

ALTER TABLE PROD_INFO ADD (DIST VARCHAR2(100),
                           THREE_P VARCHAR2(100)
);
/

ALTER TABLE PROD_INFO ADD (DIST_ID VARCHAR2(100));
/




ALTER TABLE VAT_FORMULATION ADD (INACTIVE_DATE DATE);
ALTER TABLE VAT_FORMULATION ADD (APP_DATE DATE);
ALTER TABLE VAT_FORMULATION ADD (USER1 VARCHAR2(50));



ALTER TABLE GOODS_REC_M ADD (user1 VARCHAR2(50));

ALTER TABLE GOODS_REC_M ADD (CUST_HOUSE VARCHAR2(200));
ALTER TABLE GOODS_REC_M ADD (RECEIVE_TYPE VARCHAR2(50));

ALTER TABLE GOODS_REC_M ADD (REBATE_MONTH date);
ALTER TABLE GOODS_REC_M ADD (CUST_CODE VARCHAR2(200));


ALTER TABLE GOODS_REC_D ADD (AT_PER NUMBER);
ALTER TABLE GOODS_REC_D ADD (AIT_PER NUMBER);
ALTER TABLE GOODS_REC_D ADD (VAT_PER NUMBER);
ALTER TABLE GOODS_REC_D ADD (SD_PER NUMBER);
ALTER TABLE GOODS_REC_D ADD (RD_PER NUMBER);
ALTER TABLE GOODS_REC_D ADD (CD_PER NUMBER);













