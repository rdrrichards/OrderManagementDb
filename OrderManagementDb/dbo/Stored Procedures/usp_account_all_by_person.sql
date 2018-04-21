
/*****************************************************************
**	Table Name: account
**	Procedure Name: usp_account_all_by_person
**	Author: Richard Richards
**	Created: 07/05/2015
**	Copyright: QIQO Software, (c) 2015
******************************************************************/

CREATE PROC [dbo].[usp_account_all_by_person]
	@person_key int
AS
SET NOCOUNT ON

SELECT A.[account_key], 
	A.[company_key], 
	A.[account_type_key], 
	A.[account_code], 
	A.[account_name], 
	A.[account_desc], 
	A.[account_dba], 
	A.[account_start_date], 
	A.[account_end_date], 
	A.[audit_add_user_id], 
	A.[audit_add_datetime], 
	A.[audit_update_user_id], 
	A.[audit_update_datetime]
FROM account A INNER JOIN entity_entity B
ON A.account_key = B.primary_entity_key
AND B.primary_entity_type_key = 3 -- account
AND B.secondary_entity_type_key IN (3,4) -- account or sales rep
WHERE B.secondary_entity_key = @person_key


SET NOCOUNT OFF




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_account_all_by_person] TO [businessuser]
    AS [dbo];

