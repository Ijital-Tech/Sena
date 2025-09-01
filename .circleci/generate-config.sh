cat << EOF

version: '2.1'

yuana: &yuana
  post-steps:
    - run:
        name: Publish Success Status to SNS
        command: |
          aws sns publish \
          --topic-arn \$CIRCLE_CI_SNS_TOPIC \
          --message "Build Success for \$CIRCLE_PROJECT_REPONAME" \
          --message-attributes '{
            "BuildNumber":{"DataType":"String", "StringValue":"'\$CIRCLE_BUILD_NUM'"},
            "Branch":{"DataType":"String", "StringValue":"'\$CIRCLE_BRANCH'"},
            "CircleCiJob":{"DataType":"String", "StringValue":"'\$CIRCLE_JOB'"},
            "Author":{"DataType":"String", "StringValue":"'\$CIRCLE_USERNAME'"},
            "BuildStatus":{"DataType":"String", "StringValue":"Success"}
          }'
        when: on_success
    - run:
        name: Publish Failure Status to SNS
        command: |
          aws sns publish \
          --topic-arn \$CIRCLE_CI_SNS_TOPIC \
          --message "Build Failure for \$CIRCLE_PROJECT_REPONAME" \
          --message-attributes '{
            "BuildNumber":{"DataType":"String", "StringValue":"'\$CIRCLE_BUILD_NUM'"},
            "Branch":{"DataType":"String", "StringValue":"'\$CIRCLE_BRANCH'"},
            "CircleCiJob":{"DataType":"String", "StringValue":"'\$CIRCLE_JOB'"},
            "Author":{"DataType":"String", "StringValue":"'\$CIRCLE_USERNAME'"},
            "BuildStatus":{"DataType":"String", "StringValue":"Failure"}
          }'
        when: on_fail

jobs:
  build:
    docker:
      - image: cimg/node:18.16 

    steps:
      - checkout
      - run:
          name: Push Docker Image
          command: |
            echo 'HELLOW WOLRD'

workflows:
  build:
    jobs:
      - build:
          <<: *yuana 
EOF