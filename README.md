
Welcome to <strong>PPL</strong> RESTful API! This documentation should help you familiarize yourself with the resources available and how to consume them with HTTP requests.

# About the PPL Server
Created with Vapor, Skeleton, PostgreSQL ( + ❤︎) and deployed to Heroku, the PPL Server is a free RESTful API that you can use JSON data for various projects and purposes.

* The database is currently empty. Please add your own data to test the server using the client app associated with this project.

## How to use the PPL RESTful API

The Base URL for PPL is:

     https://gentle-ocean-61971.herokuapp.com/

**Endpoints:**  
  - /people	:  get all the people resources  
  - /people/ :  id : get a specific people resource  
  - /all :  admin page for adding and deleting persons into the database  

**Person Object**  
**Attributes:**  
  - id 			 		— Type Integer. The identifier of this person  
  - name 		 		— Type String. The name of this person  
  - favoritecity 		— Type String.The favorite city of this person  

**Example request:**  
https://gentle-ocean-61971.herokuapp.com/people/1    
  
**Example response:**  
{“favoritecity”:”Brooklyn","id":1,"name":"Sean"}  
  
**Authentication**  
PPL is a completely open API. No authentication is required to retrieve/post/update/delete data.

**JSON**  
JSON is the data format provided by PPL.

** This Readme will be updated with detailed instructons on how to make HTTP requests.**
