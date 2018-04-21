
/*****************************************************************
**	Table Name: company
**	Procedure Name: usp_company_get
**	Author: Richard Richards
**	Created: 07/03/2015
**	Copyright: QIQO Software, (c) 2015
******************************************************************/

CREATE PROC [dbo].[usp_company_all_by_person]
	@employee_key int
AS
SET NOCOUNT ON

SELECT DISTINCT D.[company_key], 
	D.[company_code], 
	D.[company_name], 
	D.[company_desc], 
	D.[audit_add_user_id], 
	D.[audit_add_datetime], 
	D.[audit_update_user_id], 
	D.[audit_update_datetime]
FROM entity_entity A INNER JOIN person B
	ON A.secondary_entity_key = B.person_key
	AND A.secondary_entity_type_key = 3
	INNER JOIN company D
	ON A.primary_entity_key = D.company_key
	AND A.primary_entity_type_key = 1
WHERE B.person_key = @employee_key


SET NOCOUNT OFF



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_company_all_by_person] TO [businessuser]
    AS [dbo];

