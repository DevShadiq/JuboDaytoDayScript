/* Formatted on 12/12/2022 2:12:59 PM (QP5 v5.227.12220.39754) */
update invoice_m i 
set status = null
where I.INV_NO IN
          ('NAR-2022-2023-000169',
           'NAR-2022-2023-000148',
           'RAJ-2022-2023-000770',
           'RAJ-2022-2023-000713',
           'RAJ-2022-2023-000250');


/
commit;
/


SELECT STATUS
  FROM invoice_m i
 WHERE I.INV_NO IN
          ('NAR-2022-2023-000169',
           'NAR-2022-2023-000148',
           'RAJ-2022-2023-000770',
           'RAJ-2022-2023-000713',
           'RAJ-2022-2023-000250');
/


/* Formatted on 12/12/2022 2:20:53 PM (QP5 v5.227.12220.39754) */
UPDATE raw04.goods_rec_m r
   SET status = NULL
 WHERE R.RCV_NO IN
          ('2022-2023-0002457',
           '2022-2023-0002458',
           '2022-2023-0002459',
           '2022-2023-0002460',
           '2022-2023-0002461');
/

commit;
/

SELECT status
  FROM raw04.goods_rec_m r
 WHERE R.RCV_NO IN
          ('2022-2023-0002457',
           '2022-2023-0002458',
           '2022-2023-0002459',
           '2022-2023-0002460',
           '2022-2023-0002461');
/