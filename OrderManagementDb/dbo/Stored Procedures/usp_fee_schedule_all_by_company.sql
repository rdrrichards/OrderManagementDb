

/*****************************************************************
**	Table Name: fee_schedule
**	Procedure Name: usp_fee_schedule_all
**	Author: Richard Richards
**	Created: 07/15/2015
**	Copyright: QIQO Software, (c) 2015
******************************************************************/

CREATE PROC [dbo].[usp_fee_schedule_all_by_company]
	@company_key int
AS
SET NOCOUNT ON

SELECT A.[fee_schedule_key], 
	A.[company_key], 
	A.[account_key], 
	A.[product_key], 
	A.[fee_schedule_start_date], 
	A.[fee_schedule_end_date], 
	A.[fee_schedule_type], 
	A.[fee_schedule_value], 
	A.[audit_add_user_id], 
	A.[audit_add_datetime], 
	A.[audit_update_user_id], 
	A.[audit_update_datetime],
	B.product_desc,
	B.product_code,
	C.account_code,
	C.account_name
FROM fee_schedule A INNER JOIN product B
ON A.product_key = B.product_key
JOIN account C
ON A.account_key = C.account_key
AND A.company_key = C.company_key
WHERE A.company_key = @company_key
AND GETDATE() BETWEEN [fee_schedule_start_date] AND [fee_schedule_end_date]


SET NOCOUNT OFF




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_fee_schedule_all_by_company] TO [businessuser]
    AS [dbo];

