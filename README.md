# EVENTY

A place to host and manage events

* Ruby version ```3.0.0```

* Rails ```6.1.4```

Docker instructions
- Run the below command to build the docker image
`ruby
  docker-compose build
`

- Start eventy application in development mode by running the command
`ruby
  docker-compose up eventy_app
`

- Run Rpsec tests by running the command
`ruby
  docker-compose up eventy_test
`

- Running the below command starts the eventy application in development and also starts the rspec tests
`ruby
  docker-compose up
`

Note:
- Uncomment the 'env_file: .env' in docker-compose.yml when using .env file for loading the environment variables
