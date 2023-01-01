/* Formatted on 17-Dec-22 9:34:33 PM (QP5 v5.227.12220.39754) */
CREATE TABLE product_info191222
AS
   SELECT * FROM product_info;
/

UPDATE product_info
   SET price_group_a = NULL;

COMMIT;
/
ALTER TABLE product_info MODIFY (price_group_a NUMBER(20,9));


UPDATE product_info v
   SET v.price_group_a =
          (SELECT tt.price_group_a
             FROM product_info191222 tt
            WHERE v.product_id = tt.product_id);

COMMIT;
/





CREATE TABLE invoice_d_1bk
AS
   SELECT * FROM invoice_d;


UPDATE invoice_m
   SET tot_trade_price = NULL,
       tot_vat_price = NULL,
       incl_vat_amt = NULL,
       tot_amount_t = NULL;

COMMIT;

ALTER TABLE invoice_d MODIFY (tot_trade_price NUMBER(20,9),
       tot_vat_price NUMBER(20,9),
       incl_vat_amt NUMBER(20,9),
       tot_amount_t NUMBER(20,9));
/


UPDATE invoice_d v
   SET (tot_trade_price,
        tot_vat_price,
        incl_vat_amt,
        tot_amount_t) =
          (SELECT tot_trade_price,
                  tot_vat_price,
                  incl_vat_amt,
                  tot_amount_t
             FROM invoice_d_1bk vv
            WHERE vv.inv_no = v.inv_no AND vv.product_id = v.product_id);

COMMIT;
/