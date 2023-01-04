(select ADD_MONTHS(:P_From_Date,-10000) DIST_ID,'     ' V_NO, TRUNC(:P_From_Date)  V_DATE, 0 C_MODE,'        Opening ' NARRATION,
  (sum(nvl(b.r_amt,0))-sum(nvl(b.I_amt,0))) OpeningBal, 0 r_amt, 0  I_amt, 0 balance, ' ' Dist_name, ' ' Iden_no, ' ' d_address, ' ' pl_time, ' ' pl_date, ' ' PRODUCT_NAME, 0 amount, 0 vat
from (
select b.product_id DIST_ID,sum(nvl(b.good_qty,0)) r_amt,0 i_amt
  from  goods_rec_m a,goods_rec_d b,product_info c 
  where a.rec_batch_id=b.rec_batch_id
AND A.UNIT=B.UNIT
and b.product_id=c.product_id
        and b.product_id=:p_dist_id
 and a.REC_DATE < :P_From_Date
and a.rec_DATE >'31-jul-2009'
--&PR
Group by b.product_id
union
select  b.product_id DIST_ID,sum(nvl(b.TRD_QTY,0)) r_amt, 0 I_amt
 from TRANSFER_RECEIVE_M a,TRANSFER_RECEIVE_d b,product_info c 
 where b.product_id=:p_dist_id
and a.status='P'
and b.product_id=c.product_id
--and c.p_type='N'
and a.TRM_ID=b.TRM_ID
 and a.TRM_DATE < :P_From_date
AND A.UNIT=B.UNIT
--&PR
group by b.product_ID
union all
select  b.product_id DIST_ID,0 r_amt, sum(nvl(b.inv_qty,0)) I_amt
 from invoice_m a,invoice_d b,product_info c
 where b.product_id=:p_dist_id
AND A.UNIT=B.UNIT
and b.product_id=c.product_id
and a.status='P'
--and c.p_type='N'
and a.inv_no=b.inv_no
 and a.inv_date < :P_From_date
and a.delivery_DATE>'31-jul-2009'
--&PR
group by b.product_ID
union all
select  b.product_id DIST_ID,0 r_amt, sum(nvl(b.del_qty,0)) I_amt
 from goods_distribution_m a,goods_distribution_d b,product_info c
 where b.product_id=:p_dist_id
AND A.UNIT=B.UNIT
and b.product_id=c.product_id
and a.status='P'
--and c.p_type='N'
and a.distribution_no=b.distribution_no
 and a.delivery_DATE < trunc(:P_From_date)
and a.delivery_DATE>'31-jul-2009'
--&PR
group by b.product_ID
union all
select  b.product_id DIST_ID,0 r_amt, sum(nvl(b.GOOD_qty,0)) I_amt
 from goods_DISPATCH_m a,goods_DISPATCH_d b,product_info c
 where b.product_id=:p_dist_id
and b.product_id=c.product_id
AND A.UNIT=B.UNIT
and a.status='P'
--and c.p_type='N'
and a.DISP_BATCH_NO=b.DISP_BATCH_NO
 and a.DISP_DATE < trunc(:P_From_date)
and a.DISP_DATE>'31-jul-2009'
--&PR
group by b.product_ID
union all
select  b.product_id DIST_ID,sum(nvl(b.GOOD_qty,0)) r_amt, 0 I_amt
 from return_m a,return_d b,product_info c
 where b.product_id=:p_dist_id
AND A.UNIT=B.UNIT
and a.status='P'
and b.product_id=c.product_id
--and c.p_type='N'
and a.type='R'
and a.return_NO=b.return_NO
 and a.return_DATE < trunc(:P_From_date)
--&PR
group by b.product_ID
union all
select  b.product_id DIST_ID,0 r_amt, sum(nvl(b.GOOD_qty,0)) I_amt
 from return_m a,return_d b,product_info c
 where b.product_id=:p_dist_id
AND A.UNIT=B.UNIT
and b.product_id=c.product_id
and a.status='P'
--and c.p_type='N'
and a.type='D'
and a.return_NO=b.return_NO
 and a.return_DATE < trunc(:P_From_date)
--&PR
group by b.product_ID
union all
select  b.product_id DIST_ID,0 r_amt, sum(nvl(b.TRD_QTY,0)) I_amt
 from TRANSFER_RECEIVE_M a,TRANSFER_RECEIVE_D b,product_info c
 where b.product_id=:p_dist_id
AND A.UNIT=B.UNIT
and b.product_id=c.product_id
and a.TRM_ID=b.TRM_ID
 and a.TRM_DATE < :P_From_date
--&PR
group by b.product_ID

) b
group by b.DIST_ID
UNION
select DIST_ID, V_NO, v_date,C_MODE, NARRATION,0 OpeningBal, nvl(r_amt,0) , nvl(I_amt,0), (nvl(r_amt,0) - nvl(I_amt,0)) balance , Dist_name, Iden_no,
d_address,  pl_time, pl_date, PRODUCT_NAME, amount, vat
 from
(select  ' '||a.inv_no v_no, a.delivery_DATE v_date, a.RPT_DATE_TIME DIST_ID,NVL(b.SD,0) C_MODE,'  Sales' NARRATION,0 r_amt,b.inv_qty I_amt, c.Dist_name, a.Iden_no, c.address d_address, to_char(a.pl_time1,'hh24:mi') pl_time, a.pl_date, d.PRODUCT_NAME, (NVL(b.TOT_AMOUNT_T,0)-NVL(b.P_DISCOUNT,0)) amount, NVL(b.TOT_VAT_PRICE,0) vat
 from invoice_m a,invoice_d b, Distributor c, PRODUCT_INFO d
 where b.product_id=:p_dist_id
AND A.UNIT=B.UNIT
and a.status='P'
--and d.p_type='N'
            and a.dist_id = c.dist_id
            and b.product_id = d.product_id
and a.inv_no=b.inv_no
 and   a.INV_DATE between :P_From_Date and  :P_To_Date 
--&PR
union all
select  a.inv_no v_no, a.return_DATE v_date, a.RPT_DATE_TIME DIST_ID,0 C_MODE,' Credit Note Invoice No :'||e.inv_no||' Date'||e.inv_date||'  '||a.reason NARRATION,b.good_qty r_amt,0 I_amt, c.Dist_name, ' ' Iden_no, c.address d_address,' ' pl_time, ' ' pl_date, d.PRODUCT_NAME,0 amount, 0 vat
 from return_m a,return_d b, Distributor c, PRODUCT_INFO d,INVOICE_M e
 where b.product_id=:p_dist_id
AND A.UNIT=B.UNIT
and b.inv_no=e.inv_no
and a.status='P'
--and d.p_type='N'
and a.type='R'
            and a.dist_id = c.dist_id
            and b.product_id = d.product_id
and a.return_no=b.return_no
 and   a.return_DATE between TRUNC(:P_From_Date) and  TRUNC(:P_To_Date) 
--&PR
union all
select '       '||to_Char(a.rec_batch_id) V_no,a.rec_DATE V_date, a.RPT_DATE_TIME DIST_ID,0  C_MODE,' Receive'  NARRATION, b.good_qty r_amt, 0 I_amt, ' ' Dist_name, ' ' Iden_no, ' ' d_address, ' ' pl_time, ' ' pl_date, ' ' PRODUCT_NAME, 0 amount, 0 vat
     from  goods_rec_m a, goods_rec_d b,product_info c
 where a.rec_batch_id=b.rec_batch_id    
AND A.UNIT=B.UNIT
and b.product_id=c.product_id
and a.status='P'
--and c.p_type='N'  
--and a.rec_from=c.comp_id
          and b.product_id=:p_dist_id
 and   a.rec_DATE between :P_From_Date and  :P_To_Date 
--&PR

union all
select to_Char(a.distribution_no) V_no,a.delivery_DATE V_date, a.RPT_DATE_TIME DIST_ID,0  C_MODE,' '  NARRATION, 0 r_amt, b.del_qty I_amt, ' ' Dist_name, ' ' Iden_no, ' ' d_address, ' ' pl_time, ' ' pl_date, ' ' PRODUCT_NAME, 0 amount, 0 vat
     from  goods_distribution_m a, goods_distribution_d b,product_info c
 where a.distribution_no=b.distribution_no    
and b.product_id=c.product_id
AND A.UNIT=B.UNIT
and a.status='P'
--and c.p_type='N'    
          and b.product_id=:p_dist_id
 and   a.delivery_DATE between :P_From_Date and  :P_To_Date
--&PR
union all
select to_Char(a.DISP_CHALL_NO) V_no,a.disp_DATE V_date,a.RPT_DATE_TIME DIST_ID,0  C_MODE,' Transfer'  NARRATION, 0 r_amt, b.good_qty I_amt, c.store_name Dist_name, ' ' Iden_no, ' ' d_address, ' ' pl_time, ' ' pl_date, ' ' PRODUCT_NAME, b.TOT_PRICE amount,0 vat
     from  goods_dispatch_m a, goods_dispatch_d b,STORE c,product_info d
 where a.DISP_BATCH_NO=b.DISP_BATCH_NO
and b.product_id=d.product_id
AND A.UNIT=B.UNIT
          and b.product_id=:p_dist_id
 and   a.disp_DATE between :P_From_Date and  :P_To_Date
--&PR
union all
select A.TRANS_NO V_no,a.TRM_DATE V_date, a.RPT_DATE_TIME DIST_ID,0  C_MODE,' Transfer Received '  NARRATION, b.trd_qty r_amt, 0 I_amt, E.PROJECT_NAME Dist_name, ' ' Iden_no, ' ' d_address, ' ' pl_time, ' ' pl_date, ' ' PRODUCT_NAME, 0 amount, 0 vat
     from  TRANSFER_RECEIVE_M a,TRANSFER_RECEIVE_D b,product_info c,CM_PROJECT E
 where a.TRM_ID=b.TRM_ID  
AND A.UNIT=B.UNIT
and b.product_id=c.product_id
          and b.product_id=:p_dist_id
 and   a.TRM_DATE between :P_From_Date and  :P_To_Date 
AND A.PROJECT_ID=E.PROJECT_ID
--&PR
--union all
--select ' '  V_no,e_DATE V_date, :p_dist_id DIST_ID,0  C_MODE,' '  NARRATION, 0 r_amt, 0 I_amt, ' ' Dist_name, ' ' Iden_no, ' ' d_address, ' ' pl_time, ' ' pl_date, ' ' PRODUCT_NAME, 0 amount, 0 vat
  --  from  DUMP_TABLE 
-- where   e_DATE between :P_From_Date and  :P_To_Date

))
order by  V_date,dist_id