# ASpace API Documentation
## Version: DRAFT

## REST endpoints (candidates)

/version
GET the version of the API

/repositories  
GET a param-filtered set of repository records  
POST a new repository  

/repositories/{key}  
GET a particular repository record  
PUT a new* or updated repository record  
\* Can repository IDs be set by an API client?  

/{repo-id}/resources  
GET a param-filtered set of top-level resource records  
POST a new top-level resource record  

/{repo-id}/resources/{key}  
GET a particular top-level resource record  
PUT a new* or updated top-level resource record  
\* Can top-level resource IDs be set by an API client?  

/{repo-id}/archival_objects  
GET a param-filtered set of archival objects  
POST a new archival object  

/{repo-id}/archival_objects/{key}  
GET a particular archival object  
PUT an updated archival object  

/{repo-id}/accessions  
GET a param-filtered set of accession records  
POST a new archival object  

/{repo-id}/accessions/{key}  
GET a particular accession record  
PUT an updated accession record  

## Document History

<table>
	<tr>
		<td>When</td>
		<td>Who</td>
		<td>What</td>
	</tr>
	<tr>
		<td>2012-08-02</td>
		<td>Brian Hoffman</td>
		<td>Created document</td>
	</tr>
</table>









