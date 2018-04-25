




/*****************************************************************
**	Table Name: entity_entity
**	Procedure Name: usp_entity_entity_ups
**	Author: Richard Richards
**	Created: 04/2/2018
**	Copyright: QIQO Software, (c) 2015-2018
******************************************************************/

CREATE PROC [dbo].[usp_entity_entity_ups]
	@entity_entity_key int, 
	@primary_entity_key int, 
	@primary_entity_type_key int,
	@primary_entity_role_key int, 
	@secondary_entity_key int,
	@secondary_entity_type_key int,
	@secondary_entity_role_key int,
	@entity_entity_seq int, 
	@start_date datetime,
	@end_date datetime,
	@comment varchar(150),
	@key int out
AS
SET NOCOUNT ON
IF @entity_entity_key = 0 BEGIN
	BEGIN TRY
	DECLARE @new_key int;
	SELECT @new_key = NEXT VALUE FOR entity_entity_key_seq;
	INSERT INTO entity_entity ( --[entity_entity_key], 
		[primary_entity_key], 
		[primary_entity_type_key],
		[primary_entity_role_key], 
		[secondary_entity_key],
		[secondary_entity_type_key],
		[secondary_entity_role_key],
		[entity_entity_seq], 
		[start_date],
		[end_date],
		[comment]
	)
	VALUES (-- @entity_entity_key, 
		@primary_entity_key, 
		@primary_entity_type_key,
		@primary_entity_role_key, 
		@secondary_entity_key,
		@secondary_entity_type_key,
		@secondary_entity_role_key,
		@entity_entity_seq, 
		@start_date,
		@end_date,
		@comment
	)
	SELECT @key = @new_key;
	END TRY
	BEGIN CATCH
		EXEC usp_LogError 'entity_entity', 'usp_entity_entity_ups', 'I';
		THROW;
	END CATCH
END
ELSE BEGIN
	BEGIN TRY
	UPDATE entity_entity SET 
		[primary_entity_key] = @primary_entity_key,
		[primary_entity_type_key] = @primary_entity_type_key,
		[primary_entity_role_key] = @primary_entity_role_key,
		[secondary_entity_key] = @secondary_entity_key,
		[secondary_entity_type_key] = @secondary_entity_type_key,
		[secondary_entity_role_key] = @secondary_entity_role_key,
		[entity_entity_seq] = @entity_entity_seq,
		[start_date] = @start_date,
		[end_date] = @end_date,
		[comment] = @comment
	WHERE [entity_entity_key] = @entity_entity_key
		AND ([primary_entity_key] <> @primary_entity_key
		OR  [primary_entity_type_key] <> @primary_entity_type_key
		OR [primary_entity_role_key] <> @primary_entity_role_key
		OR [secondary_entity_key] <> @secondary_entity_key
		OR [secondary_entity_type_key] <> @secondary_entity_type_key
		OR [secondary_entity_role_key] <> @secondary_entity_role_key
		OR [entity_entity_seq] <> @entity_entity_seq
		OR [start_date] <> @start_date
		OR [end_date] <> @end_date
		OR [comment] <> @comment);
	SELECT @key = @entity_entity_key;

	END TRY
	BEGIN CATCH
		EXEC usp_LogError 'entity_entity', 'usp_entity_entity_ups', 'U';
		THROW;
	END CATCH
END

SET NOCOUNT OFF
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_entity_entity_ups] TO [businessuser]
    AS [dbo];

