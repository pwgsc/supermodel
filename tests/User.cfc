<cfcomponent extends="supermodel.datamodel">
	<cffunction name="configure" access="private" returntype="void">
		<cfset variables.table_name = "users" />
		<cfset belongsTo('company', 'supermodel.tests.Company') />
	</cffunction>
</cfcomponent>