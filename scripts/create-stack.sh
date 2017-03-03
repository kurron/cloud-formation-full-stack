#!/bin/bash

# creates a stack in AWS via CloudFromation

STACKNAME=${1:-Phoenix}
PROJECTNAME=${2:-Weapon-X}
NETWORK=${3:-10.0.0.0}
INSTANCETYPE=${4:-m4.large}
SPOTPRICE=${5:-0.03}
SEARCH_DOMAIN_NAME=${6:-phoenix}
ENVIRONMENT=${7:-development}
CREATOR=${8:-CloudFormation}
TEMPLATELOCATION=${9:-file://$(pwd)/full-stack.yml}

VALIDATE="aws cloudformation validate-template --template-body $TEMPLATELOCATION"
echo $VALIDATE
$VALIDATE

CREATE="aws cloudformation create-stack --stack-name $STACKNAME \
                                        --disable-rollback \
                                        --template-body $TEMPLATELOCATION \
                                        --capabilities CAPABILITY_NAMED_IAM \
                                        --parameters ParameterKey=Project,ParameterValue=$PROJECTNAME \
                                                     ParameterKey=Environment,ParameterValue=$ENVIRONMENT \
                                                     ParameterKey=Creator,ParameterValue=$CREATOR \
                                                     ParameterKey=Network,ParameterValue=$NETWORK \
                                                     ParameterKey=InstanceType,ParameterValue=$INSTANCETYPE \
                                                     ParameterKey=SpotPrice,ParameterValue=$SPOTPRICE \
                                                     ParameterKey=SearchDomainName,ParameterValue=$SEARCH_DOMAIN_NAME \
                                        --tags Key=Project,Value=$PROJECTNAME \
                                               Key=Environment,Value=$ENVIRONMENT \
                                               Key=Creator,Value=$CREATOR"
echo $CREATE
$CREATE
