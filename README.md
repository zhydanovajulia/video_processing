# README

* Ruby version

2.6.2

* Rails version 

6.0.0

* How to run the test suite

rspec

* API routes

GET        /api/:version/subscribe(.json)

POST       /api/:version/create_video(.json)
```
requires :token, type: String, documentation: { desc: "Unique token to identify user" }
requires :file, documentation: { desc: "Path to file to be uploaded" }
requires :start_time, type: String, documentation: { desc: "The beginning of video" }
requires :end_time, type: String, documentation: { desc: "The ending of video" }
```

PUT        /api/:version/retry_processing_video(.json)
```
requires :token, type: String, documentation: { desc: "Unique token to identify user" }
requires :video_id, type: String, documentation: { desc: "ID of the video to be processed" }
```

GET        /api/:version/video_list(.json)
```
requires :token, type: String, documentation: { desc: "Unique token to identify user" }
```
