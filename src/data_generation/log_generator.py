import os
import csv
from faker import Faker

fake = Faker()

log_types = ['system', 'access', 'error']
log_levels = ['INFO', 'WARNING', 'ERROR']

def generate_log_entry():
    return {
        'timestamp': fake.iso8601(),
        'log_level': fake.random_element(log_levels),
        'log_type': fake.random_element(log_types),
        'message': fake.sentence(),
        'user_agent': fake.user_agent()
    }

def generate_logs(num_logs, output_file):
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    with open(output_file, 'w', newline='') as csvfile:
        fieldnames = ['timestamp', 'log_level', 'log_type', 'message', 'user_agent']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        for _ in range(num_logs):
            writer.writerow(generate_log_entry())

if __name__ == "__main__":
    generate_logs(1000, 'data/raw_logs/logs.csv')
