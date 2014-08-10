
/****** Object:  StoredProcedure [dbo].[GetFilteredEvents]    Script Date: 8/10/2014 4:52:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		William A. Homer, codeOkla.com
-- Create date: 20140810
-- Description:	Returns All records from dbo.Events based on supplied criteria
-- =============================================
CREATE PROCEDURE [dbo].[GetFilteredEvents]
	@CriteriaList nvarchar(MAX)	= null	-- comma delimited key:value pairings (key1:value1,key2:value2,key3:value3)
	,@ParameterCriteriaList nvarchar(MAX) = null
AS
BEGIN

/******************************************************************************************************************************/
/*	FUTURE POTENTIAL:                                                                                                         */
/*  This proc could be extended by adding a second input variable for EventPropertyXml searching.	                          */
/*  The Where clause/@sql parameter below would built dynamically as it already is, but where EventPropertyXml.value( . . .   */
/*  Since the Property XML does not have preset elements, the below examples would need to be modified to plug in             */
/*  key name and value (now only dynamically pulls value).  It will need the correct nodes, but won't change so maybe  easier */
/******************************************************************************************************************************/

DECLARE @tblCriteria table (rownum int identity(1,1), criteria varchar(150)) 
INSERT INTO @tblCriteria (criteria) SELECT * FROM dbo.fn_ParseParametersStripSpace(@CriteriaList,',') 

DECLARE @MaxCount int = (SELECT MAX(rownum) FROM @tblCriteria)
DECLARE @ctr int = 1
DECLARE @AndKeeper bit = 0

DECLARE @sql varchar(MAX)
SET @sql = 'SELECT * FROM dbo.Events WHERE EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '

WHILE @ctr < @MaxCount + 1
BEGIN
	
	-- GEOCODE
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'lat_deg'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:Geocode/xsd:lat_deg)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'lat_deg' )
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'lon_deg'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:Geocode/xsd:lon_deg)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'lon_deg' )
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'radius'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:Geocode/xsd:radius)[1]'', ''nvarchar(50)'') <= ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'radius' ) 
				SET @AndKeeper = 1
			END
	-- LOCATION
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'loc_id'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:Location/xsd:loc_id)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'loc_id' )
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'loctype_id'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:Location/xsd:loctype_id)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'loctype_id' )
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'country_id'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:Location/xsd:country_id)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'country_id' ) 
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'region_id'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:Location/xsd:region_id)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'region_id' ) 
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'adm1_id'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:Location/xsd:adm1_id)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'adm1_id' ) 
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'adm2_id'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:Location/xsd:adm2_id)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'adm2_id' ) 
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'adm3_id'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:Location/xsd:adm3_id)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'adm3_id' ) 
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'adm4_id'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:Location/xsd:adm4_id)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'adm4_id' ) 
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'adm5_id'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:Location/xsd:adm5_id)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'adm5_id' ) 
				SET @AndKeeper = 1
			END

	-- REPORT
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'report_date'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:report/xsd:report_date)[1]'', ''nvarchar(50)'') = CAST(''' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'report_date' )   + ''' AS datetime)'
				SET @AndKeeper = 1
			END


		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'period_date'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:report/xsd:period_date)[1]'', ''datetime'') = CAST(''' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'period_date' )  + ''' AS datetime)'
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'source_id'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:report/xsd:source_id)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'source_id' ) 
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'method_id'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:report/xsd:method_id)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'method_id' ) 
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'method_lnk'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:report/xsd:method_lnk)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'method_lnk' ) 
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'datatype_id'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:report/xsd:datatype_id)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'datatype_id' ) 
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'crisis_id'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:report/xsd:crisis_id)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'crisis_id' ) 
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'crisis_lnk'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:report/xsd:crisis_lnk)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'crisis_lnk' ) 
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'data_lnk'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:report/xsd:data_lnk)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'data_lnk' ) 
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'subsource_id'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:report/xsd:subsource_id)[1]'', ''nvarchar(50)'') = ' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'subsource_id' ) 
				SET @AndKeeper = 1
			END

		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'from_date'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:report/xsd:from_date)[1]'', ''datetime'') >= CAST(''' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'from_date' ) + ''' AS datetime)'
				SET @AndKeeper = 1
			END
		IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':') ) = 'to_date'  
			BEGIN
				IF @AndKeeper = 1 
					BEGIN
						SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
						SET @AndKeeper = 0
					END
				SET @sql = @sql + 
					'(/xsd:HumanitarianEvent/xsd:report/xsd:to_date)[1]'', ''datetime'') <= CAST(''' + 
					(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'to_date' )  + ''' AS datetime)'
				SET @AndKeeper = 1
			END



	SET @ctr = @ctr + 1
END


-- FUTURE CODE
-- Now handle Property criteria

--DECLARE @tblParameterCriteria table (rownum int identity(1,1), criteria varchar(150))
--INSERT INTO @tblParameterCritera (criteria) SELECT * FROM dbo.fn_ParseParametersStripSpace(@ParameterCriteriaList,',')
--DECLARE @PMaxCount int = (SELECT MAX(rownum) FROM @tblParameterCritera)


--WHILE @ctr < @PMaxCount + 1
--BEGIN
--	IF (select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblParameterCritera WHERE rownum = @ctr), ':') ) = 'lat_deg'  
--		BEGIN
--			IF @AndKeeper = 1 
--				BEGIN
--					SET @sql = @sql + ' AND EventEnvelopeXml.value(''declare namespace xsd="http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/"; '
--					SET @AndKeeper = 0
--				END
--			SET @sql = @sql + 
--				'(/xsd:EventPropertyXML/xsd:PropertyCategories/xsd:PropertyCategory/xsd:CatProperty/xsd:PropName/xsd:lat_deg)[1]'', ''nvarchar(50)'') = ' + 
--				(select top(1) Parameter FROM dbo.fn_ParseParametersStripSpace((SELECT criteria FROM @tblCriteria WHERE rownum = @ctr), ':')  WHERE NOT Parameter like 'lat_deg' )
--			SET @AndKeeper = 1
--		END
--END

EXECUTE (@sql)

END

GO


