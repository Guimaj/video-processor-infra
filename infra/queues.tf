resource "aws_sqs_queue" "process_queue" {
  name                       = "processQueue"
}

data "aws_iam_policy_document" "process_sqs_policy" {
  statement {
    sid    = "processsqsstatement"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage"
    ]
    resources = [
      aws_sqs_queue.process_queue.arn
    ]
  }
}

resource "aws_sqs_queue_policy" "process_sqs_policy" {
  queue_url = aws_sqs_queue.process_queue.id
  policy    = data.aws_iam_policy_document.process_sqs_policy.json
}

#######################################################
#######################################################

resource "aws_sqs_queue" "status_queue" {
  name                       = "statusQueue"
}

data "aws_iam_policy_document" "status_sqs_policy" {
  statement {
    sid    = "statussqsstatement"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage"
    ]
    resources = [
      aws_sqs_queue.status_queue.arn
    ]
  }
}

resource "aws_sqs_queue_policy" "status_sqs_policy" {
  queue_url = aws_sqs_queue.status_queue.id
  policy    = data.aws_iam_policy_document.status_sqs_policy.json
}