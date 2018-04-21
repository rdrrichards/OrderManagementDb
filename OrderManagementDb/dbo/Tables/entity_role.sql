CREATE TABLE [dbo].[entity_role] (
    [entity_role_key]       INT           DEFAULT (NEXT VALUE FOR [entity_role_key_seq]) NOT NULL,
    [entity_role_code]      VARCHAR (10)  NOT NULL,
    [entity_role_name]      VARCHAR (50)  NOT NULL,
    [entity_role_desc]      VARCHAR (254) NOT NULL,
    [audit_add_user_id]     VARCHAR (30)  DEFAULT (suser_sname()) NOT NULL,
    [audit_add_datetime]    DATETIME      DEFAULT (getdate()) NOT NULL,
    [audit_update_user_id]  VARCHAR (30)  DEFAULT (suser_sname()) NOT NULL,
    [audit_update_datetime] DATETIME      DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([entity_role_key] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_entity_role_entity_role_code]
    ON [dbo].[entity_role]([entity_role_code] ASC);


GO



CREATE TRIGGER [dbo].[tgr_entity_role_audit]
    ON [dbo].[entity_role]
    FOR INSERT, UPDATE
    AS
    BEGIN
        SET NOCOUNT ON

		UPDATE A SET
			A.audit_add_datetime = ISNULL(A.audit_add_datetime, GETDATE()),
			A.audit_add_user_id = ISNULL(A.audit_add_user_id, SUSER_SNAME()),
			A.audit_update_datetime = GETDATE(),
			A.audit_update_user_id = SUSER_SNAME()
		FROM [entity_role] A INNER JOIN inserted B
		ON A.entity_role_key = B.entity_role_key

		DECLARE @old_xml XML, @new_xml XML

		SELECT @new_xml = (SELECT B.* 
		FROM [entity_role] A INNER JOIN inserted B
		ON A.entity_role_key = B.entity_role_key
		FOR XML RAW, ELEMENTS)

		SELECT @old_xml = (SELECT B.* 
		FROM [entity_role] A INNER JOIN deleted B
		ON A.entity_role_key = B.entity_role_key
		FOR XML RAW, ELEMENTS)

		IF (@new_xml IS NOT NULL OR @old_xml IS NOT NULL)
		INSERT INTO [dbo].[audit_log]
				   ([audit_action]
				   ,[audit_bus_obj]
				   ,[audit_comment]
				   ,[audit_data_old]
				   ,[audit_data_new])
			 VALUES
				   (CASE -- WHEN @old_xml IS NULL AND @new_xml IS NULL THEN 'D' 
						WHEN @old_xml IS NULL AND @new_xml IS NOT NULL THEN 'I'
						ELSE 'U' END
				   ,'entity_role'
				   ,'entity_role'
				   ,@old_xml
				   ,@new_xml)

    END





GO



CREATE TRIGGER [dbo].[tgr_entity_role_audit_del]
    ON [dbo].[entity_role]
    AFTER DELETE
    AS
    BEGIN
        SET NOCOUNT ON
		DECLARE @old_xml XML

		SELECT @old_xml = (SELECT B.* 
		FROM deleted B
		FOR XML RAW, ELEMENTS)

		IF (@old_xml IS NOT NULL)
		INSERT INTO [dbo].[audit_log]
				   ([audit_action]
				   ,[audit_bus_obj]
				   ,[audit_comment]
				   ,[audit_data_old]
				   )
			 VALUES
				   ('D' 
				   ,'entity_role'
				   ,'entity_role record deleted'
				   ,@old_xml
				   )

    END




