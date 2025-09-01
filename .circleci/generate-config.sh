cat << EOF

version: '2.1'

`cat ./.circleci/yuana.txt`

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