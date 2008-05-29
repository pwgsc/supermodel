<!---------------------------------- Comprehensive Example -------------------------------------------

	The following represents a typical view page that will test many of the important DataModel 
	functions altogether.
			
----------------------------------------------------------------------------------------------------->

<cfquery name="masterQuery" datasource="supermodel">
	SELECT 
		positions.manager_id,
		positions.process_id,
		positions.id AS position_id,
		name,
		number,
		title
	FROM users
	JOIN positions
	ON positions.manager_id = users.id
	JOIN processes
	ON processes.id = positions.process_id
</cfquery>

<cfset manager_object = createObject('component','manager') />
<cfset manager_object.init('supermodel') />
<cfset manager_object.filter_key = 'manager_id' />
<cfset managers = createObject('component', 'supermodel.objectlist') />
<cfset managers.init(manager_object, masterQuery) />

<cfoutput>

<h1>Manager Processes</h1>

<cfloop condition="#managers.next()#">
	<cfset manager = managers.current() />
	
	<h2>#manager.name#</h2>

	<cfloop condition="#manager.processes.next()#">
		<cfset process = manager.processes.current() />
		<p>
			#process.number#
	
			<ul>
				<cfloop condition="#process.positions.next()#">
					<cfset position = process.positions.current() />
					<li>#position.title#</li>
				</cfloop>
			</ul>
		</p>
	</cfloop>
</cfloop>

<h1>Manager Positions</h1>

<cfset managers.reset() />
<cfloop condition="#managers.next()#">
	<cfset manager = managers.current() />
	
	<h2>#manager.name#</h2>

	<p>	
		<ul>
			<cfloop condition="#manager.positions.next()#">
				<cfset position = process.positions.current() />
				<li>#position.title# #position.id# #position.manager.positions.current().manager.positions.current().manager.name#</li>
			</cfloop>
		</ul>
	</p>
</cfloop>


<cfset george = createObject('component','manager') />
<cfset george.init('supermodel') />
<cfset george.read(1) />

<cfset dan = createObject('component','manager') />
<cfset dan.init('supermodel') />
<cfset dan.read(2) />

#dan.name#
#george.name#
#dan.name#

#dan.positions.next()#
#george.positions.next()#

#dan.positions.current().title#
#george.positions.current().title#
#dan.positions.current().title#

</cfoutput>