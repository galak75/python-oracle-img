import os

import cx_Oracle


def print_db_version(db_config):
    with cx_Oracle.connect(
        db_config['username'],
        db_config['password'],
        f"{db_config['host']}:{db_config['port']}/{db_config['name']}",
        encoding='UTF-8'
    ) as conn:
        print(f'Database version: {conn.version}')
        conn.close()


if __name__ == '__main__':
    print(f'LD_LIBRARY_PATH = {os.environ["LD_LIBRARY_PATH"]}')
    print(f'{os.environ["LD_LIBRARY_PATH"]} content: \n{os.listdir(os.environ["LD_LIBRARY_PATH"])}')

    db_config = {
        'host': os.environ['DB_HOST'],
        'port': os.environ['DB_PORT'],
        'name': os.environ['DB_NAME'],
        'username': os.environ['DB_USERNAME'],
        'password': os.environ['DB_PASSWORD'],
    }

    print_db_version(db_config)
