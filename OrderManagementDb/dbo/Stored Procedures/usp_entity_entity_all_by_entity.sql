
/*****************************************************************
**	Table Name: entity_entity
**	Procedure Name: usp_entity_entity_all_by_entity
**	Author: Richard Richards
**	Created: 04/2/2018
**	Copyright: QIQO Software, (c) 2015-2018
******************************************************************/

CREATE PROC [dbo].[usp_entity_entity_all_by_entity]
	@entity_key int,
	@entity_type_key int

AS
SET NOCOUNT ON

SELECT A.[entity_entity_key], 
	A.[primary_entity_key], 
	A.[primary_entity_type_key],
	A.[primary_entity_role_key], 
	A.[secondary_entity_key],
	A.[secondary_entity_type_key],
	A.[secondary_entity_role_key],
	A.[entity_entity_seq], 
	A.[start_date],
	A.[end_date],
	A.[comment], 
	A.[audit_add_user_id], 
	A.[audit_add_datetime], 
	A.[audit_update_user_id], 
	A.[audit_update_datetime]
FROM entity_entity A 
WHERE A.[primary_entity_key] = @entity_key
AND A.[primary_entity_type_key] = @entity_type_key


SET NOCOUNT OFF
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_entity_entity_all_by_entity] TO [businessuser]
    AS [dbo];

