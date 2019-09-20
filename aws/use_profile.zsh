use-profile() {
  export $(awsudo $1 | xargs)
  echo -n "Assumed role: "
  aws sts get-caller-identity | jq .Arn
}
