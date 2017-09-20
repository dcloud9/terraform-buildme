#! /bin/bash
case $1 in
	'london')
		REGION='eu-west-2'
		;;
	'ireland')
		REGION='eu-west-1'
		;;
	'virginia')
		REGION='us-east-1'
		;;
	'frankfurt') 
		REGION='eu-central-1'
		;;
	'singapore') 
		REGION='ap-southeast-1'
		;;
	# Add more regions here and update echo usage bit.		
	*)
		echo "REGION not defined. Usage: $0 london|ireland|virginia|frankfurt|singapore prod01|stage66|dev80 plan|apply|destroy|taint|show [-var-file=tfvars/<tfvarsfile.tfvars>] [-target=<resource>]"
		echo "Eg. $ ./buildme london dev01 plan -var-file=tfvars/london-dev01-demo1.tfvars -target=aws_instance.instance"
		exit 1
		;;
esac

case $2 in
	dev[0-9][0-9]) 
		;;
	stage[0-9][0-9])
		;;
	prod[0-9][0-9]) 
		;;
	# Add more envs here and update echo usage bit.
	*)
		echo "ENVIRONMENT not defined. Usage: $0 london|ireland|virginia|frankfurt|singapore prod01|stage66|dev80 plan|apply|destroy|taint|show [-var-file=tfvars/<tfvarsfile.tfvars>] [-target=<resource]"
		echo "Eg. $ ./buildme london dev01 plan -var-file=tfvars/london-dev01-demo1.tfvars -target=aws_instance.instance"
		exit 1
		;;
esac

GIT_ROOT="$(git rev-parse --show-toplevel)"
ENVIRONMENT=$2
ENVIRONMENT_VPC="$(git rev-parse --show-prefix | grep -Eo 'vpc-[a-z0-9]*' |cut -d- -f2)"
ENVIRONMENT_GROUP="$(git rev-parse --show-prefix | grep -Eo 'vpc-[a-z0-9]*/group/[a-z0-9_-]*' |cut -d/ -f3)"
ENVIRONMENT_ROLE="$(git rev-parse --show-prefix | grep -Eo 'vpc-[a-z0-9]*/group/[a-z0-9_-]*/role/[a-z0-9_]*' |cut -d/ -f5)"

export AWS_DEFAULT_REGION=$REGION
export TF_VAR_region=$REGION
export TF_VAR_environment=$ENVIRONMENT
export TF_VAR_environment_vpc=$ENVIRONMENT_VPC
export TF_VAR_environment_group=$ENVIRONMENT_GROUP
export TF_VAR_environment_role=$ENVIRONMENT_ROLE
