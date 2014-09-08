/****** Object:  UserDefinedFunction [dbo].[fn_ParseParametersStripSpace]    Script Date: 8/10/2014 3:42:07 PM ******/


-- =============================================
-- Author:		William A. Homer, codeOkla.com
-- Create date: 20140810
-- Description:	Returns a table of Parameter parsed from a delimited list (nvarchar(max)
-- =============================================
CREATE FUNCTION [dbo].[fn_ParseParametersStripSpace]
(
	@ParamString nvarchar(MAX)
	, @Delimeter char(1) = ','
)
RETURNS @Parameters TABLE (Parameter nvarchar(MAX))
AS
BEGIN
	DECLARE @index INT, @NextParameter nvarchar(100)
	
	SELECT @index = 1
	WHILE @index > 0
		BEGIN
			SELECT @index = CHARINDEX(@Delimeter, @ParamString)
			IF @index > 0
				SELECT @NextParameter = LEFT(@ParamString, @index -1)
			ELSE
				SELECT @NextParameter = @ParamString
				--strip any spaces from the string
				SET @NextParameter = LTRIM(@NextParameter)
				SET @NextParameter = RTRIM(@NextParameter)
			INSERT @Parameters(Parameter) VALUES(CAST(@NextParameter AS VarChar))
			SELECT @ParamString = RIGHT(@ParamString, LEN(@ParamString) - @index)
			IF (LEN(@ParamString) = 0) BREAK
		END
	RETURN

END


GO