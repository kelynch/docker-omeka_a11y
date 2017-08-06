## Omeka_a11y Docker Image
Docker image to build and deploy an installation of Omeka_a11y with plugins required to facilitate DPLAH's Passthrough Workflow.

## Instructions

### Build and Deploy
* Build the image:
  ```
  docker build -t omeka_a11y:latest .
  ```
   
* Spin up the application:
  ```
  docker-compose up
  ```

### Import items from CSV to OAI

* Go to [http://localhost](http://localhost) and fill out the site form.   You can leave all of the default values populated as they are here, just specify usernames/emails for the super user and admin, and the site name.

* Log into the admin dashboard.  Go to the [Plugins page](http://localhost/admin/plugins) and activate all three plugins.

* Create a public collection from the [Add a Collection page](http://localhost/admin/collections/add).  

* Go to the [CSV Import page](http://localhost/admin/csv-import) to import items from a prepared CSV file.  
    Notes:
    * All items must be set to "public" in order to appear in the OAI feed.
    * The identifier column must occur before the thumbnail column.
    * The "file" column must be checked for the thumbnail column.
    * Multi-valued fields are separated by the "|" character. 

* Once some items have been added, go to the [OAI-PMH ListRecords endpoint](http://localhost/oai-pmh-repository/request?verb=ListRecords&metadataPrefix=oai_dc) to preview the OAI feed.
