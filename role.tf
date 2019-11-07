resource "aws_iam_policy" "ec2-web" {
  name = "ken-ec2-web"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
            "s3:GetObject",
            "s3:GetObjectVersion",
            "s3:ListBucket",
            "iam:PassRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
resource "aws_iam_role" "ec2-web-role" {
  name_prefix        = "ken-ec2-web-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
  EOF
}
resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = "${aws_iam_role.ec2-web-role.name}"
  policy_arn = "${aws_iam_policy.ec2-web.arn}"
}
