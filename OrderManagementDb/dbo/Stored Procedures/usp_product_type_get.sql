﻿
/*****************************************************************
**	Table Name: product_type
**	Procedure Name: usp_product_type_get
**	Author: Richard Richards
**	Created: 06/23/2015
**	Copyright: QIQO Software, (c) 2015
******************************************************************/

CREATE PROC [dbo].[usp_product_type_get]
	@product_type_key int
AS
SET NOCOUNT ON

SELECT [product_type_key], 
	[product_type_category], 
	[product_type_code], 
	[product_type_name], 
	[product_type_desc], 
	[audit_add_user_id], 
	[audit_add_datetime], 
	[audit_update_user_id], 
	[audit_update_datetime]
FROM product_type
WHERE [product_type_key] = @product_type_key


SET NOCOUNT OFF




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_product_type_get] TO [businessuser]
    AS [dbo];

