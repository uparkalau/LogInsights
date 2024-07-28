import boto3

def create_cloudwatch_alarm(alarm_name, metric_name, namespace, threshold, comparison_operator, evaluation_periods, sns_topic_arn):
    client = boto3.client('cloudwatch')
    client.put_metric_alarm(
        AlarmName=alarm_name,
        MetricName=metric_name,
        Namespace=namespace,
        Threshold=threshold,
        ComparisonOperator=comparison_operator,
        EvaluationPeriods=evaluation_periods,
        AlarmActions=[sns_topic_arn]
    )

if __name__ == "__main__":
    sns_topic_arn = 'arn:aws:sns:us-west-2:123456789012:MyTopic'
    create_cloudwatch_alarm(
        'KafkaLagAlarm',
        'KafkaLag',
        'AWS/Kafka',
        100,
        'GreaterThanThreshold',
        1,
        sns_topic_arn
    )
