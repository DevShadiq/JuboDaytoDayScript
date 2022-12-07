/* Formatted on 12/7/2022 11:45:54 AM (QP5 v5.227.12220.39754) */
CREATE TABLE INVOICE_M_BK
AS
   SELECT * FROM INVOICE_M;
/

UPDATE INVOICE_M
   SET INV_TYPE = NULL;

COMMIT;
/

ALTER TABLE INVOICE_M
MODIFY(INV_TYPE VARCHAR2(3))
/


UPDATE invoice_m t1
   SET inv_type =
          (SELECT inv_type
             FROM invoice_m_bk t2
            WHERE t1.inv_no = t2.inv_no);
/

COMMIT;
/