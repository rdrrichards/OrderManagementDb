


/*****************************************************************
**	Table Name: entity_entity
**	Procedure Name: usp_entity_entity_del
**	Author: Richard Richards
**	Created: 04/2/2018
**	Copyright: QIQO Software, (c) 2015-2018
******************************************************************/

CREATE PROC [dbo].[usp_entity_entity_del]
	@entity_entity_key int,
	@key int out
AS
SET NOCOUNT ON

BEGIN TRY
	DELETE FROM entity_entity
	WHERE [entity_entity_key] = @entity_entity_key;
	SELECT @key = @@ROWCOUNT;
END TRY
BEGIN CATCH
		EXEC usp_LogError 'entity_entity', 'usp_entity_entity_del';
	THROW;
END CATCH

SET NOCOUNT OFF
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_entity_entity_del] TO [businessuser]
    AS [dbo];

