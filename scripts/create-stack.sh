#!/bin/bash

# creates a stack in AWS via CloudFromation

STACKNAME=${1:-Weapon-X}
PROJECTNAME=${2:-Weapon-X}
NETWORK=${3:-10.0.0.0}
INSTANCETYPE=${4:-m4.large}
SPOTPRICE=${5:-0.05}
ENVIRONMENT=${6:-development}
CREATOR=${7:-CloudFormation}
TEMPLATELOCATION=${8:-file://$(pwd)/full-stack.yml}

VALIDATE="aws cloudformation validate-template --template-body $TEMPLATELOCATION"
echo $VALIDATE
$VALIDATE

CREATE="aws cloudformation create-stack --stack-name $STACKNAME \
                                        --template-body $TEMPLATELOCATION \
                                        --capabilities CAPABILITY_NAMED_IAM \
                                        --parameters ParameterKey=Project,ParameterValue=$PROJECTNAME \
                                                     ParameterKey=Environment,ParameterValue=$ENVIRONMENT \
                                                     ParameterKey=Creator,ParameterValue=$CREATOR \
                                                     ParameterKey=Network,ParameterValue=$NETWORK \
                                                     ParameterKey=InstanceType,ParameterValue=$INSTANCETYPE \
                                                     ParameterKey=SpotPrice,ParameterValue=$SPOTPRICE \
                                        --tags Key=Project,Value=$PROJECTNAME \
                                               Key=Environment,Value=$ENVIRONMENT \
                                               Key=Creator,Value=$CREATOR"
echo $CREATE
$CREATE
