cat << EOF

version: '2.1'

`cat ./.circleci/yuana.txt`

orbs:
  win: circleci/windows@5.0
  slack: circleci/slack@4.13.1

jobs:
  build:
    docker:
      - image: cimg/node:18.16 

    steps:
      - checkout
      - run:
          name: Push Docker Image
          command: |
            echo 'HELLOW WOLR'

workflows:
  build:
    jobs:
      - build:
        #   <<: *slack-post-steps
EOF