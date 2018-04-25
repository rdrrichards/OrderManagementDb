
/*****************************************************************
**	Table Name: entity_entity
**	Procedure Name: usp_entity_entity_all
**	Author: Richard Richards
**	Created: 04/2/2018
**	Copyright: QIQO Software, (c) 2015-2018
******************************************************************/

CREATE PROC [dbo].[usp_entity_entity_all]
AS
SET NOCOUNT ON

SELECT [entity_entity_key], 
	[primary_entity_key], 
	[primary_entity_type_key],
	[primary_entity_role_key], 
	[secondary_entity_key],
	[secondary_entity_type_key],
	[secondary_entity_role_key],
	[entity_entity_seq], 
	[start_date],
	[end_date],
	[comment], 
	[audit_add_user_id], 
	[audit_add_datetime], 
	[audit_update_user_id], 
	[audit_update_datetime]
FROM entity_entity


SET NOCOUNT OFF
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_entity_entity_all] TO [businessuser]
    AS [dbo];

